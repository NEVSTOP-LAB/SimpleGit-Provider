@echo off
REM ============================================================
REM  Get_repository_root.cmd
REM  Prints the Git repository root for a file in the repository.
REM
REM  Usage:
REM    Get_repository_root.cmd "D:\repo\path\to\file.vi"
REM    (quote paths with spaces)
REM
REM  Output : the repository root on success
REM  Exit   : 0 = success, 1 = missing argument / not a repository
REM ============================================================

if "%~1"=="" exit /b 1

git -C "%~dp1." rev-parse --show-toplevel 2>nul
if errorlevel 1 exit /b 1
exit /b 0
