# Mac setup kit

Fresh Mac (Apple Silicon) → full setup in one run. Safe to re-run; it skips whatever is already there.

## Run it

**From a USB stick:** copy this `mac/` folder onto the stick, plug it into the new Mac, double-click
**Set Up This Mac.command**. If macOS blocks it, right-click → Open.

**Or with no stick**, in Terminal:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/chanhee-lee/dotfiles/main/mac/bootstrap.sh)"
```

If the Samsung backup USB (`MacBackup-2026-10-17/`) is plugged in too, the kit restores `~/.ssh`,
chanOS secrets, and Claude memory from it. Without it, `gh` makes a new SSH key for you.

You get asked three times: your Mac password, App Store sign-in, GitHub login in the browser.

## What it does

| Step | What |
|---|---|
| `brew` | Homebrew (installs the Xcode Command Line Tools too) |
| `apps` | everything in `Brewfile` — CLI tools, fonts, apps, App Store apps |
| `extras` | Alacritty and Clawd on Desk from GitHub releases (no working brew cask) |
| `shell` | oh-my-zsh, tmux plugin manager |
| `runtimes` | npm / pipx globals, Rust + `recon`, pyenv 3.11.3 + `venv`, Maestro |
| `github` | SSH keys, `gh auth login` |
| `dotfiles` | clone this repo, `stow` it (old files kept as `*.pre-dotfiles`) |
| `chanos` | clone `chanos`, then run its private `scripts/chanos-bootstrap` (data repos, vaults, code repos, `install.sh`, qmd) |

Run some steps only: `./bootstrap.sh --only=apps,extras` · skip some: `--skip=runtimes`.

## Still manual

Alt, Claude Status, Redact, Korean banking security tools — no installer to script. App logins
(Slack, Notion, Google, Docker, Tailscale…) — the kit prints the list at the end.
