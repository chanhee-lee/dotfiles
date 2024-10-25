README Setup

### Dependencies
- `sudo apt install ripgrep` // for telescope live grep
- `apt install node` // for copilot
- `brew install jesseduffield/lazygit/lazygit` // unrelated to nvim

### Stow 
```
apt install stow
cd dotfiles
stow .
```


### Notes for self
When clipboard connection wasn't working with `vim.opt.clipboard:append("unnamedplus")`, 
installing win32yank.exe and adding it to WSL path fixed it.
Note that before installation I was getting `clipboard: No provider`
