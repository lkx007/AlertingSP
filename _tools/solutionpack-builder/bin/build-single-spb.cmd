@echo off
set MAINDIR=%~dp0\..\..\..
cd %MAINDIR%\_tools\solutionpack-builder
set /P PACKAGE= Enter SPB ID: 
call :build %PACKAGE%
pause
exit

:build
java -jar build-solutionpack-cli.jar "%MAINDIR%\emc-watch4net\trunk\blocks\%PACKAGE%" %PACKAGE%
IF %ERRORLEVEL% NEQ 0 GOTO :error
echo Build of %PACKAGE% success!
GOTO:EOF

:error
echo Build of %PACKAGE% failed!