@echo off
REM ============================================================
REM  Get_current_commit.cmd
REM  Prints the full commit hash (SHA-1) that HEAD points to
REM  on the current branch. Outputs ONLY the hash to stdout.
REM
REM  Zero setlocal, zero loops, zero pipes -> safe under
REM  constrained hosts (e.g. LabVIEW System Exec).
REM
REM  Usage:
REM    Get_current_commit.cmd                 Use current directory
REM    Get_current_commit.cmd "D:\repo path"  Use given repo path
REM    (quote paths with spaces)
REM
REM  Output : the 40-char commit hash on success
REM           nothing when there are no commits yet (unborn
REM           branch), not a Git repository, or on error
REM  Exit   : 0 = success, non-zero = no commit / not a repo / error
REM
REM  Note   : '--verify' is required so an unborn branch prints
REM           nothing instead of the literal "HEAD". For the
REM           short hash use 'rev-parse --short --verify HEAD'.
REM ============================================================

if not "%~1"=="" goto :withpath

git rev-parse --verify HEAD 2>nul
exit /b %errorlevel%

:withpath
git -C "%~1" rev-parse --verify HEAD 2>nul
exit /b %errorlevel%
