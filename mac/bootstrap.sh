#!/bin/bash
# Fresh Mac → Chan's setup. Safe to re-run: every step skips what is already done.
#
#   Double-click "Set Up This Mac.command" (from a USB stick or ~/dotfiles/mac), or in Terminal:
#   bash -c "$(curl -fsSL https://raw.githubusercontent.com/chanhee-lee/dotfiles/main/mac/bootstrap.sh)"
#
#   --only=brew,apps   run just these steps      --skip=apps   skip these steps
#   steps: brew apps extras shell runtimes github dotfiles chanos
#
# Interactive points: your Mac password (once), App Store sign-in, GitHub login in the browser.
# Everything else is unattended. A summary of failures and manual steps prints at the end.
set -uo pipefail

RAW="https://raw.githubusercontent.com/chanhee-lee/dotfiles/main/mac"
KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]:-$0}")" 2>/dev/null && pwd)"
ONLY=""; SKIP=""
for arg in "$@"; do
  case "$arg" in
    --only=*) ONLY=",${arg#*=}," ;;
    --skip=*) SKIP=",${arg#*=}," ;;
  esac
done

FAILED=""
say()  { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }
note() { printf '    %s\n' "$*"; }
fail() { printf '    \033[1;31m[failed]\033[0m %s\n' "$*"; FAILED="$FAILED\n  - $*"; }
want() {
  [ -n "$ONLY" ] && { case "$ONLY" in *",$1,"*) ;; *) return 1 ;; esac; }
  case "$SKIP" in *",$1,"*) return 1 ;; esac
  return 0
}
# The Samsung USB from the 2026-10-17 MacBook Air backup, if it is plugged in.
backup_dir() {
  local d
  for d in /Volumes/*/MacBackup-2026-10-17; do [ -d "$d" ] && { echo "$d"; return 0; }; done
  return 1
}

# --- preflight -------------------------------------------------------------------------
[ "$(uname -m)" = "arm64" ] || { echo "This kit expects an Apple Silicon Mac."; exit 1; }
say "Mac setup — you'll be asked for your Mac password once"
sudo -v || exit 1
while true; do sudo -n true; sleep 50; kill -0 "$$" 2>/dev/null || exit; done 2>/dev/null &
caffeinate -dimsu -w $$ &

# --- brew: Homebrew (also installs the Xcode Command Line Tools) -----------------------
if want brew; then
  say "Homebrew"
  if [ -x /opt/homebrew/bin/brew ]; then
    note "already installed"
  else
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
      || { fail "Homebrew install"; exit 1; }
  fi
  grep -qs 'brew shellenv' "$HOME/.zprofile" || echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
fi
[ -x /opt/homebrew/bin/brew ] && eval "$(/opt/homebrew/bin/brew shellenv)"

# --- apps: everything in the Brewfile ---------------------------------------------------
if want apps; then
  say "Apps and CLI tools (Brewfile) — this is the long one"
  BREWFILE="$KIT_DIR/Brewfile"
  if [ ! -f "$BREWFILE" ]; then
    BREWFILE="$(mktemp -d)/Brewfile"
    curl -fsSL "$RAW/Brewfile" -o "$BREWFILE" || { fail "download Brewfile"; BREWFILE=""; }
  fi
  if [ -n "$BREWFILE" ]; then
    if ! [ -d "/Applications/Xcode.app" ] || ! [ -d "/Applications/KakaoTalk.app" ]; then
      note "App Store apps (Xcode, KakaoTalk, Amphetamine…) need you signed in to the App Store."
      open -a "App Store"
      read -r -p "    Sign in to the App Store, then press Enter (or Enter now to skip them)… " _ </dev/tty
    fi
    brew bundle install --file="$BREWFILE" || fail "some Brewfile items (re-run, or: brew bundle check --verbose --file=$BREWFILE)"
  fi
fi

# --- extras: apps Homebrew can't install ------------------------------------------------
# install_gh_dmg <owner/repo> <asset-name regex> <App Name>
install_gh_dmg() {
  local repo="$1" pattern="$2" app="$3" url tmp mnt
  if [ -d "/Applications/$app.app" ]; then note "$app — already installed"; return 0; fi
  url="$(curl -fsSL "https://api.github.com/repos/$repo/releases/latest" \
        | grep -o '"browser_download_url": *"[^"]*"' | sed 's/.*"\(http[^"]*\)"/\1/' \
        | grep -E "$pattern" | head -1)"
  [ -n "$url" ] || { fail "$app — no release asset matching $pattern"; return 1; }
  tmp="$(mktemp -d)"; mnt="$tmp/mnt"
  curl -fsSL "$url" -o "$tmp/app.dmg" \
    && hdiutil attach -nobrowse -quiet -mountpoint "$mnt" "$tmp/app.dmg" \
    && cp -R "$mnt/$app.app" /Applications/ \
    && xattr -dr com.apple.quarantine "/Applications/$app.app" \
    && note "$app — installed" || fail "$app install"
  hdiutil detach -quiet "$mnt" 2>/dev/null; rm -rf "$tmp"
}
if want extras; then
  say "Apps from GitHub releases"
  install_gh_dmg alacritty/alacritty '/Alacritty-v[0-9.]+\.dmg$' "Alacritty"   # brew cask disabled 2026-09
  install_gh_dmg rullerzhou-afk/clawd-on-desk 'arm64\.dmg$' "Clawd on Desk"
fi

# --- shell: oh-my-zsh, tmux plugin manager ----------------------------------------------
if want shell; then
  say "Shell"
  if [ -d "$HOME/.oh-my-zsh" ]; then note "oh-my-zsh — already installed"
  else
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended \
      || fail "oh-my-zsh"
  fi
  [ -d "$HOME/.tmux/plugins/tpm" ] || git clone -q https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm" || fail "tpm"
fi

# --- runtimes: npm/pipx globals, Rust + recon, pyenv, maestro ---------------------------
if want runtimes; then
  say "Language runtimes and global packages"
  for p in @github/copilot @googleworkspace/cli @tobilu/qmd @tbrgeek/spotify-mcp-server eslint_d \
           firebase-tools pnpm typescript typescript-language-server uipro-cli vercel; do
    npm ls -g --depth=0 "$p" >/dev/null 2>&1 && continue
    npm install -g --silent "$p" && note "npm: $p" || fail "npm -g $p"
  done
  for p in graphifyy poetry; do
    pipx list --short 2>/dev/null | grep -q "^$p " && continue
    pipx install "$p" >/dev/null && note "pipx: $p" || fail "pipx $p"
  done
  if [ ! -x "$HOME/.cargo/bin/cargo" ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path >/dev/null || fail "rustup"
  fi
  # shellcheck source=/dev/null
  [ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
  command -v recon >/dev/null || cargo install -q --git https://github.com/gavraz/recon || fail "cargo install recon"
  if command -v pyenv >/dev/null; then
    pyenv install -s 3.11.3 || fail "pyenv 3.11.3"
    pyenv versions --bare | grep -qx venv || pyenv virtualenv 3.11.3 venv || fail "pyenv virtualenv venv"
  fi
  [ -x "$HOME/.maestro/bin/maestro" ] || curl -fsSL https://get.maestro.mobile.dev | bash >/dev/null || fail "maestro"
fi

# --- github: SSH keys + gh login --------------------------------------------------------
if want github; then
  say "GitHub"
  mkdir -p "$HOME/.ssh"; chmod 700 "$HOME/.ssh"
  if [ ! -f "$HOME/.ssh/id_ed25519" ] && B="$(backup_dir)" && [ -d "$B/home/.ssh" ]; then
    cp -Rn "$B/home/.ssh/" "$HOME/.ssh/"
    find "$HOME/.ssh" -type f ! -name '*.pub' ! -name 'known_hosts*' ! -name config -exec chmod 600 {} +
    note "restored ~/.ssh from $B"
  fi
  grep -qs '^github.com ' "$HOME/.ssh/known_hosts" || ssh-keyscan -t ed25519 github.com >> "$HOME/.ssh/known_hosts" 2>/dev/null
  if gh auth status >/dev/null 2>&1; then note "gh — already logged in"
  else
    note "Log in as chanhee-lee. If asked, let gh upload (or generate) your SSH key."
    gh auth login -h github.com -p ssh -w </dev/tty || fail "gh auth login"
  fi
fi

# --- dotfiles: clone + stow -------------------------------------------------------------
if want dotfiles; then
  say "Dotfiles"
  [ -d "$HOME/dotfiles/.git" ] || git clone -q git@github.com:chanhee-lee/dotfiles.git "$HOME/dotfiles" \
    || git clone -q https://github.com/chanhee-lee/dotfiles.git "$HOME/dotfiles" || fail "clone dotfiles"
  if [ -d "$HOME/dotfiles" ]; then
    # Move app-generated defaults out of stow's way (kept as *.pre-dotfiles).
    for f in .zshrc .gitconfig .tmux.conf .aerospace.toml .config/alacritty .config/git .config/lazygit .config/nvim; do
      if [ -e "$HOME/$f" ] && [ ! -L "$HOME/$f" ]; then mv "$HOME/$f" "$HOME/$f.pre-dotfiles"; note "moved aside ~/$f"; fi
    done
    mkdir -p "$HOME/.config"
    stow -d "$HOME/dotfiles" -t "$HOME" . && note "stowed" || fail "stow dotfiles"
    touch "$HOME/.zshrc.local"
  fi
fi

# --- chanos: clone the config repo, then hand off to its private bootstrap ---------------
if want chanos; then
  say "chanOS"
  [ -d "$HOME/chanos/.git" ] || git clone -q git@github.com:chanhee-lee/chanos.git "$HOME/chanos" || fail "clone chanos"
  if [ -x "$HOME/chanos/scripts/chanos-bootstrap" ]; then
    "$HOME/chanos/scripts/chanos-bootstrap" || fail "chanos-bootstrap (re-run: ~/chanos/scripts/chanos-bootstrap)"
  else
    fail "~/chanos/scripts/chanos-bootstrap missing — pull chanos and re-run with --only=chanos"
  fi
fi

# --- summary ----------------------------------------------------------------------------
say "Done"
if [ -n "$FAILED" ]; then printf '\033[1;31mFailed (re-running the kit retries these):\033[0m%b\n' "$FAILED"; fi
cat <<'EOF'

Still manual (no installer to script):
  - Alt (meeting recorder), Claude Status, Redact — download from their sites
  - Korean banking/gov security tools (TouchEn nxKey, nProtect, CrossEX) — only when a site asks
  - Raycast: Settings → Import (from the old Mac's export) · KakaoTalk: restore chat backup
Log in once: Apple ID/iCloud, browsers (Chrome/Arc/Brave), Slack, Notion, Google Drive, OneDrive,
  Docker, Tailscale, Spotify, Figma, Obsidian (open ~/orichalcum as vault),
  gcloud auth login, firebase login, vercel login, gws auth setup
Open a new terminal (or Alacritty) so the shell picks everything up.
EOF
