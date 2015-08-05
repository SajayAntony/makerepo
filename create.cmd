@echo OFF

SETLOCAL ENABLEDELAYEDEXPANSION

if [%1]==[] (
	set MKREPO_CREATE_PATH="%CD%"
) ELSE (
	set MKREPO_CREATE_PATH=%1
)

set MKREPO_CREATE_PATH=%MKREPO_CREATE_PATH:"=%
IF "%MKREPO_CREATE_PATH%"=="/?" GOTO :USAGE

IF [%1]==[] (
	CALL :func_creatShare %1
	IF  /I "!MKCONFIRM_CREATE!"=="Y" GOTO:END
	exit /b 0
)

:: Check if the name given is a fully qualified UNC. 
:: Otherwise check if the share path is available.
echo !MKREPO_CREATE_PATH! | findstr /b ^\\\\ >nul
IF ERRORLEVEL 1 (
	CALL :func_creatShare %1
	IF  /I "!MKCONFIRM_CREATE!"=="Y" GOTO:END
	exit /b 0
) ELSE (
   	:: Fully qualified path given.
   	SET MKREPO_SHARE_PATH=!MKREPO_CREATE_PATH!     	
)

:END
CALL %~dp0makerepo.cmd %MKREPO_SHARE_PATH%
ENDLOCAL
exit /b

:USAGE
 echo create.cmd [repo name or UNC share]
 exit /b 1


:func_creatShare
:: Get the remote share.
IF NOT EXIST %~dp0~$hareName.txt (
	ECHO SCRIPT ERROR: Could not find %~dp0~$hareName.txt with the UNC root share.
	ECHO Create %~dp0~$hareName.txt. [Ensure \\ at the end]
	ECHO ECHO \\machine\share\ ^> %~dp0~$hareName.txt
	exit /b 1
)

for /f "delims=" %%x in (%~dp0~$hareName.txt) do set MKREPO_SHARE=%%x
SET MKREPO_SHARE=!MKREPO_SHARE: =!

:: Check if the value given is a name or a real folder. 
:: If it is a folder pick the name of the folder for the repo name.	
IF EXIST "%MKREPO_CREATE_PATH%" (
	pushd "%MKREPO_CREATE_PATH%"
	for /f "delims=\" %%a in ("%CD%") do set currentFolder=%%~nxa
	set MKREPO_CREATE_PATH=!currentFolder!
	popd
)

:: Prompt user for input to confirm creation of repo. 
:: Provide the share and the name of the repo that we are going to use. 
SET MKCONFIRM_CREATE=N
set /p MKCONFIRM_CREATE=Do you want share repo "!MKREPO_CREATE_PATH!" at "!MKREPO_SHARE!%USERNAME%/!MKREPO_CREATE_PATH!.git" [Default N] Y/N ^?:
SET MKCONFIRM_CREATE=%MKCONFIRM_CREATE: =%
IF /I "%MKCONFIRM_CREATE%"=="Y" ( echo Creating Repo. 
) ELSE (
	exit /b 1
)

SET MKREPO_SHARE_PATH=!MKREPO_SHARE!%USERNAME%/!MKREPO_CREATE_PATH!.git
SET MKCONFIRM_CREATE=Y
GOTO:eof

