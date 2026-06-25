@echo off
REM ============================================================
REM  List_uncommitted_files.cmd
REM  Lists all uncommitted files in a Git repository and prefixes
REM  each path with its status class.
REM
REM  Usage:
REM    List_uncommitted_files.cmd                 Use current directory
REM    List_uncommitted_files.cmd "D:\repo path"  Use given repo directory
REM    List_uncommitted_files.cmd "D:\repo\a.vi"  Use directory of given file
REM
REM  Output : one file per line with a prefix:
REM             [staged]   <path>
REM             [unstaged] <path>
REM             [untracked] <path>
REM             [conflict] <path>
REM           A file may appear multiple times if it belongs to
REM           multiple classes (for example staged + unstaged).
REM  Exit   : 0 = success, 1 = not a Git repository / error
REM ============================================================

if "%~1"=="" goto :currentdir
if exist "%~1\*" goto :withdir
goto :withfile

:currentdir
git rev-parse --is-inside-work-tree >nul 2>nul
if errorlevel 1 exit /b 1

for /f "delims=" %%F in ('git diff --cached --name-only 2^>nul') do echo [staged] %%F
for /f "delims=" %%F in ('git diff --name-only 2^>nul') do echo [unstaged] %%F
for /f "delims=" %%F in ('git ls-files --others --exclude-standard 2^>nul') do echo [untracked] %%F
for /f "delims=" %%F in ('git diff --name-only --diff-filter=U 2^>nul') do echo [conflict] %%F
exit /b 0

:withdir
git -C "%~1" rev-parse --is-inside-work-tree >nul 2>nul
if errorlevel 1 exit /b 1

for /f "delims=" %%F in ('git -C "%~1" diff --cached --name-only 2^>nul') do echo [staged] %%F
for /f "delims=" %%F in ('git -C "%~1" diff --name-only 2^>nul') do echo [unstaged] %%F
for /f "delims=" %%F in ('git -C "%~1" ls-files --others --exclude-standard 2^>nul') do echo [untracked] %%F
for /f "delims=" %%F in ('git -C "%~1" diff --name-only --diff-filter=U 2^>nul') do echo [conflict] %%F
exit /b 0

:withfile
git -C "%~dp1." rev-parse --is-inside-work-tree >nul 2>nul
if errorlevel 1 exit /b 1

for /f "delims=" %%F in ('git -C "%~dp1." diff --cached --name-only 2^>nul') do echo [staged] %%F
for /f "delims=" %%F in ('git -C "%~dp1." diff --name-only 2^>nul') do echo [unstaged] %%F
for /f "delims=" %%F in ('git -C "%~dp1." ls-files --others --exclude-standard 2^>nul') do echo [untracked] %%F
for /f "delims=" %%F in ('git -C "%~dp1." diff --name-only --diff-filter=U 2^>nul') do echo [conflict] %%F
exit /b 0