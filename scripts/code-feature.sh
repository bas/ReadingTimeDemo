#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
if [ $BRANCH == "master" ]
then
  echo "Your current branch is master, please first create a feature branch"
  echo "  For example: git checkout -b add-rating-feature"
  exit 1
else

  cp -rf $DIR/resources/src/* $DIR/../src/
  read -p  "Do you want to commit the code changes on branch '$BRANCH' (y/N)?" -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
    git add src/
    git commit -m "Added rating model, view and service"
    read -p  "Do you want to push the code changes on branch '$BRANCH' (y/N)?" -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      git push origin HEAD
    fi
  fi
fi