@echo OFF 

IF [%1]==[]  GOTO :USAGE

SETLOCAL ENABLEDELAYEDEXPANSION
echo %1 | findstr /b ^\\\\ >nul
IF ERRORLEVEL 1 (
	REM Using a common share to drop the bare repo in the users folder.
	IF NOT EXIST %~dp0~$hareName.txt (
		ECHO SCRIPT ERROR: Could not find %~dp0~$hareName.txt with the UNC root share.
		ECHO Create %~dp0~$hareName.txt.
		ECHO ECHO \\machine\share ^> %~dp0~$hareName.txt
		exit /b 1
	)
	for /f "delims=" %%x in (%~dp0~$hareName.txt) do set MKREPO_SHARE=%%x
	REM Clean up empty spaces.
	SET MKREPO_SHARE=!MKREPO_SHARE: =!
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
exit /b
