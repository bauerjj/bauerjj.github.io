---
layout: single
title: Speeding Up Native Compiling and Cross-Compiling Time with ccache
context: Ramblings
date: 2017-04-13 08:03:00
categories: blog
comments: true
---

It took me years to finally realize that I could greatly speed up compilation time using a utility called `ccache`. 

{% include toc %}

It is essentially a wrapper around your compiler, most likely g++, that caches the compiled objects from your source and saves them in your home directory (`.ccache` folder) so that subsequent builds with the *identical environment settings* will use the cache. Not using it is pretty much wasting time. Sourcing an environment script that changes any compiler flags or targets that are different from the already compiled objects from the same source files in prior builds will inflict a "cache miss". 

To install: `sudo apt-get install ccache`

`ccache` includes the compiler name in the hash as shown in the [manual](http://ccache.samba.org/manual.html#_common_hashed_information), making it safe for multiple architectures to use `ccache`. 

## Native Compiling

In your `.bash_rc` file or similar, place: `export PATH=/usr/lib/ccache:$PATH`

Run `which gcc` to ensure that it is pointing at ccache. The paths that show up first in the variable are parsed first - a "first come first served" situation. 

To verify operation and see the cache grow in size, start compiling something and invoke the following:
```
jbauer@ad-dell:~$ watch -n 1 ccache -s

Every 1.0s: ccache -s               Thu Apr 13 14:32:22 2017

cache directory                     /home/jbauer/.ccache
primary config                      /home/jbauer/.ccache/ccache.conf
secondary config      (readonly)    /etc/ccache.conf
cache hit (direct)                    56
cache hit (preprocessed)               0
cache miss                          1991
called for link                      369
no input file                          2
files in cache                      4217
cache size                         962.5 MB
```

You can also just use this to print out the stats directly: `jbauer@ad-dell:~$ ccache -s`

## Cross-Compiling
Similar methodology can be used to have your cross-compilers utilize `ccache`. I'm usually using Yocto, which creates an SDK for your target and contains an environment script that I can then `source` and begin compilation for the embedded target. 

1. Install the Yocto supplied SDK after bitbaking it. 
2. Open your environment script and find the name of your cross-compiler. My location was: `/opt/poky/2.1.2/environment-setup-cortexa9hf-neon-poky-linux-gnueabi`. The compiler name is then found under the `export CC=` line. 
3. Create two soft links in your `ccache` directory

		$ cd /usr/lib/ccache
		$ ln -s /usr/bin/ccache arm-poky-linux-gnueabi-g++ 
		$ ln -s /usr/bin/ccache arm-poky-linux-gnueabi-gcc 


4. Re-open your environment script and prepend `/usr/lib/ccache` in the `PATH` variable. This ensures that your machine will first look in your `ccache` directory for the compilers. Omitting this step will require you to manually export the PATH variable after sourcing the script or else `ccache` will never do its job. 

		export PATH=/usr/lib/ccache:/opt/poky/2.1.2/sysroot/....

5. Verify your work 

		$ ls -al
		lrwxrwxrwx 1 root root 16 Apr 13 13:25 arm-poky-linux-gnueabi-g++ -> ../../bin/ccache
		lrwxrwxrwx 1 root root 16 Apr 13 13:25 arm-poky-linux-gnueabi-gcc -> ../../bin/ccache
		lrwxrwxrwx 1 root root 16 Mar 21 12:24 c++ -> ../../bin/ccache
		lrwxrwxrwx 1 root root 16 Mar 21 12:24 c89-gcc -> ../../bin/ccache
		lrwxrwxrwx 1 root root 16 Mar 21 12:24 c99-gcc -> ../../bin/ccache
		lrwxrwxrwx 1 root root 16 Mar 21 12:24 cc -> ../../bin/ccache
		lrwxrwxrwx 1 root root 16 Mar 21 12:24 g++ -> ../../bin/ccache
		lrwxrwxrwx 1 root root 16 Mar 21 12:24 g++-5 -> ../../bin/ccache
		lrwxrwxrwx 1 root root 16 Mar 21 12:24 gcc -> ../../bin/ccache
		lrwxrwxrwx 1 root root 16 Mar 21 12:24 gcc-4.8 -> ../../bin/ccache
		lrwxrwxrwx 1 root root 16 Mar 21 12:24 gcc-5 -> ../../bin/ccache
		lrwxrwxrwx 1 root root 16 Mar 21 12:24 x86_64-linux-gnu-g++ -> ../../bin/ccache
		lrwxrwxrwx 1 root root 16 Mar 21 12:24 x86_64-linux-gnu-g++-5 -> ../../bin/ccache
		lrwxrwxrwx 1 root root 16 Mar 21 12:24 x86_64-linux-gnu-gcc -> ../../bin/ccache
		lrwxrwxrwx 1 root root 16 Mar 21 12:24 x86_64-linux-gnu-gcc-4.8 -> ../../bin/ccache
		lrwxrwxrwx 1 root root 16 Mar 21 12:24 x86_64-linux-gnu-gcc-5 -> ../../bin/ccache


## Setting up QtCreator
You can utilize `ccache` inside of QtCreator by selecting your native and cross-compiler links inside of the `ccache` directory. Below shows two screenshots of setting up my cross-compiler. Notice how I had to manually locate both gcc and g++ and instruct Qt what they are targeting. Your paths will differ slightly since I have my project defined as "Armadillo" or "ado".  

![QtCreator Cross-Compiler](/assets/images/kit-overall.png)

![QtCreator Cross-Compiler](/assets/images/gcc-ccache.png)

Be sure to source your environment before launching QtCreator!
