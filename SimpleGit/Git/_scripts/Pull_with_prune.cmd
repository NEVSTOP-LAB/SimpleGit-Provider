@echo off
REM ============================================================
REM  Pull_with_prune.cmd
REM  Executes 'git pull --prune' on the repository, which:
REM    - Fetches updates from remote(s)
REM    - Merges (or rebases) into the current branch
REM    - Prunes deleted remote-tracking branches locally
REM
REM  Zero setlocal, zero loops -> safe under constrained hosts
REM  (e.g. LabVIEW System Exec).
REM
REM  Usage:
REM    Pull_with_prune.cmd                   Pull in current directory
REM    Pull_with_prune.cmd "D:\repo path"    Pull in given repo directory
REM    Pull_with_prune.cmd "D:\repo\a.vi"    Pull using given file directory
REM    (quote the path if it contains spaces)
REM
REM  Output : git pull output (status, merge result, prune details)
REM           error messages on failure
REM  Exit   : git pull exit code (0 on success, >0 on error or conflict)
REM
REM  Note   : --prune is always included. For additional git pull
REM           options (e.g. --rebase), invoke git directly or modify
REM           the script to pass them.
REM ============================================================

if "%~1"=="" goto :currentdir
if exist "%~1\*" goto :withdir
goto :withfile

:currentdir
REM --- No path given: use current directory ---
git pull --prune
exit /b %errorlevel%

:withdir
REM --- Explicit repo directory ---
git -C "%~1" pull --prune
exit /b %errorlevel%

:withfile
REM --- Explicit file path: use its directory ---
git -C "%~dp1." pull --prune
exit /b %errorlevel%
