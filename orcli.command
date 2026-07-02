#!/bin/zsh
# orcli.command — Double-click this in Finder to open orcli
# Mac equivalent of a .bat file shortcut

# Load shell environment (picks up API key from .zshrc)
source "$HOME/.zshrc" 2>/dev/null || true
source "$HOME/.bash_profile" 2>/dev/null || true

# Clear the screen for a clean start
clear

# Run orcli
exec orcli "$@"
