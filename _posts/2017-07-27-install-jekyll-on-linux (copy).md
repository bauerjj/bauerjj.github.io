---
layout: single
title: Installing jekyll on Linux
context: Ramblings
date: 2017-07-27 
categories: blog
---

I use [jekyll](https://jekyllrb.com/docs/installation/) on some of my projects to produce a static html web page, like this one. I can easily edit the source and have an OK looking frontend without doing much CSS work. I find myself googling a few things from the errors I get inside the terminal as I try to install jekyll and all the necessary components needed to serve my web page. Here is a condensed version of what needs to be installed to have your github page served locally. 

 1.  `sudo apt-get install ruby gem ruby-dev ruby-bundler zlib1g-dev nodejs`
 2.  `sudo gem install jekyll nokogiri`
 3.  `bundle install`

Finally, in your github pages repo, you can now run `bundle exec jekyll serve` 
