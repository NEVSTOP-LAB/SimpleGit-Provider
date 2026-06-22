@echo off
REM ============================================================
REM  Switch_or_create_branch.cmd
REM  Switches to a branch, or creates it if it doesn't exist.
REM  Logic:
REM    1. If local branch exists -> checkout to it
REM    2. Else if remote branch exists -> create local tracking it
REM    3. Else -> create new local branch from current HEAD
REM
REM  Zero setlocal, zero loops -> safe under constrained hosts
REM  (e.g. LabVIEW System Exec).
REM
REM  Usage:
REM    Switch_or_create_branch.cmd <branch>              Switch in current dir
REM    Switch_or_create_branch.cmd <branch> "D:\repo"    Switch in given repo
REM    (quote the repo path if it contains spaces;
REM     branch name must be a valid Git name: alphanumeric,
REM     hyphens, underscores, slashes; avoid special chars)
REM
REM  Output : git checkout messages (e.g. "Switched to branch ...")
REM           error messages on failure
REM  Exit   : 0 = success (switched or created)
REM           1 = missing branch arg / error
REM
REM  Note   : if the branch name contains spaces or special
REM           characters, the caller should sanitize it or
REM           git will reject it. Git will report if a name
REM           is invalid (e.g. reserved names like 'HEAD').
REM ============================================================

REM --- Require branch name (arg 1) ---
if "%~1"=="" goto :error

REM --- Optional repo path (arg 2) ---
if not "%~2"=="" goto :withpath

REM --- Current directory ---
git checkout "%~1" 2>nul
if errorlevel 1 goto :tryremote_currentdir
exit /b 0

:tryremote_currentdir
git checkout -b "%~1" "origin/%~1" 2>nul
if errorlevel 1 goto :createnew_currentdir
exit /b 0

:createnew_currentdir
git checkout -b "%~1"
exit /b %errorlevel%

:withpath
REM --- Explicit repo path (arg 2) ---
git -C "%~2" checkout "%~1" 2>nul
if errorlevel 1 goto :tryremote_withpath
exit /b 0

:tryremote_withpath
git -C "%~2" checkout -b "%~1" "origin/%~1" 2>nul
if errorlevel 1 goto :createnew_withpath
exit /b 0

:createnew_withpath
git -C "%~2" checkout -b "%~1"
exit /b %errorlevel%

:error
echo Branch name is required.
exit /b 1
