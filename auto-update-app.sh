#!/bin/bash

REPO=candyland-app

cd "$REPO"
while true
do
    echo "Updating $REPO  at `date`"
    git status
    echo "Fetching"
    git fetch
    echo "Pulling"
    git pull
    echo "Done at `date`"
    echo
    sleep 300
done
