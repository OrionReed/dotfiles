# Dotfiles

Personal development environment setup using Dotbot.

## One-command setup

```bash
# From completely fresh macOS - only needs curl (built-in)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/yourusername/dotfiles/main/bootstrap.sh)"
```

## Manual setup (if you prefer)

```bash
# Clone and run
git clone --recurse-submodules https://github.com/yourusername/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

## What's included

- Zsh with Starship prompt
- Essential dev tools (node, python, pyenv)
- Delta for better git diffs
- Minimal plugins (autosuggestions + syntax highlighting)

Restart terminal after install.
