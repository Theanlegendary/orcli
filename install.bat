@echo off
setlocal EnableDelayedExpansion
:: install.bat — Windows one-click installer for orcli
:: Run this once, then double-click orcli.bat anytime to chat

title orcli Installer

echo.
echo   orcli  v7.0  --  Free AI CLI
echo   ─────────────────────────────
echo.

:: ── Check Python ──────────────────────────────────────────────
python --version >nul 2>&1
if errorlevel 1 (
    echo   [!] Python 3 not found.
    echo.
    echo   Please install Python from:
    echo   https://www.python.org/downloads/
    echo.
    echo   IMPORTANT: Check "Add Python to PATH" during install!
    echo.
    set /p "yn=Open download page now? [Y/n] "
    if /i "!yn!" neq "n" (
        start https://www.python.org/downloads/
    )
    pause
    exit /b 1
)
for /f "tokens=*" %%v in ('python --version 2^>^&1') do echo   OK %%v found

:: ── Create install directory ───────────────────────────────────
set "INSTALL_DIR=%USERPROFILE%\.local\bin"
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"
echo   OK Install dir: %INSTALL_DIR%

:: ── Download orcli ─────────────────────────────────────────────
echo.
echo   Downloading orcli...
powershell -Command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Theanlegendary/orcli/main/orcli' -OutFile '%INSTALL_DIR%\orcli' -UseBasicParsing }"
if not exist "%INSTALL_DIR%\orcli" (
    echo   [!] Download failed. Check your internet connection.
    pause
    exit /b 1
)
echo   OK Downloaded orcli

:: ── Copy orcli.bat to Desktop ─────────────────────────────────
set "DESKTOP=%USERPROFILE%\Desktop"
if exist "%DESKTOP%" (
    :: Copy from same folder as this installer, or download
    if exist "%~dp0orcli.bat" (
        copy /y "%~dp0orcli.bat" "%DESKTOP%\orcli.bat" >nul
    ) else (
        powershell -Command "& { [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Theanlegendary/orcli/main/orcli.bat' -OutFile '%DESKTOP%\orcli.bat' -UseBasicParsing }"
    )
    if exist "%DESKTOP%\orcli.bat" (
        echo   OK Desktop shortcut: %DESKTOP%\orcli.bat
    )
)

:: ── Add to PATH ───────────────────────────────────────────────
echo.
echo   Adding to PATH...
for /f "skip=2 tokens=3*" %%a in ('reg query "HKCU\Environment" /v PATH 2^>nul') do set "USER_PATH=%%a %%b"
echo !USER_PATH! | find /i "%INSTALL_DIR%" >nul
if errorlevel 1 (
    setx PATH "%INSTALL_DIR%;!USER_PATH!" >nul 2>&1
    echo   OK Added %INSTALL_DIR% to user PATH
    echo   NOTE: Open a NEW terminal window for PATH to take effect
) else (
    echo   OK PATH already includes %INSTALL_DIR%
)

:: ── Done ─────────────────────────────────────────────────────
echo.
echo   Installation complete!
echo.
echo   Next steps:
echo     1. Double-click orcli.bat on your Desktop to start
echo     2. Type /auth to set up your free API key
echo     3. Start chatting!
echo.
echo   Get a free key at: https://openrouter.ai/keys
echo.

set /p "yn=Set up API key now? [Y/n] "
if /i "!yn!" neq "n" (
    python "%INSTALL_DIR%\orcli" --auth
)

pause
