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

# Incognito Claude: claude-mem observations discarded, auto-memory readable but frozen
claude-incog() {
  CLAUDE_MEM_DATA_DIR=$(mktemp -d) claude \
    --settings '{"permissions":{"deny":["Edit(~/.claude/projects/**/memory/**)"]}}' "$@"
}
