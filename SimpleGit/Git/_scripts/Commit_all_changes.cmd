@echo off
REM ============================================================
REM  Commit_all_changes.cmd
REM  Stages and commits all modifications in a Git repository.
REM
REM  Usage:
REM    Commit_all_changes.cmd "D:\repo path" "commit message"
REM
REM  Args:
REM    %1 = repository path (required)
REM    %2 = commit message (required)
REM
REM  Output : git add / git commit output
REM  Exit   : 0 = commit success
REM           1 = missing args / not a Git repository / git error
REM ============================================================

if "%~1"=="" exit /b 1
if "%~2"=="" exit /b 1

git -C "%~1" rev-parse --is-inside-work-tree >nul 2>nul
if errorlevel 1 exit /b 1

git -C "%~1" add -A
if errorlevel 1 exit /b 1

git -C "%~1" commit -m "%~2"
exit /b %errorlevel%