# dotfiles

## Mac setup

### 1. Install Homebrew
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install tools
```bash
brew install stow neovim ripgrep node tmux
brew install jesseduffield/lazygit/lazygit
brew install --cask alacritty aerospace
```

### 3. Install oh-my-zsh
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 4. Set up SSH key for GitHub
```bash
ssh-keygen -t ed25519 -C "your@email.com"
cat ~/.ssh/id_ed25519.pub  # add this to GitHub → Settings → SSH keys
ssh -T git@github.com      # verify
```

### 5. Clone dotfiles
```bash
git clone git@github.com:chanhee-lee/dotfiles.git ~/dotfiles
```

### 6. Remove app-generated defaults that conflict with stow
```bash
rm ~/.zshrc
rm -rf ~/.config/alacritty ~/.config/nvim ~/.config/lazygit
```

### 7. Stow dotfiles
```bash
cd ~/dotfiles
stow .
```

### 8. Create ~/.zshrc.local for secrets
```bash
touch ~/.zshrc.local
# Add any tokens/secrets here — this file is gitignored
```

### 9. Tmux plugins
Open tmux, then press `prefix + I` to install plugins via tpm.

### 10. Neovim plugins
Open nvim — lazy.nvim will auto-install plugins on first launch.
