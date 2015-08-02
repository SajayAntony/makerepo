@echo OFF 
IF "%1"=="/?" GOTO :USAGE

SETLOCAL ENABLEDELAYEDEXPANSION
set MKREPO_CREATE_PATH=%1	
set MKREPO_CREATE_PATH=!MKREPO_CREATE_PATH: =!

IF [%1]==[] (
	CALL :func_creatShare %1
	IF  /I "!CONFIRM_CREATE!"=="Y" GOTO:END
	exit /b 0
)

echo !MKREPO_CREATE_PATH! | findstr /b ^\\\\ >nul
IF ERRORLEVEL 1 (
	CALL :func_creatShare %1
	IF  /I "!CONFIRM_CREATE!"=="Y" GOTO:END
	exit /b 0
) ELSE (
   	REM Fully qualified path given.
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
REM Get the remote share.
IF NOT EXIST %~dp0~$hareName.txt (
	ECHO SCRIPT ERROR: Could not find %~dp0~$hareName.txt with the UNC root share.
	ECHO Create %~dp0~$hareName.txt. [Ensure \\ at the end]
	ECHO ECHO \\machine\share\ ^> %~dp0~$hareName.txt
	exit /b 1
)

for /f "delims=" %%x in (%~dp0~$hareName.txt) do set MKREPO_SHARE=%%x
SET MKREPO_SHARE=!MKREPO_SHARE: =!
	
IF [%1]==[]  (
	for /f "delims=\" %%a in ("%cd%") do set currentFolder=%%~nxa
	set MKREPO_CREATE_PATH=!currentFolder!
	set /p CONFIRM_CREATE=Do you want share repo "!MKREPO_CREATE_PATH!" at "!MKREPO_SHARE!%USERNAME%/!MKREPO_CREATE_PATH!.git" [Default N] Y/N ^?:
	SET CONFIRM_CREATE=!CONFIRM_CREATE: =!
	IF /I "!CONFIRM_CREATE!"=="Y" ( echo Creating Repo. 
	) ELSE ( 	  
		exit /b 1
	)
) 

SET MKREPO_SHARE_PATH=!MKREPO_SHARE!%USERNAME%/!MKREPO_CREATE_PATH!.git
SET CONFIRM_CREATE=Y
GOTO:eof

