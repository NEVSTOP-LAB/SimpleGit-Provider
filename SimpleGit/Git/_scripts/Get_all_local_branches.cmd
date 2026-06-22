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
REM    Get_all_local_branches.cmd "D:\repo path"  List in given repo path
REM    (quote the repo path if it contains spaces)
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

if not "%~1"=="" goto :withpath

REM --- No path given: use current directory ---
git branch
exit /b %errorlevel%

:withpath
REM --- Explicit repo path ---
git -C "%~1" branch
exit /b %errorlevel%
