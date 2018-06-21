# ReadingTimeDemo

[![Build Status](https://octodemo-readingtimedemo.visualstudio.com/_apis/public/build/definitions/dbf9afd8-37d7-4edf-9e1f-eac97e3a06c3/1/badge)](https://octodemo-readingtimedemo.visualstudio.com/ReadingTimeDemo/_build/index?definitionId=1)

## Purpose

This is a Web application that lists staff favorite books. Users can subscribe to the list by submitting their e-mail address at the bottom of the page.

## Installing

### Visual Studio

Follow these steps to install the `ReadingTimeDemo`:
- Clone the repository on your local machine using Git command-line, from GitHub using GitHub Desktop or Visual Studio or direct from Visual Studio.
- Open the solution in Visual Studio.
- Select Test, Run, All Tests (Ctrl+R, A) to restore the project and run all tests.
- Select Debug, Start without debugging (Ctrl+F5).
- Open the Solution Explorer to work with the project files or the Team Explorer to work with GitHub from Visual Studio.

### Run on the command-line

Follow these steps to run the applicaiton from the command-line:

- Clone the project
- `cd` into the project and run the following commands:

```
dotnet restore
dotnet build
dotnet test test/ReadingTimeDemo.UnitTests
dotnet run --project src/ReadingTimeDemo/ReadingTimeDemo.csproj
```

## Contributing

Contributions are welcome. If you want to contribute to the project please fork the repository to make any code changes and open a Pull Request to propose your changes to the core team. Please make sure to follow the [Microsoft coding conventions](https://msdn.microsoft.com/en-us/library/ff926074.aspx) and add unit tests to ensure the build quality. For unit tests we currently use [xUnit](https://xunit.github.io/).

## About
The `ReadingTimeDemo` is a demo Web application using .NET Core 2.0, NuGet and xUnit and Azure for continuous deployment.


