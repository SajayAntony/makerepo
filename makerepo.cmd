@echo OFF
SETLOCAL ENABLEDELAYEDEXPANSION
IF [%1]==[]  GOTO :USAGE

SET MKREPO_NAME=%1
SET MKREPO_NAME=%MKREPO_NAME:"=%

echo  %MKREPO_NAME% | findstr /B ^\\\\ > nul
IF ERRORLEVEL 1 (
   	REM Fully qualified path given.  
	SET MKREPO_PATH=%MKREPO_NAME%
   	ECHO Setting up repo in %MKREPO_PATH%
   	SET MKREPO_NAME=share
) ELSE (
REM PERSONAL_REPO
SET MKREPO_PATH=//aaptperffs/repos/%USERNAME%/%MKREPO_NAME%.git
)

REM FIX up path separators
SET MKREPO_NIX_PATH=%MKREPO_PATH:\=/%

:INITIALIZE_REPO
If EXIST %MKREPO_PATH% ( echo %MKREPO_PATH%  already exists. 
GOTO :USAGE
)

git init --bare %MKREPO_NIX_PATH%
REM curl -O https://raw.githubusercontent.com/github/gitignore/master/VisualStudio.gitignore 
REM move VisualStudio.gitignore .gitignore


SET MKREPO_REMOTE=origin
IF NOT EXIST .git (
	git init
	If NOT EXIST ".gitignore" xcopy "%~dp0.gitignore"
	git add -A
	git commit -m "Initial Commit for %1"
) ELSE (
 SET MKREPO_REMOTE=%MKREPO_NAME%
)


git remote add %MKREPO_REMOTE% %MKREPO_NIX_PATH%
git push %MKREPO_REMOTE% master
echo --- SHARE ---
echo.
echo git clone %MKREPO_PATH% %MKREPO_NAME%
ENDLOCAL
:EXIT 
exit /b

:USAGE
echo.
echo USAGE:
echo 	makerepo {REPO_NAME}
exit /b 1


