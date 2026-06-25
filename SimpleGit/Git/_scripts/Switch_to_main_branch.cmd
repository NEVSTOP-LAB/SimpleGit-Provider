@echo off
REM ============================================================
REM  Switch_to_main_branch.cmd
REM  Switches to the main branch (either 'main' or 'master').
REM  Logic:
REM    1. If 'main' branch exists -> checkout to it
REM    2. Else if 'master' branch exists -> checkout to it
REM    3. Else -> error (neither main nor master found)
REM
REM  Zero setlocal, zero loops -> safe under constrained hosts
REM  (e.g. LabVIEW System Exec).
REM
REM  Usage:
REM    Switch_to_main_branch.cmd                 Switch in current directory
REM    Switch_to_main_branch.cmd "D:\repo path"  Switch in given repo directory
REM    Switch_to_main_branch.cmd "D:\repo\a.vi"  Switch using given file directory
REM    (quote the path if it contains spaces)
REM
REM  Output : git checkout message (e.g. "Switched to branch 'main'")
REM           error message if neither main nor master exist
REM  Exit   : 0 = success (switched to main or master)
REM           1 = error (neither main nor master found / not a repo)
REM ============================================================

if "%~1"=="" goto :currentdir
if exist "%~1\*" goto :withdir
goto :withfile

:currentdir
REM --- Current directory ---
git show-ref --verify --quiet "refs/heads/main" 2>nul
if errorlevel 1 goto :check_master_currentdir
git checkout -q main
exit /b 0

:check_master_currentdir
git show-ref --verify --quiet "refs/heads/master" 2>nul
if errorlevel 1 goto :error_currentdir
git checkout -q master
exit /b 0

:error_currentdir
echo ERROR: Neither 'main' nor 'master' branch found.
exit /b 1

:withdir
REM --- Explicit repo directory ---
git -C "%~1" show-ref --verify --quiet "refs/heads/main" 2>nul
if errorlevel 1 goto :check_master_withpath
git -C "%~1" checkout -q main
exit /b 0

:check_master_withpath
git -C "%~1" show-ref --verify --quiet "refs/heads/master" 2>nul
if errorlevel 1 goto :error_withpath
git -C "%~1" checkout -q master
exit /b 0

:error_withpath
echo ERROR: Neither 'main' nor 'master' branch found.
exit /b 1

:withfile
REM --- Explicit file path: use its directory ---
git -C "%~dp1." show-ref --verify --quiet "refs/heads/main" 2>nul
if errorlevel 1 goto :check_master_withfile
git -C "%~dp1." checkout -q main
exit /b 0

:check_master_withfile
git -C "%~dp1." show-ref --verify --quiet "refs/heads/master" 2>nul
if errorlevel 1 goto :error_withfile
git -C "%~dp1." checkout -q master
exit /b 0

:error_withfile
echo ERROR: Neither 'main' nor 'master' branch found.
exit /b 1
