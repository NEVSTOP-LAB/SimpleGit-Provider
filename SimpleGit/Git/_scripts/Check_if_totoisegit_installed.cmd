@echo off

rem ============================================================================
rem  Check_if_totoisegit_installed.cmd
rem  ---------------------------------------------------------------------------
rem  Detect whether Git and/or TortoiseGit are installed on this machine.
rem
rem  Usage:
rem    Check_if_totoisegit_installed.cmd               Check BOTH (Git + TortoiseGit)
rem    Check_if_totoisegit_installed.cmd git           Check Git only
rem    Check_if_totoisegit_installed.cmd tortoisegit   Check TortoiseGit only
rem
rem  Output (stdout):  TRUE   -> installed
rem                     FALSE  -> not installed
rem  Exit code:        0 = TRUE (installed)    1 = FALSE (not installed)
rem ============================================================================

set "target=%~1"
if "%target%"=="" set "target=all"

set "GIT=FALSE"
set "TGIT=FALSE"

call :CheckGit
call :CheckTortoiseGit

set "RESULT=FALSE"
if /i "%target%"=="git"      set "RESULT=%GIT%"
if /i "%target%"=="tortoisegit" set "RESULT=%TGIT%"
if /i "%target%"=="tgit"     set "RESULT=%TGIT%"
if /i "%target%"=="all" (
    if "%GIT%"=="TRUE" if "%TGIT%"=="TRUE" set "RESULT=TRUE"
)

echo %RESULT%

if "%RESULT%"=="TRUE" (exit /b 0) else (exit /b 1)


rem ---------------------------------------------------------------------------
rem  :CheckGit  -> sets GIT=TRUE when Git is found
rem ---------------------------------------------------------------------------
:CheckGit
rem 1) git.exe available on PATH
where git >nul 2>&1
if not errorlevel 1 (
    set "GIT=TRUE"
    goto :eof
)
rem 2) Git for Windows registry keys (64-bit view)
reg query "HKLM\SOFTWARE\GitForWindows" /v InstallPath >nul 2>&1
if not errorlevel 1 (
    set "GIT=TRUE"
    goto :eof
)
rem 2b) Git for Windows registry keys (32-bit view on 64-bit OS)
reg query "HKLM\SOFTWARE\WOW6432Node\GitForWindows" /v InstallPath >nul 2>&1
if not errorlevel 1 (
    set "GIT=TRUE"
    goto :eof
)
rem 3) Default install locations
if exist "%ProgramFiles%\Git\cmd\git.exe" (
    set "GIT=TRUE"
    goto :eof
)
if exist "%ProgramW6432%\Git\cmd\git.exe" (
    set "GIT=TRUE"
    goto :eof
)
if exist "%ProgramFiles(x86)%\Git\cmd\git.exe" (
    set "GIT=TRUE"
    goto :eof
)
goto :eof


rem ---------------------------------------------------------------------------
rem  :CheckTortoiseGit  -> sets TGIT=TRUE when TortoiseGit is found
rem ---------------------------------------------------------------------------
:CheckTortoiseGit
rem 1) TortoiseGitProc.exe available on PATH
where TortoiseGitProc >nul 2>&1
if not errorlevel 1 (
    set "TGIT=TRUE"
    goto :eof
)
rem 2) TortoiseGit registry keys (ProcPath -> TortoiseGitProc.exe)
reg query "HKLM\SOFTWARE\TortoiseGit" /v ProcPath >nul 2>&1
if not errorlevel 1 (
    set "TGIT=TRUE"
    goto :eof
)
reg query "HKLM\SOFTWARE\WOW6432Node\TortoiseGit" /v ProcPath >nul 2>&1
if not errorlevel 1 (
    set "TGIT=TRUE"
    goto :eof
)
reg query "HKCU\SOFTWARE\TortoiseGit" /v ProcPath >nul 2>&1
if not errorlevel 1 (
    set "TGIT=TRUE"
    goto :eof
)
rem 3) Default install locations
if exist "%ProgramFiles%\TortoiseGit\bin\TortoiseGitProc.exe" (
    set "TGIT=TRUE"
    goto :eof
)
if exist "%ProgramW6432%\TortoiseGit\bin\TortoiseGitProc.exe" (
    set "TGIT=TRUE"
    goto :eof
)
if exist "%ProgramFiles(x86)%\TortoiseGit\bin\TortoiseGitProc.exe" (
    set "TGIT=TRUE"
    goto :eof
)
goto :eof
