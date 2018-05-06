#!/bin/bash
set -e

dotnet restore ./ReadingTimeDemo.sln
dotnet test test/ReadingTimeDemo.UnitTests/ReadingTimeDemo.UnitTests.csproj

rm -rf ./obj/Docker/publish
dotnet publish ./ReadingTimeDemo.sln -c Release -o ./obj/Docker/publish