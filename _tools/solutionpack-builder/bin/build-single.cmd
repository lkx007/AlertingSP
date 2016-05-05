@echo off
set MAINDIR=%~dp0\..\..\..
cd %MAINDIR%\_tools\solutionpack-builder
set /P PACKAGE= Enter SP ID: 
call :build %PACKAGE%
pause
exit

:build
echo "Pagk name => %PACKAGE%"
java -jar build-solutionpack-cli.jar "%MAINDIR%\%PACKAGE%\trunk" %PACKAGE%
IF %ERRORLEVEL% NEQ 0 GOTO :error
echo Build of %PACKAGE% success!
GOTO:EOF

:error
echo Build of %PACKAGE% failed!