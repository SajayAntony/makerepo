@echo off
IF [%1]==[]  GOTO :USAGE

setlocal ENABLEDELAYEDEXPANSION
pushd %1
set MKREPO_LOCALNAME=%1

IF NOT EXIST .git (
	REM curl -O https://raw.githubusercontent.com/github/gitignore/master/VisualStudio.gitignore 
	REM move VisualStudio.gitignore .gitignore

	for /f "delims=\" %%a in ("%cd%") do set currentFolder=%%~nxa
	set MKREPO_LOCALNAME=%currentFolder%

	git init
	If NOT EXIST ".gitignore" xcopy "%~dp0.gitignore"
	git add -A
	git commit -m "Initial Commit for repo !MKREPO_LOCALNAME!"
	IF NOT ERRORLEVEL 1 (
		echo -------------- CREATED LOCAL REPO --------------
	) 
) ELSE (
  echo "%CD%" is already a git repo.
)

popd
GOTO :END

:USAGE 
echo USAGE:
echo.
echo	makelocalrepo.cmd {directory}
exit /b 1

:END
ENDLOCAL&SET MKREPO_NAME=!MKREPO_LOCALNAME!