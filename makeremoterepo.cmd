@echo OFF
setlocal ENABLEDELAYEDEXPANSION
IF [%1]==[]  GOTO :USAGE

set MKREPO_PATH=%1
SET MKREPO_PATH=%MKREPO_PATH:/=\%
REM Check if its fully qualified.
echo %MKREPO_PATH% | findstr /b ^\\\\ >nul
IF ERRORLEVEL 1 (
 echo ERROR: "%MKREPO_PATH%" is not a fully qualified UNC share name.
 exit /b 1	
)

REM FIX up path separators
SET MKREPO_NIX_PATH=%MKREPO_PATH:\=/%
ECHO Going to initialize a git repo in %MKREPO_PATH%

:INITIALIZE_REPO
If EXIST %MKREPO_PATH% ( echo Directory %MKREPO_PATH% already exists. 
GOTO :END
)

git init --bare %MKREPO_NIX_PATH%
if NOT ERRORLEVEL 1 (
	echo -------------- CREATED REMOTE REPO --------------
	GOTO :END
	)
exit /b 1
:USAGE
echo makeremoterepo.cmd {UNC SHARE}
exit /b 1

:END
endlocal&SET MKREPO_PATH=%MKREPO_NIX_PATH%