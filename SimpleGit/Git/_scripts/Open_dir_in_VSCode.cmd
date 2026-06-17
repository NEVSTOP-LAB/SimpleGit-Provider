@echo off

REM ============================================================
REM  Open_dir_in_VSCode.cmd
REM  Opens paths in VS Code (async, non-blocking).
REM  Zero external commands — works even in constrained
REM  environments (e.g. LabVIEW System Exec).
REM
REM  Performance: uses a path cache (%TEMP%\sg-vscode.cache)
REM  to avoid repeated disk scans on frequent invocations.
REM  Cache miss fallback: 3 direct 'if exist' checks.
REM
REM  Usage:
REM    Open_dir_in_VSCode.cmd [path1] [path2] ...
REM    Quote paths with spaces:  "D:\1 2 3"
REM ============================================================

REM --- Fast path: cached VS Code location (avoids repeated disk scans) ---
if exist "%TEMP%\sg-vscode.cache" (
    set /p VSCODE=<"%TEMP%\sg-vscode.cache"
    if exist "%VSCODE%" (
        start "" "%VSCODE%" %*
        exit /b 0
    )
    REM Cache stale — delete and fall through to full scan
    del "%TEMP%\sg-vscode.cache" >nul 2>&1
)

REM --- Try standard install locations (pure 'if exist', no external commands) ---
REM  1) User install (most common, 64-bit)
if exist "%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe" (
    >"%TEMP%\sg-vscode.cache" echo %LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe
    start "" "%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe" %*
    exit /b 0
)
REM  2) System-wide install (64-bit, WOW64-safe via %ProgramW6432%)
if exist "%ProgramW6432%\Microsoft VS Code\Code.exe" (
    >"%TEMP%\sg-vscode.cache" echo %ProgramW6432%\Microsoft VS Code\Code.exe
    start "" "%ProgramW6432%\Microsoft VS Code\Code.exe" %*
    exit /b 0
)
REM  3) System-wide install (64-bit, %ProgramFiles% differs from %ProgramW6432% only under 32-bit caller)
if not "%ProgramFiles%"=="%ProgramW6432%" (
    if exist "%ProgramFiles%\Microsoft VS Code\Code.exe" (
        >"%TEMP%\sg-vscode.cache" echo %ProgramFiles%\Microsoft VS Code\Code.exe
        start "" "%ProgramFiles%\Microsoft VS Code\Code.exe" %*
        exit /b 0
    )
)

echo ERROR: Visual Studio Code could not be found.
exit /b 1
