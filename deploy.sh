#!/usr/bin/env sh

# 若出現錯誤就停止
set -e

hexo g d

# cd 
cd public
git init
git add -A
git commit -m 'deploy'

# 部署到 https://<USERNAME>.github.io/<REPO>
git push -f https://github.com/gkfat/gkfat.github.io.git master:gh-pages

cd -