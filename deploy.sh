#/!bin/bash

TODAY=$(date +"%Y%m%d")

hexo g d
cd public
git add .
git commit -m "New gh-pages release $TODAY"
git push
cd ..