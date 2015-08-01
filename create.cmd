@echo OFF 

IF [%1]==[]  GOTO :USAGE

SETLOCAL ENABLEDELAYEDEXPANSION
echo %1 | findstr /b ^\\\\ >nul
IF ERRORLEVEL 1 (
	REM Using a common share to drop the bare repo in the users folder.
	echo %~dp0~$hareName.txt
	for /f "delims=" %%x in (%~dp0~$hareName.txt) do set MKREPO_SHARE=%%x
	SET MKREPO_SHARE_PATH=!MKREPO_SHARE!%USERNAME%/%1.git
) ELSE (
   	REM Fully qualified path given.
   	SET MKREPO_SHARE_PATH=%1     	
)

GOTO :END

:USAGE
 create.cmd {repo name or UNC share}
 exit /b 1

:END
CALL %~dp0makerepo.cmd %MKREPO_SHARE_PATH%
ENDLOCAL
