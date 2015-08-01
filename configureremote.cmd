@echo OFF
setlocal ENABLEDELAYEDEXPANSION

IF [%1]==[]  GOTO :END
SET MKREPO_REMOTE=origin
SET MKREPO_URL=%1
echo Configuring remote origin to %MKREPO_URL% 
git remote add %MKREPO_REMOTE% %MKREPO_URL%
IF ERRORLEVEL 1 (
echo ERROR: Could not configure remote origin %MKREPO_URL%
git remote -v 
exit /b 1 
)
echo Pushing changes to remote %MKREPO_URL%
git push %MKREPO_REMOTE% master

:END
endlocal