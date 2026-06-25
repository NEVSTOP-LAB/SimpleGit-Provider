@echo off
REM ============================================================
REM  Get_last_commit_message.cmd
REM  Prints the subject line of the last commit on the current
REM  branch (HEAD). Outputs ONLY the message to stdout.
REM
REM  Zero setlocal, zero loops, zero pipes -> safe under
REM  constrained hosts (e.g. LabVIEW System Exec).
REM
REM  Usage:
REM    Get_last_commit_message.cmd                 Use current directory
REM    Get_last_commit_message.cmd "D:\repo path"  Use given repo directory
REM    Get_last_commit_message.cmd "D:\repo\a.vi"  Use directory of given file
REM    (quote paths with spaces)
REM
REM  Output : the last commit subject line on success
REM           nothing when there are no commits yet (unborn
REM           branch), not a Git repository, or on error
REM  Exit   : 0 = success, non-zero = no commit / not a repo / error
REM
REM  Note   : '%%s' (escaped '%') passes the git subject
REM           placeholder '%s' through cmd. Use '%%B' for the
REM           full message body instead of just the subject.
REM ============================================================

if "%~1"=="" goto :currentdir
if exist "%~1\*" goto :withdir
goto :withfile

:currentdir
git log -1 --format=%%s 2>nul
exit /b %errorlevel%

:withdir
git -C "%~1" log -1 --format=%%s 2>nul
exit /b %errorlevel%

:withfile
git -C "%~dp1." log -1 --format=%%s 2>nul
exit /b %errorlevel%
