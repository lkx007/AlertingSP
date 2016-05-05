[#ftl]
[#assign pollingperiod = topology.pollingperiod]
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

setlocal
REM Get the current local time value as Unix Epoch value
call :GetUnixTime UNIX_END_TIME
REM echo %UNIX_END_TIME% seconds have elapsed since 1970-01-01 00:00:00

REM Subtract it by 300 Seconds from the Epoch value
set /a UNIX_START_TIME=%UNIX_END_TIME%-${pollingperiod}

REM Convert the Epoch time to formatt ==> %m/%d/%y:%H:%M:%S  [Start time = current time - 300 seconds ]
call :GetStrDateTime %UNIX_START_TIME% yy1 mm1 dd1 hh1 nn1 ss1
call :TrimYearValue yy1
REM echo/Start date is: %mm1%/%dd1%/%yy1%:%hh1%:%nn1%:%ss1%

REM Convert the Epoch time to formatt ==> %m/%d/%y:%H:%M:%S [ End time = current time ]
call :GetStrDateTime %UNIX_END_TIME% yy2 mm2 dd2 hh2 nn2 ss2
call :TrimYearValue yy2
REM echo/End date is  : %mm2%/%dd2%/%yy2%:%hh2%:%nn2%:%ss2%

REM echo ":" %ONE% %TWO% %THREE% %FOUR% %FIVE% %SIX% %SEVEN% "-start" %mm1%/%dd1%/%yy1%:%hh1%:%nn1%:%ss1% "-end" %mm2%/%dd2%/%yy2%:%hh2%:%nn2%:%ss2%

%ONE% %TWO% %THREE% %FOUR% %FIVE% %SIX% %SEVEN% -start %mm1%/%dd1%/%yy1%:%hh1%:%nn1%:%ss1% -end %mm2%/%dd2%/%yy2%:%hh2%:%nn2%:%ss2%

goto :EOF

:GetUnixTime
setlocal enableextensions
for /f %%x in ('wmic path win32_localtime get /format:list ^| findstr "="') do (
    set %%x)
set /a z=(14-100%Month%%%100)/12, y=10000%Year%%%10000-z
set /a ut=y*365+y/4-y/100+y/400+(153*(100%Month%%%100+12*z-3)+2)/5+Day-719469
set /a ut=ut*86400+100%Hour%%%100*3600+100%Minute%%%100*60+100%Second%%%100
endlocal & set "%1=%ut%" & goto :EOF

:GetStrDateTime
setlocal ENABLEEXTENSIONS
set /a i=%1,ss=i%%60,i/=60,nn=i%%60,i/=60,hh=i%%24,dd=i/24,i/=24
set /a a=i+2472632,b=4*a+3,b/=146097,c=-b*146097,c/=4,c+=a
set /a d=4*c+3,d/=1461,e=-1461*d,e/=4,e+=c,m=5*e+2,m/=153,dd=153*m+2,dd/=5
set /a dd=-dd+e+1,mm=-m/10,mm*=12,mm+=m+3,yy=b*100+d-4800+m/10
(if %mm% LSS 10 set mm=0%mm%)&(if %dd% LSS 10 set dd=0%dd%)
(if %hh% LSS 10 set hh=0%hh%)&(if %nn% LSS 10 set nn=0%nn%)
if %ss% LSS 10 set ss=0%ss% 
endlocal&set %7=%ss%&set %6=%nn%&set %5=%hh%&^
set %4=%dd%&set %3=%mm%&set %2=%yy% & goto :EOF

:TrimYearValue
set /a i=%1
set tt=%i%
REM echo/input is :%i%: - result :%tt%: test
endlocal & set "%1=%tt%" & goto :EOF