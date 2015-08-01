@echo off

IF "%1"=="/?" GOTO :USAGE

setlocal ENABLEDELAYEDEXPANSION

set MKREPO_LOCALNAME=%1
IF [%1]==[] set MKREPO_LOCALNAME=%CD%

IF NOT EXIST %MKREPO_LOCALNAME% ( 
	echo ERROR: Directory "%MKREPO_LOCALNAME%" not found.
	GOTO :USAGE
)

pushd %MKREPO_LOCALNAME%

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
echo		makelocalrepo.cmd [directory]
echo.
echo Directory is optional and you can run the script and it will make the current folder 
echo a repository and commit the artifacts into the newly created local repository.
exit /b 1

:END
ENDLOCAL&SET MKREPO_NAME=!MKREPO_LOCALNAME!