@echo off
REM ============================================================
REM  Get_current_branch.cmd
REM  Prints the current Git branch name of a repository.
REM  Outputs ONLY the branch name (nothing else) to stdout.
REM
REM  Zero setlocal, zero loops, zero pipes -> safe under
REM  constrained hosts (e.g. LabVIEW System Exec).
REM
REM  Usage:
REM    Get_current_branch.cmd                 Use current directory
REM    Get_current_branch.cmd "D:\repo path"  Use given repo directory
REM    Get_current_branch.cmd "D:\repo\a.vi"  Use directory of given file
REM    (quote paths with spaces)
REM
REM  Output : the branch name on success (e.g. "main")
REM           nothing when in detached-HEAD state
REM           nothing when not a Git repository / on error
REM  Exit   : 0 = success, non-zero = not a repo / git error
REM
REM  Note   : uses 'git branch --show-current' (Git 2.22+),
REM           which returns the real branch name even before
REM           the first commit (unborn branch) and prints
REM           nothing (instead of the literal "HEAD") when
REM           the repository is in a detached-HEAD state.
REM ============================================================

if "%~1"=="" goto :currentdir
if exist "%~1\*" goto :withdir
goto :withfile

:currentdir
git branch --show-current 2>nul
exit /b %errorlevel%

:withdir
git -C "%~1" branch --show-current 2>nul
exit /b %errorlevel%

:withfile
git -C "%~dp1." branch --show-current 2>nul
exit /b %errorlevel%
