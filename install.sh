#!/bin/zsh
# install.sh — One-command installer for orcli
# Usage: curl -fsSL https://raw.githubusercontent.com/Theanlegendary/orcli/main/install.sh | zsh
# Or: ./install.sh

set -e

BOLD="\033[1m"
CYAN="\033[38;5;110m"
GREEN="\033[38;5;150m"
RED="\033[38;5;203m"
MUTED="\033[38;5;244m"
RST="\033[0m"

say()  { echo -e "${CYAN}  $1${RST}"; }
ok()   { echo -e "${GREEN}  ✓ $1${RST}"; }
err()  { echo -e "${RED}  ✗ $1${RST}"; exit 1; }
info() { echo -e "${MUTED}  $1${RST}"; }

echo ""
echo -e "${BOLD}${CYAN}  orcli${RST}${MUTED}  v7.0  —  Free AI CLI${RST}"
echo -e "${MUTED}  ─────────────────────────────${RST}"
echo ""

# Check Python 3
if ! command -v python3 &>/dev/null; then
    err "Python 3 is required. Install from https://python3.org"
fi
PY=$(python3 --version 2>&1)
ok "Found $PY"

# Install orcli to ~/.local/bin
INSTALL_DIR="$HOME/.local/bin"
mkdir -p "$INSTALL_DIR"

say "Downloading orcli..."
if command -v curl &>/dev/null; then
    curl -fsSL "https://raw.githubusercontent.com/Theanlegendary/orcli/main/orcli" -o "$INSTALL_DIR/orcli"
elif command -v wget &>/dev/null; then
    wget -qO "$INSTALL_DIR/orcli" "https://raw.githubusercontent.com/Theanlegendary/orcli/main/orcli"
else
    # Fallback: copy from current dir if run locally
    if [ -f "./orcli" ]; then
        cp "./orcli" "$INSTALL_DIR/orcli"
    else
        err "curl or wget required for download"
    fi
fi

chmod +x "$INSTALL_DIR/orcli"
ok "Installed → $INSTALL_DIR/orcli"

# Install .command shortcut to Desktop
say "Installing Desktop shortcut (orcli.command)..."
SHORTCUT_SRC="https://raw.githubusercontent.com/Theanlegendary/orcli/main/orcli.command"
DESKTOP="$HOME/Desktop"

if [ -d "$DESKTOP" ]; then
    if command -v curl &>/dev/null; then
        curl -fsSL "$SHORTCUT_SRC" -o "$DESKTOP/orcli.command" 2>/dev/null || \
            cp "$(dirname "$0")/orcli.command" "$DESKTOP/orcli.command" 2>/dev/null || true
    fi
    if [ -f "$DESKTOP/orcli.command" ]; then
        chmod +x "$DESKTOP/orcli.command"
        ok "Desktop shortcut → $DESKTOP/orcli.command"
    fi
else
    info "No Desktop folder found, skipping shortcut"
fi

# Add ~/.local/bin to PATH if missing
SHELL_NAME=$(basename "$SHELL")
RC_FILE="$HOME/.zshrc"
[ "$SHELL_NAME" = "bash" ] && RC_FILE="$HOME/.bashrc"

if ! echo "$PATH" | grep -q "$INSTALL_DIR"; then
    echo "" >> "$RC_FILE"
    echo "# orcli" >> "$RC_FILE"
    echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> "$RC_FILE"
    ok "Added ~/.local/bin to PATH in $RC_FILE"
    info "Run: source $RC_FILE"
else
    ok "PATH already includes ~/.local/bin"
fi

echo ""
say "Setup complete!"
echo ""
info "Next steps:"
info "  1. source $RC_FILE   (or open a new terminal)"
info "  2. orcli --auth      (set your OpenRouter API key)"
info "  3. orcli             (start chatting)"
info ""
info "  Or double-click orcli.command on your Desktop"
echo ""
