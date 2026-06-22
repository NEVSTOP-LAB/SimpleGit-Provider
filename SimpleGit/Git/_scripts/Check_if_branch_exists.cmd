@echo off
REM ============================================================
REM  Check_if_branch_exists.cmd
REM  Checks whether a LOCAL Git branch exists in a repository.
REM
REM  Zero setlocal, zero loops, zero pipes -> safe under
REM  constrained hosts (e.g. LabVIEW System Exec).
REM
REM  Usage:
REM    Check_if_branch_exists.cmd <branch>              Check in current dir
REM    Check_if_branch_exists.cmd <branch> "D:\repo"    Check in given repo
REM    (quote the repo path if it contains spaces; branch
REM     names may contain slashes, e.g. "daily/2026-06-22")
REM
REM  Output : prints TRUE  if the local branch exists
REM           prints FALSE if it does not / no branch given / error
REM  Exit   : 0 = TRUE (exists), 1 = FALSE (not found / error)
REM
REM  Note   : checks local heads only (refs/heads/<branch>); a
REM           remote-tracking ref such as origin/<branch> does
REM           NOT count as existing.
REM ============================================================

REM --- Require a branch name (arg 1) ---
if "%~1"=="" goto :false

REM --- Optional repo path (arg 2): branch in current dir vs given repo ---
if not "%~2"=="" goto :withpath

git show-ref --verify --quiet "refs/heads/%~1" 2>nul
if errorlevel 1 goto :false
goto :true

:withpath
git -C "%~2" show-ref --verify --quiet "refs/heads/%~1" 2>nul
if errorlevel 1 goto :false

:true
echo TRUE
exit /b 0

:false
echo FALSE
exit /b 1
