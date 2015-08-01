@echo OFF
SETLOCAL ENABLEDELAYEDEXPANSION
IF [%1]==[]  GOTO :USAGE

SET MKREPO_PATH=%1
CALL %~dp0makelocalrepo.cmd %CD%
CALL %~dp0makeremoterepo.cmd %MKREPO_PATH%
CALL %~dp0configureremote.cmd %MKREPO_PATH%

echo.
echo ------------- CLONE URL--------------
echo git clone %MKREPO_PATH% %MKREPO_NAME%
ENDLOCAL

:EXIT 
exit /b

:USAGE
echo.
echo USAGE:
echo 	makerepo {REPO_NAME}
exit /b 1


