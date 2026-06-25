@echo off
REM ============================================================
REM  Push_current_branch.cmd
REM  Executes 'git push origin HEAD' on the repository, which
REM  pushes ONLY the current branch to its remote counterpart
REM  (or creates it if it doesn't exist on the remote).
REM
REM  Zero setlocal, zero loops -> safe under constrained hosts
REM  (e.g. LabVIEW System Exec).
REM
REM  Usage:
REM    Push_current_branch.cmd                   Push in current directory
REM    Push_current_branch.cmd "D:\repo path"    Push in given repo directory
REM    Push_current_branch.cmd "D:\repo\a.vi"    Push using given file directory
REM    (quote the path if it contains spaces)
REM
REM  Output : git push output (branch details, remote updates)
REM           error messages on failure
REM  Exit   : git push exit code (0 on success, >0 on error)
REM
REM  Note   : pushes to the 'origin' remote (default). Uses HEAD
REM           as the source ref to ensure ONLY the current branch
REM           is pushed, never other branches.
REM ============================================================

if "%~1"=="" goto :currentdir
if exist "%~1\*" goto :withdir
goto :withfile

:currentdir
REM --- No path given: use current directory ---
git push origin HEAD
exit /b %errorlevel%

:withdir
REM --- Explicit repo directory ---
git -C "%~1" push origin HEAD
exit /b %errorlevel%

:withfile
REM --- Explicit file path: use its directory ---
git -C "%~dp1." push origin HEAD
exit /b %errorlevel%
