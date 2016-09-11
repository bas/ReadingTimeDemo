@echo off
if not exist .git goto noroot

set /P input="Do you want to reset the demo to the baseline tag (Y/N)?"
if /i "%input%" == "n" goto end

git fetch --tags
git checkout master
git reset --hard baseline
git push origin baseline:master -f

:end
