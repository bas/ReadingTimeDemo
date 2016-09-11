@echo off
if not exist .git goto noroot

for /f "delims=" %%a in ('git rev-parse --abbrev-ref HEAD') do @set branch=%%a

if %branch% == 'master' goto master

xcopy ".\scripts\resources\src\*" ".\src" /s /i /y

set /P input="Commit code changes on branch '%branch%' (Y/N)?"
if /i "%input%" == "n" goto end

git add src/
git commit -m "Added rating model, view and service"

set /P input="Push code changes on branch '%branch%' (Y/N)?"
if /i "%input%" == "n" goto end

git push origin HEAD

goto end

:noroot
echo Please execute this script from the project root folder
echo Example: .\scripts\code-feature.cmd
goto end

:master
echo Your current branch is master, please first create a feature branch
echo For example: git checkout -b add-rating-feature
goto end

:end
