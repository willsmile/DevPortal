# Thanks to http://themainthread.com/blog/2014/11/jekyll-new-post-script.html
# Also thanks to https://github.com/jackbaty/baty.net-hugo/blob/master/post.sh
DATE=`date +%Y-%m-%d`
DATETIME=`date +%Y-%m-%dT%H:%M:%S+09:00`
YEAR=`date +%Y`
TITLE=$1
FILE=content/post/$YEAR/$DATE-$TITLE.md

shift 2

cat > $FILE <<- EOM
---
title: "$TITLE"
date: ${DATETIME}
tags: [""]
draft: false

comment: false
toc: false
contentCopyright: '<a rel="license noopener" href="https://creativecommons.org/licenses/by-nc-nd/4.0/" target="_blank">CC BY-NC-ND 4.0</a>'
reward: false
mathjax: true
---
EOM