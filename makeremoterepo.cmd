@echo OFF
setlocal ENABLEDELAYEDEXPANSION
IF [%1]==[]  GOTO :USAGE

set MKREPO_PATH=%1
SET MKREPO_PATH=%MKREPO_PATH:/=\%
REM Check if its fully qualified.
echo %MKREPO_PATH% | findstr /b ^\\\\ >nul
IF ERRORLEVEL 1 (	
	REM Using a common share to drop the bare repo in the users folder.
	SET MKREPO_PATH=//aaptperffs/repos/%USERNAME%/%MKREPO_PATH%.git
) ELSE (
   	REM Fully qualified path given.     	
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
	)
GOTO :END

:USAGE
echo makeremoterepo.cmd {UNC or repo name}
exit /b 1

:END
endlocal&SET MKREPO_PATH=%MKREPO_NIX_PATH%