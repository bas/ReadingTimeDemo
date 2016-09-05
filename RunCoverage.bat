@echo on
REM Setting filters...
SET filter="+[ReadingTimeDemo]* -[ReadingTimeDemo]*Startup -[ReadingTimeDemo]*Program"

:: Update this when OpenCover or ReportGenerator are updated
REM Setting versions...
SET opencoverversion=4.6.519
SET reportgeneratorversion=2.4.5.0

REM Adding paths to packages...
SET packages=C:\Users\appveyor\.nuget\packages\.tools
SET opencover=%packages%\OpenCover\%opencoverversion%\OpenCover.Console.exe
SET reportgenerator=%packages%\ReportGenerator\%reportgeneratorversion%\ReportGenerator.exe

REM Setting target directories...
SET targetdir=%~dp0test\ReadingTimeDemo.UnitTests\bin\Debug\netcoreapp1.0
SET coveragedir=coverage

REM Setting file names
SET resultsfile=testresults.xml
SET coveragefile=coverage.xml

:: Now, run the actual tests and generate a coverage report
SET corerunargs=test "%~dp0test\ReadingTimeDemo.UnitTests\project.json" -xml %resultsfile%

REM Executing opencover...
%opencover% -oldStyle -filter:%filter% -register:user -targetdir:%targetdir% -target:dotnet.exe -output:%coveragefile% -targetargs:"%corerunargs%"

REM Executing report generator...
%reportgenerator% -targetdir:%coveragedir% -reporttypes:Html -reports:%coveragefile% -verbosity:Error