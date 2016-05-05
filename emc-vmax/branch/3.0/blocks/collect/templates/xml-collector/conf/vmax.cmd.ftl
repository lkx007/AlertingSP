[#ftl]
@ECHO OFF
[#if symapi.path??]
set PATH=%PATH%;${symapi.path}
[#else]
set PATH=%PATH%;C:\Program Files\EMC\SYMCLI\bin
[/#if]
[#if symapi.connect_type == 'remote']
set SYMCLI_CONNECT=${symapi.connect}
[/#if]
set SYMCLI_CONNECT_TYPE=${symapi.connect_type}
SET ONE=%~1
SET TWO=%~2
SET THREE=%~3
SET FOUR=%~4
SET FIVE=%~5
SET SIX=%~6
SET SEVEN=%~7
SET EIGHT=%~8
SET NINE=%~9
SHIFT
SHIFT
SHIFT
SHIFT
SHIFT
SHIFT
SHIFT
SHIFT
SHIFT
SET TEN=%~1
SET ELEVEN=%~2
SET TWELVE=%~3
SET THIRTEEN=%~4
SET FOURTEEN=%~5
SET SIXTEEN=%~6
SET SEVENTEEN=%~7
SET EIGHTEEN=%~8
SET NINETEEN=%~9

REM Define unique id to identify the temporary files for this session. Forms the unique identifier from the command line parameters which identifies the 
REM command and the actual array which is unique when parallel processing happens for multiple arrays at the same time from same collector configuration.
REM It is important that the SYMCLI commands in XML Collector configuration always follow the format '<SYMCLI_COMMAND> -output XML -sid (host) ......'
SET uniqueid=%FIVE%%ONE%

REM Execute the command and preserve the error and output
IF %ONE% EQU symmaskdb (      
   %ONE% %TWO% %THREE% %FOUR% %FIVE% %SIX% %SEVEN% %EIGHT% %NINE% %TEN% %ELEVEN% %TWELVE% %THIRTEEN% %FOURTEEN% %SIXTEEN% %SEVENTEEN% %EIGHTEEN% %NINETEEN% 2>NUL 1>output.%uniqueid%    
   IF ERRORLEVEL 1 (      
      ECHO ^<?xml version="1.0" standalone="yes" ?^>^<SymCLI_ML^>^</SymCLI_ML^>
   ) ELSE (
      for /F "tokens=*" %%A in (output.%uniqueid%) do echo %%A
   )
   DEL /Q output.%uniqueid%
) ELSE (   
   %ONE% %TWO% %THREE% %FOUR% %FIVE% %SIX% %SEVEN% %EIGHT% %NINE% %TEN% %ELEVEN% %TWELVE% %THIRTEEN% %FOURTEEN% %SIXTEEN% %SEVENTEEN% %EIGHTEEN% %NINETEEN%
)