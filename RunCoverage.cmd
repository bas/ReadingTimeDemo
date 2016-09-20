@echo off
SET requiredcoverage=90
SET filter="+[ReadingTimeDemo]* -[ReadingTimeDemo]*Startup -[ReadingTimeDemo]*Program"

SET opencoverversion=4.6.519
SET reportgeneratorversion=2.4.5
SET coverallsversion=1.3.4

SET packages=C:\Users\bas\.nuget\packages
SET opencover=%packages%\OpenCover\%opencoverversion%\tools\OpenCover.Console.exe
SET reportgenerator=%packages%\ReportGenerator\%reportgeneratorversion%\tools\ReportGenerator.exe
SET coveralls=%packages%\coveralls.io\%coverallsversion%\tools\coveralls.net.exe

SET targetdir=%~dp0test\ReadingTimeDemo.UnitTests\bin\Debug\netcoreapp1.0
SET coveragedir=coverage

SET coveragefile=coverage.xml

SET corerunargs=test "%~dp0test\ReadingTimeDemo.UnitTests\project.json"

%opencover% -oldStyle -filter:%filter% -register:user -targetdir:%targetdir% -target:dotnet.exe -output:%coveragefile% -targetargs:"%corerunargs%"

::%coveralls% --opencover %coveragefile% --full-sources

%reportgenerator% -targetdir:%coveragedir% -reporttypes:Html -reports:%coveragefile% -verbosity:Error

set "coverage="
for /f "tokens=6 delims=<>" %%a in (
  'find /i "Line coverage:" ^< "%~dp0%coveragedir%\index.htm"'
) do set "coverage=%%a"

if %coverage% geq %requiredcoverage% (
  echo Pass: the coverage percentage is: %coverage%
) else (
  echo Fail: the coverage is %coverage%
)