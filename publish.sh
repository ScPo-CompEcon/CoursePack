#!/bin/bash

./build.sh

# Push the updates to gh-pages
mkdir -p /tmp/workspace
cp -r * /tmp/workspace/
git add -A .
git commit -m "Update Slides"
git checkout -B gh-pages
cp -r /tmp/workspace/* .
git add -A .
git commit -m "Update Slides"
git push origin master gh-pages
git checkout master
rm -rf /tmp/workspace
