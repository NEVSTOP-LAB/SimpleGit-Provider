@echo off
REM ============================================================
REM  Get_all_local_branches.cmd
REM  Lists all LOCAL branches in a Git repository. The current
REM  branch is marked with '*' at the start of the line.
REM
REM  Zero setlocal, zero loops -> safe under constrained hosts
REM  (e.g. LabVIEW System Exec).
REM
REM  Usage:
REM    Get_all_local_branches.cmd                 List in current directory
REM    Get_all_local_branches.cmd "D:\repo path"  List in given repo directory
REM    Get_all_local_branches.cmd "D:\repo\a.vi"  List using given file directory
REM    (quote the path if it contains spaces)
REM
REM  Output : one branch per line; current branch prefixed with '*'
REM           example:
REM             * feat/add-scripts
REM               feat/vscode-entry
REM               main
REM           (empty if there are no branches yet, e.g. unborn repo)
REM  Exit   : 0 = success
REM           1 = not a Git repository / error
REM ============================================================

if "%~1"=="" goto :currentdir
if exist "%~1\*" goto :withdir
goto :withfile

:currentdir
REM --- No path given: use current directory ---
git branch
exit /b %errorlevel%

:withdir
REM --- Explicit repo directory ---
git -C "%~1" branch
exit /b %errorlevel%

:withfile
REM --- Explicit file path: use its directory ---
git -C "%~dp1." branch
exit /b %errorlevel%
