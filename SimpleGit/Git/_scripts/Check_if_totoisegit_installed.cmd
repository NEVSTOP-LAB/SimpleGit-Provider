@echo off
setlocal EnableExtensions EnableDelayedExpansion

rem ============================================================================
rem  Check_if_totoisegit_installed.cmd
rem  ---------------------------------------------------------------------------
rem  Detect whether Git and/or TortoiseGit are installed on this machine.
rem  ???? Git / TortoiseGit ?????????
rem
rem  Usage / ?¡Â?:
rem    Check_if_totoisegit_installed.cmd               Check BOTH (Git + TortoiseGit)
rem    Check_if_totoisegit_installed.cmd git           Check Git only
rem    Check_if_totoisegit_installed.cmd tortoisegit   Check TortoiseGit only
rem
rem  Output (stdout) / ???:  TRUE   -> installed     ????
rem                          FALSE  -> not installed  ¦Ä???
rem  Exit code / ?????:      0 = TRUE (installed)    1 = FALSE (not installed)
rem ============================================================================

set "target=%~1"
if "%target%"=="" set "target=all"

set "GIT=FALSE"
set "TGIT=FALSE"

call :CheckGit
call :CheckTortoiseGit

set "RESULT=FALSE"
if /i "%target%"=="git" (
    set "RESULT=!GIT!"
) else if /i "%target%"=="tortoisegit" (
    set "RESULT=!TGIT!"
) else if /i "%target%"=="tgit" (
    set "RESULT=!TGIT!"
) else (
    rem "all": TRUE only when BOTH Git and TortoiseGit are installed
    if "!GIT!"=="TRUE" if "!TGIT!"=="TRUE" set "RESULT=TRUE"
)

echo !RESULT!

if "!RESULT!"=="TRUE" (
    exit /b 0
) else (
    exit /b 1
)


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
rem 2) Git for Windows registry keys (64-bit and 32-bit views)
for %%K in ("HKLM\SOFTWARE\GitForWindows" "HKLM\SOFTWARE\WOW6432Node\GitForWindows") do (
    reg query %%K /v InstallPath >nul 2>&1
    if not errorlevel 1 (
        set "GIT=TRUE"
        goto :eof
    )
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
for %%K in ("HKLM\SOFTWARE\TortoiseGit" "HKLM\SOFTWARE\WOW6432Node\TortoiseGit" "HKCU\SOFTWARE\TortoiseGit") do (
    reg query %%K /v ProcPath >nul 2>&1
    if not errorlevel 1 (
        set "TGIT=TRUE"
        goto :eof
    )
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
