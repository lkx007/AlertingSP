@echo off
IF "%1"=="" ( 
	echo First argument should be the SolutionPack's name. e.g. vmware-vcenter 
	goto END
)

set PACKAGE=%1

echo.
echo.
echo ======================================
echo _______________Building_______________
echo Package: %PACKAGE%
echo Please wait...
PUSHD "%~dp0\.."
call bin\settings\settings.cmd
java -jar build-solutionpack-cli.jar %MAINDIR%\%PACKAGE%\trunk %PACKAGE% 
echo Executing post-build....
REM call bin\settings\post.cmd
POPD
echo ======================================
echo.
echo.
:END