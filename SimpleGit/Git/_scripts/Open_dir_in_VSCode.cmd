@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM ============================================================
REM  Open_dir_in_VSCode.cmd
REM  Opens the specified path(s) in Visual Studio Code.
REM  If no path is provided, opens VS Code with no folder.
REM  Supports both 32-bit and 64-bit VS Code installations,
REM  regardless of whether this script is launched from a 32-bit
REM  or 64-bit host (e.g. LabVIEW).
REM
REM  Usage:
REM    Open_dir_in_VSCode.cmd [path1] [path2] ...
REM ============================================================

REM --- Locate VS Code executable ---
set "CODE_EXE="

REM 1) Is the "code" command available on PATH?
where code >nul 2>&1
if !errorlevel! equ 0 set "CODE_EXE=code"

REM 2) Check the standard installation locations
REM  %LOCALAPPDATA%  -> user install (per-user)
REM  %ProgramW6432%  -> always the real 64-bit Program Files, even from WOW64
REM  %ProgramFiles%  -> 64-bit Program Files (redirected under WOW64)
REM  %ProgramFiles(x86)% -> 32-bit Program Files
if "!CODE_EXE!"=="" if exist "%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe" set "CODE_EXE=%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe"
if "!CODE_EXE!"=="" if exist "%ProgramW6432%\Microsoft VS Code\Code.exe" set "CODE_EXE=%ProgramW6432%\Microsoft VS Code\Code.exe"
if "!CODE_EXE!"=="" if exist "%ProgramFiles%\Microsoft VS Code\Code.exe" set "CODE_EXE=%ProgramFiles%\Microsoft VS Code\Code.exe"
if "!CODE_EXE!"=="" if exist "%ProgramFiles(x86)%\Microsoft VS Code\Code.exe" set "CODE_EXE=%ProgramFiles(x86)%\Microsoft VS Code\Code.exe"

REM 3) Check the registry uninstall entries (system + user, both reg views)
if "!CODE_EXE!"=="" (
    for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{EA457B21-F73E-494C-ACAB-524FDE069978}_is1" /reg:64 /v "DisplayIcon" 2^>nul ^| find "REG_"') do set "CODE_PATH=%%b"
    if not "!CODE_PATH!"=="" if exist "!CODE_PATH!" set "CODE_EXE=!CODE_PATH!"
)
if "!CODE_EXE!"=="" (
    for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{EA457B21-F73E-494C-ACAB-524FDE069978}_is1" /reg:32 /v "DisplayIcon" 2^>nul ^| find "REG_"') do set "CODE_PATH=%%b"
    if not "!CODE_PATH!"=="" if exist "!CODE_PATH!" set "CODE_EXE=!CODE_PATH!"
)
if "!CODE_EXE!"=="" (
    for /f "tokens=2*" %%a in ('reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{771FD6B0-FA20-440A-A002-3B3BAC16DC50}_is1" /reg:64 /v "DisplayIcon" 2^>nul ^| find "REG_"') do set "CODE_PATH=%%b"
    if not "!CODE_PATH!"=="" if exist "!CODE_PATH!" set "CODE_EXE=!CODE_PATH!"
)
if "!CODE_EXE!"=="" (
    for /f "tokens=2*" %%a in ('reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{771FD6B0-FA20-440A-A002-3B3BAC16DC50}_is1" /reg:32 /v "DisplayIcon" 2^>nul ^| find "REG_"') do set "CODE_PATH=%%b"
    if not "!CODE_PATH!"=="" if exist "!CODE_PATH!" set "CODE_EXE=!CODE_PATH!"
)

if "!CODE_EXE!"=="" (
    echo ERROR: Visual Studio Code could not be found.
    exit /b 1
)

REM --- Launch VS Code ---
REM  If no arguments are provided, open VS Code without a folder.
REM  Otherwise, open all supplied paths.

if "%~1"=="" (
    start "" "!CODE_EXE!"
    exit /b 0
)

REM Collect all arguments into a single list, preserving quoting
set "ARGS="
:collect
if not "%~1"=="" (
    set "ARGS=!ARGS! "%~1""
    shift
    goto :collect
)

start "" "!CODE_EXE!" !ARGS!
endlocal & exit /b 0
