export ZSH="$HOME/.oh-my-zsh"

export EDITOR=nvim
export VISUAL=nvim

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
export PKG_CONFIG_PATH="/opt/homebrew/opt/mysql-client/lib/pkgconfig:$PKG_CONFIG_PATH"

export PATH="$PATH:/Users/chan/.local/bin"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[ -s "/Users/chan/.bun/_bun" ] && source "/Users/chan/.bun/_bun"

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Font switcher for Alacritty (hot-reloads, no restart needed)
font-switch() {
  local config="$HOME/dotfiles/.config/alacritty/alacritty.toml"
  local family
  case "$1" in
    maple)   family="Maple Mono NF" ;;
    krypton) family="Monaspace Krypton NF" ;;
    commit)  family="CommitMono Nerd Font" ;;
    jbm)     family="JetBrainsMono Nerd Font" ;;
    *)
      echo "Usage: font-switch [maple|krypton|commit|jbm]"
      echo "  maple   → Maple Mono NF"
      echo "  krypton → Monaspace Krypton NF (Texture Healing)"
      echo "  commit  → CommitMono Nerd Font (Smart Kerning)"
      echo "  jbm     → JetBrainsMono Nerd Font (current default)"
      return 1
      ;;
  esac
  sed -i '' "s/family = \"[^\"]*\"/family = \"$family\"/" "$config"
  echo "→ $family"
}

# Incognito Claude: claude-mem disabled for this session, auto-memory readable but frozen
# (CLAUDE_MEM_DATA_DIR doesn't isolate — hooks still reach the shared worker on port 37701)
claude-incog() {
  claude --settings '{
    "enabledPlugins":{"claude-mem@thedotmack":false},
    "permissions":{"deny":["Edit(~/.claude/projects/**/memory/**)","Bash(*memory/*)"]}
  }' "$@"
}

# t: attach to the running tmux, or start it. On a fresh start tmux-continuum restores the saved
# sessions (adoc, misc), and tmux-resurrect then removes the startup session "0" and switches
# the client into a restored one (restore.sh handle_session_0), so no empty session is left.
t() { tmux attach 2>/dev/null || tmux; }

# mini: SSH to the Mac mini straight into its tmux session "laptop", created if missing. Work
# there survives this laptop closing, and tmux-resurrect replays this ssh command on restore,
# which reattaches. tmux needs its full path: it isn't on PATH for remote commands.
mini() { ssh -t chanhee@100.71.90.86 /opt/homebrew/bin/tmux new -A -s laptop; }
export PATH=$PATH:$HOME/.maestro/bin
