# orcli

**Free AI chat in your terminal — Messenger-style**

> One file. No dependencies. Just Python 3 + a free OpenRouter key.

![orcli screenshot](https://img.shields.io/badge/orcli-v7.0-5294e2?style=flat-square) ![python](https://img.shields.io/badge/python-3.7+-150?style=flat-square) ![free](https://img.shields.io/badge/AI-free%20models-8dc63f?style=flat-square)

---

## Install

### 🍎 macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/Theanlegendary/orcli/main/install.sh | zsh
```

Then:
```bash
orcli --auth    # set up your free API key
orcli           # start chatting
```

Or **double-click `orcli.command`** on your Desktop.

---

### 🪟 Windows

1. Make sure **Python 3** is installed → [python.org/downloads](https://python.org/downloads)  
   *(check "Add Python to PATH" during install)*

2. Download and run **[install.bat](https://raw.githubusercontent.com/Theanlegendary/orcli/main/install.bat)**

3. **Double-click `orcli.bat`** on your Desktop → instant AI chat!

Or manually in PowerShell:
```powershell
# Download orcli
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Theanlegendary/orcli/main/orcli" -OutFile "$env:USERPROFILE\.local\bin\orcli"
# Download launcher
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Theanlegendary/orcli/main/orcli.bat" -OutFile "$env:USERPROFILE\Desktop\orcli.bat"
# Set up API key
python "$env:USERPROFILE\.local\bin\orcli" --auth
```

---

## Quick Start

```
orcli                  # start chatting
orcli "explain git"    # one-shot question
cat error.log | orcli  # pipe text to AI (Mac/Linux)
type error.log | python orcli  # pipe text to AI (Windows)
```

Get a free API key at → **https://openrouter.ai/keys**

---

## Commands (type inside chat)

| Command | What it does |
|---------|-------------|
| `/auth` | Set up or change your API key |
| `/model` | Browse & switch free AI models |
| `/file path` | Share a file with the AI |
| `/resume` | Continue a past conversation |
| `/mode auto` | Auto-run code without asking |
| `/theme NAME` | Switch color theme |
| `/credits` | Check your credit balance |
| `/save` | Save current chat |
| `/clear` | Start a new conversation |
| `/retry` | Retry with the next model |
| `/exit` | Quit |

---

## Features

- 🆓 **Free** — uses OpenRouter's free model tier (20+ models)
- 💬 **Messenger-style UI** — clean, borderless, easy to read
- 🔄 **Auto-switch** — seamlessly moves to next model if rate-limited
- 🧠 **Thinking mode** — shows AI reasoning for deep models (DeepSeek R1, etc.)
- ⚡ **Local execution** — runs bash/python code blocks locally with permission
- 📂 **Directory tracking** — `cd` commands persist across your session
- 💾 **Auto-save** — chats saved to `~/.orcli-history/`
- 🔁 **Resume** — pick up any past conversation
- 📎 **File sharing** — `/file mycode.py` to share files with AI
- 🎨 **Themes** — dracula, nord, monokai, cyberpunk, ark

---

## Themes

```bash
/theme ark       # cool blue-grey (default)
/theme dracula   # purple & pink
/theme nord      # icy blue
/theme monokai   # warm classic
/theme cyberpunk # neon
```

---

## Requirements

- macOS / Linux
- Python 3.7+
- Free OpenRouter account → https://openrouter.ai

---

## Manual Install

```bash
mkdir -p ~/.local/bin
curl -fsSL https://raw.githubusercontent.com/Theanlegendary/orcli/main/orcli -o ~/.local/bin/orcli
chmod +x ~/.local/bin/orcli
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
orcli --auth
```

---

Made with ❤️ by [@Theanlegendary](https://github.com/Theanlegendary)
