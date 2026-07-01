# dotfiles

## Mac setup

### 1. Install Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install tools
```bash
# Shell
brew install stow

# Terminal & window management
brew install --cask alacritty
brew install --cask aerospace

# Editor
brew install neovim
brew install ripgrep        # telescope live grep
brew install node           # copilot

# Git
brew install jesseduffield/lazygit/lazygit

# Multiplexer
brew install tmux
```

### 3. Install oh-my-zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 4. Stow dotfiles
```bash
cd ~/dotfiles
stow .
```

If you hit conflicts (app-generated defaults), remove them first:
```bash
rm -rf ~/.config/alacritty ~/.config/nvim ~/.config/kitty ~/.config/lazygit
stow .
```

### 5. Create ~/.zshrc.local for secrets
```bash
touch ~/.zshrc.local
# Add any tokens/secrets here — this file is gitignored
```

### 6. Tmux plugins
Open tmux, then press `prefix + I` to install plugins via tpm.

### 7. Neovim plugins
Open nvim — lazy.nvim will auto-install plugins on first launch.
