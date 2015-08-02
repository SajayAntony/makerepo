@echo OFF
setlocal ENABLEDELAYEDEXPANSION

IF [%1]==[]  GOTO :END
SET MKREPO_REMOTE=origin
SET MKREPO_URL=%1
echo --------- CONFIGURING REMOTES ----------
echo Adding origin to %MKREPO_URL% 
git remote add %MKREPO_REMOTE% %MKREPO_URL%
IF ERRORLEVEL 1 (
echo ERROR: Could not configure remote origin %MKREPO_URL%
echo Listing remotes ...
git remote -v 
echo INFO : Try adding remote manually by commandline.
echo ----------------------------------------
echo git remote add upstream %MKREPO_URL%
echo git push upstream master
echo ----------------------------------------
exit /b 1 
)
echo Pushing changes to remote %MKREPO_URL%
git push %MKREPO_REMOTE% master

:END
endlocal