---
layout: single
title: Automate Jekyll Production 
context: Ramblings
date: 2017-07-27 
categories: blog
comments: true
---

The main benefit I see of using jekyll is being able to edit a plain markdown file and have it appear live on the Internet in just a few seconds. In order for this to happen, I have to perform the following:

1. Make an edit
2. Build the website
3. Commit and push the changes to `gh-pages` branch
4. Copy the contents under `_site` from the `gh-pages` folder into the `production` folder
5. `CD` into the production-ready folder
6. Commit and push the changes to the `master` branch
7. Wait 5 seconds for github to publish the changes live on github.io. 

I wanted a way to automate this. 

I have to perform the above steps since I am using [jekyll-maps](https://github.com/ayastreb/jekyll-maps) which is not one of the [approved plugins](https://pages.github.com/versions/) that I can use on github pages. This forces me to NOT have github automatically build my jekyll site. I must therefore upload all of the static HTML content on my master branch and have my source files in a `gh-pages` branch. Github pages will serve the static content from the master branch live for you for free! 

I created two folders, one for production and one for source edits. I did the following after already creating the gh-pages branch previously:

1. `cd ~/Documents/github`
2. `mkdir production source`
3. `cd production; git pull <my_git_repo>.git; git checkout master`
4. `cd ../source; git pull <my_git_repo>.git; git checkout gh-pages`

I have already forked a [jekyll theme](https://github.com/mmistakes/minimal-mistakes) that includes all of the scaffolding. I can `CD` into the `source` folder, make an edit, and push my changes. I can see the website live on my localhost by running `bundle exec jekyll serve`. All of the links are relative to my localhost, so I now need to `export JEKYLL_ENV=production` so that jekyll will produce links with my `http://bauerjj.github.io` baseurl. 

This is where I encounter a [jekyll bug](https://github.com/jekyll/jekyll/issues/6057) that causes a double slash (//) in place of where a single slash should be (/). For example, links will show up as `http://bauerjj.github.io//blog` instead of `http://bauerjj.github.io/blog`. I followed [jira 6057](https://github.com/jekyll/jekyll/issues/6057) and its proposed solution of using [URLFilters](https://github.com/jekyll/jekyll/pull/6058), however I was not able to resolve my problem. I created a simple script instead that fixes the slashes in the `_site` directory by iteratiing through all of the files and performing a replace. My config has this: `baseurl                  : "////"`. Notice how I put multiple slahes. This was so that the script could look for 5 slashes and do the replace since some valid `//` occur such as those in an `http://` url. 

```
#!/bin/bash
# Small script that replaces \\\\\ with a single \ 
FILES=$(find ./ -type f -name '*')
for file in $FILES; do
   sed -i -e 's/\/\/\/\/\//\//g' $file
done
```

I then needed a method to monitor the source directory for any changes and then commit, push, and deploy the static content up to github for me. I used [gitwatch](https://github.com/nevik/gitwatch) and forked it so that I could customize it do run my `replace.sh` script, copy the static contents to my production folder, and then commit/push everything to github. You can see my simple changes to the script [on my own fork](https://github.com/bauerjj/gitwatch/blob/master/gitwatch.sh). Now, just execute `./gitwatch` and watch it do its magic whenever you edit a source file!
 
Please let me know if you have any problems. 








