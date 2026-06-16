@echo off

REM ============================================================
REM  Open_dir_in_VSCode.cmd
REM  Opens paths in VS Code (async, non-blocking).
REM  Zero external commands — works even in constrained
REM  environments (e.g. LabVIEW System Exec).
REM  Supports 32/64-bit VS Code. No admin rights.
REM
REM  Usage:
REM    Open_dir_in_VSCode.cmd [path1] [path2] ...
REM    Quote paths with spaces:  "D:\1 2 3"
REM ============================================================

REM --- Try standard install locations (pure 'if exist', no external commands) ---
if exist "%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe" (
    start "" "%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe" %*
    exit /b 0
)
if exist "%ProgramW6432%\Microsoft VS Code\Code.exe" (
    start "" "%ProgramW6432%\Microsoft VS Code\Code.exe" %*
    exit /b 0
)
if exist "%ProgramFiles%\Microsoft VS Code\Code.exe" (
    start "" "%ProgramFiles%\Microsoft VS Code\Code.exe" %*
    exit /b 0
)
if exist "%ProgramFiles(x86)%\Microsoft VS Code\Code.exe" (
    start "" "%ProgramFiles(x86)%\Microsoft VS Code\Code.exe" %*
    exit /b 0
)

echo ERROR: Visual Studio Code could not be found.
exit /b 1
