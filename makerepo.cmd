@echo OFF
SETLOCAL ENABLEDELAYEDEXPANSION
IF [%1]==[]  GOTO :USAGE

SET MKREPO_PATH=%1
CALL %~dp0makelocalrepo.cmd %CD%
IF ERRORLEVEL 1 GOTO :ERROR 

CALL %~dp0makeremoterepo.cmd %MKREPO_PATH%
IF ERRORLEVEL 1 GOTO :ERROR 

CALL %~dp0configureremote.cmd %MKREPO_PATH%
IF ERRORLEVEL 1 GOTO :ERROR 

echo.
echo ------------- CLONE URL--------------
for /f  %%a in ("%MKREPO_PATH%") do set MKREPO_NAME=%%~nxa
set MKREPO_NAME=!MKREPO_NAME:.git=!
echo git clone %MKREPO_PATH% !MKREPO_NAME!
ENDLOCAL
exit /b 0

:ERROR
echo ERROR: Could not make repo. 
exit /b

:USAGE
echo.
echo USAGE:
echo 	makerepo {UNC_SHARE}
exit /b 1


