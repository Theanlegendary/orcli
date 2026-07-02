@echo off
:: orcli.bat — Double-click to launch orcli on Windows
:: Place this anywhere, double-click = instant AI chat

title orcli — AI Chat

:: Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo.
    echo   Python 3 not found.
    echo   Download from https://python.org/downloads
    echo.
    pause
    exit /b 1
)

:: Check if orcli script exists next to this .bat
set "SCRIPT_DIR=%~dp0"
set "ORCLI_PY=%SCRIPT_DIR%orcli"

if not exist "%ORCLI_PY%" (
    :: Try common install location
    set "ORCLI_PY=%USERPROFILE%\.local\bin\orcli"
)

if not exist "%ORCLI_PY%" (
    echo.
    echo   orcli not found. Running installer...
    echo.
    :: Download orcli from GitHub
    powershell -Command "& {Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Theanlegendary/orcli/main/orcli' -OutFile '%USERPROFILE%\.local\bin\orcli'}" 2>nul
    if not exist "%USERPROFILE%\.local\bin\orcli" (
        echo   Download failed. Please run install.bat first.
        pause
        exit /b 1
    )
    set "ORCLI_PY=%USERPROFILE%\.local\bin\orcli"
)

:: Load API key from orcli config if not set
if "%OPENROUTER_API_KEY%"=="" (
    for /f "tokens=2 delims=:" %%a in ('findstr /i "api_key" "%USERPROFILE%\.orcli-config.json" 2^>nul') do (
        set "OPENROUTER_API_KEY=%%~a"
        set "OPENROUTER_API_KEY=!OPENROUTER_API_KEY: =!"
        set "OPENROUTER_API_KEY=!OPENROUTER_API_KEY:"=!"
        set "OPENROUTER_API_KEY=!OPENROUTER_API_KEY:,=!"
    )
)

cls
python "%ORCLI_PY%" %*
if errorlevel 1 pause
