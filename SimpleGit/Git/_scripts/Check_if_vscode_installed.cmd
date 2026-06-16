@echo off
REM ============================================================
REM  Check_if_vscode_installed.cmd
REM  Detects whether Visual Studio Code is installed locally.
REM  Works on 32-bit and 64-bit Windows, and whether launched from a
REM  32-bit or 64-bit host (e.g. LabVIEW). No admin rights required.
REM  Output : prints TRUE  if VS Code is found
REM           prints FALSE if VS Code is not found
REM  Exit   : 0 = installed (TRUE), 1 = not installed (FALSE)
REM ============================================================
setlocal EnableDelayedExpansion

set "FOUND=FALSE"

REM --- 1) Is the "code" command available on PATH? ---
where code >nul 2>&1
if !errorlevel! equ 0 set "FOUND=TRUE"

REM --- 2) Check the standard installation locations ---
REM  %ProgramW6432% always resolves to the real 64-bit "Program Files",
REM  even from a 32-bit process under WOW64 redirection.
if "!FOUND!"=="FALSE" if exist "%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe" set "FOUND=TRUE"
if "!FOUND!"=="FALSE" if exist "%ProgramW6432%\Microsoft VS Code\Code.exe" set "FOUND=TRUE"
if "!FOUND!"=="FALSE" if exist "%ProgramFiles%\Microsoft VS Code\Code.exe" set "FOUND=TRUE"
if "!FOUND!"=="FALSE" if exist "%ProgramFiles(x86)%\Microsoft VS Code\Code.exe" set "FOUND=TRUE"

REM --- 3) Check the registry uninstall entries (system + user) ---
REM  Query both the 64-bit (/reg:64) and 32-bit (/reg:32) registry views so
REM  a 64-bit system install is still seen when run from a 32-bit process.
if "!FOUND!"=="FALSE" (
    reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{EA457B21-F73E-494C-ACAB-524FDE069978}_is1" /reg:64 >nul 2>&1
    if !errorlevel! equ 0 set "FOUND=TRUE"
)
if "!FOUND!"=="FALSE" (
    reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{EA457B21-F73E-494C-ACAB-524FDE069978}_is1" /reg:32 >nul 2>&1
    if !errorlevel! equ 0 set "FOUND=TRUE"
)
if "!FOUND!"=="FALSE" (
    reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{771FD6B0-FA20-440A-A002-3B3BAC16DC50}_is1" /reg:64 >nul 2>&1
    if !errorlevel! equ 0 set "FOUND=TRUE"
)
if "!FOUND!"=="FALSE" (
    reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{771FD6B0-FA20-440A-A002-3B3BAC16DC50}_is1" /reg:32 >nul 2>&1
    if !errorlevel! equ 0 set "FOUND=TRUE"
)

echo !FOUND!

if "!FOUND!"=="TRUE" (
    endlocal & exit /b 0
) else (
    endlocal & exit /b 1
)
