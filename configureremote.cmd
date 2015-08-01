@echo OFF
setlocal ENABLEDELAYEDEXPANSION

IF [%1]==[]  GOTO :END
SET MKREPO_REMOTE=origin
git remote add %MKREPO_REMOTE% %1
IF ERRORLEVEL 1 (
echo ERROR: Could not configure remote origin %1
git remote -v 
exit /b 1 
)

git push %MKREPO_REMOTE% master

:END
endlocal