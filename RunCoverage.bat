@echo off
SET filter="+[ReadingTimeDemo]* -[ReadingTimeDemo]*Startup -[ReadingTimeDemo]*Program"

:: Update this when OpenCover or ReportGenerator are updated
SET opencoverversion=4.6.519
SET reportgeneratorversion=2.4.5

SET packages=C:\Users\appveyor\.nuget\packages
SET opencover=%packages%\OpenCover\%opencoverversion%\tools\OpenCover.Console.exe
SET reportgenerator=%packages%\ReportGenerator\%reportgeneratorversion%\tools\ReportGenerator.exe

SET targetdir=%~dp0test\ReadingTimeDemo.UnitTests\bin\Debug\netcoreapp1.0
SET coveragedir=coverage

SET resultsfile=testresults.xml
SET coveragefile=coverage.xml

:: Now, run the actual tests and generate a coverage report
SET corerunargs=test "%~dp0test\ReadingTimeDemo.UnitTests\project.json" -xml %resultsfile%

%opencover% -oldStyle -filter:%filter% -register:user -targetdir:%targetdir% -target:dotnet.exe -output:%coveragefile% -targetargs:"%corerunargs%"

%reportgenerator% -targetdir:%coveragedir% -reporttypes:Html -reports:%coveragefile% -verbosity:Error