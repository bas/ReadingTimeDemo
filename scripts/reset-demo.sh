#!/usr/bin/env bash
read -p  "Do you want to reset the demo to the baseline tag (Y/N)?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  # Force push HEAD to baseline
  echo "Reverting master to baseline tag"
  git fetch --tags
  git checkout master
  git reset --hard baseline
  git push origin baseline:master -f
fi
