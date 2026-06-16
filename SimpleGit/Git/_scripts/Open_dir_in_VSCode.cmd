@echo off

REM ============================================================
REM  Open_dir_in_VSCode.cmd
REM  Opens the specified path(s) in Visual Studio Code.
REM  Launch is async - the script returns immediately, VS Code
REM  runs independently without blocking the caller (e.g. LabVIEW).
REM  Supports 32-bit and 64-bit VS Code. No admin rights required.
REM
REM  Usage:
REM    Open_dir_in_VSCode.cmd [path1] [path2] ...
REM ============================================================

REM --- Locate VS Code executable (no external commands first) ---
set "VSCODE="
if exist "%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe" set "VSCODE=%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe"
if not defined VSCODE if exist "%ProgramW6432%\Microsoft VS Code\Code.exe" set "VSCODE=%ProgramW6432%\Microsoft VS Code\Code.exe"
if not defined VSCODE if exist "%ProgramFiles%\Microsoft VS Code\Code.exe" set "VSCODE=%ProgramFiles%\Microsoft VS Code\Code.exe"
if not defined VSCODE if exist "%ProgramFiles(x86)%\Microsoft VS Code\Code.exe" set "VSCODE=%ProgramFiles(x86)%\Microsoft VS Code\Code.exe"

REM --- Fallback: try the 'code' CLI on PATH ---
if not defined VSCODE (
    where code >nul 2>&1 && set "VSCODE=code"
)

if not defined VSCODE (
    echo ERROR: Visual Studio Code could not be found.
    exit /b 1
)

REM --- Launch VS Code asynchronously ---
REM  Arguments are passed via environment variable to avoid
REM  quoting conflicts when %* contains double-quoted paths.
REM  Caller should quote paths with spaces, e.g.:
REM    Open_dir_in_VSCode.cmd "D:\1 2 3"
if "%~1"=="" (
    powershell -NoProfile -Command "Start-Process '%VSCODE%'"
) else (
    set OPEN_ARGS=%*
    powershell -NoProfile -Command "Start-Process '%VSCODE%' -ArgumentList ([Environment]::GetEnvironmentVariable('OPEN_ARGS','Process'))"
)
exit /b 0
