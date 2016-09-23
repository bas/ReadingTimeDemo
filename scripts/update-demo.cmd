@echo off
if not exist .git goto end

for /f "delims=" %%a in ('git rev-parse --abbrev-ref HEAD') do @set branch=%%a

if "%branch%" == "master" goto master

:master
set /P input="Do you want to update the current master branch to the baseline tag (Y/N)?"
if /i "%input%" == "n" goto end

git tag  -d baseline
git push origin :refs/tags/baseline
git tag baseline
git push origin baseline

:end
