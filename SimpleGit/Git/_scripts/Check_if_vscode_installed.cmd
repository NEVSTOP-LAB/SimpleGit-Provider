@echo off
REM ============================================================
REM  Check_if_vscode_installed.cmd
REM  Detects whether Visual Studio Code is installed locally.
REM  Works on 32-bit and 64-bit Windows, and whether launched
REM  from a 32-bit or 64-bit host (e.g. LabVIEW).
REM
REM  Performance: uses a path cache (%TEMP%\sg-vscode.cache)
REM  to avoid repeated disk scans. Zero external commands.
REM
REM  Output : prints TRUE  if VS Code is found
REM           prints FALSE if VS Code is not found
REM  Exit   : 0 = installed (TRUE), 1 = not installed (FALSE)
REM ============================================================

REM --- Fast path: cached VS Code location (avoids repeated disk scans) ---
if exist "%TEMP%\sg-vscode.cache" (
    set /p VSCODE=<"%TEMP%\sg-vscode.cache"
    if exist "%VSCODE%" (
        echo TRUE
        exit /b 0
    )
)

REM --- Try standard install locations (pure 'if exist', no external commands) ---
REM  1) User install (most common, 64-bit)
if exist "%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe" (
    echo TRUE
    exit /b 0
)
REM  2) System-wide install (64-bit, WOW64-safe via %ProgramW6432%)
if exist "%ProgramW6432%\Microsoft VS Code\Code.exe" (
    echo TRUE
    exit /b 0
)
REM  3) System-wide install (64-bit, %ProgramFiles% differs from %ProgramW6432% only under 32-bit caller)
if not "%ProgramFiles%"=="%ProgramW6432%" (
    if exist "%ProgramFiles%\Microsoft VS Code\Code.exe" (
        echo TRUE
        exit /b 0
    )
)

echo FALSE
exit /b 1
