---
layout: full
title: Linux Tips
sitemap: true
permalink: /linux-tips/
author_profile: false
excerpt: I'm going to dedicate this page to be a "living document" of random linux tips that I stumble upon as I go through life
tags: []
---

I'm going to dedicate this page to be a "living document" of random linux tips that I stumble upon as I go through life. 

{% include toc %}


## Jekyll

- Gems are located here: `C:\tools\ruby23\lib\ruby\gems\2.3.0\gems`
- Run the webserver: `bundle exec jekyll serve` 
- To install new gems or update to newer version: `gem install`
- To actually use the newer gem version: `bundle update`
- See installed gems and their version: `gem list`


## Debugging Linux Kernel

It is useful to look at the output from the kernel if it crashes so that you can see the root cause of the problem. This happened a bunch of times to me when developing kernel modules. 

Follow this [tutorial](http://blog.zedroot.org/linux-kernel-debuging-using-kdump-and-crash/) to use ubuntu's crash utility and [here](https://people.netfilter.org/hawk/presentations/debugging_conf2013/debug2013_kernel_panic_decode_JesperBrouer.pdf) for commands: Download the [uncompressed kernel image](https://launchpad.net/ubuntu/xenial/amd64/linux-image-4.4.0-53-generic-dbgsym/4.4.0-53.74) for ubuntu-xenial. 

ex usage: `sudo crash /usr/lib/debug/boot/vmlinux-4.4.0-53-generic /var/crash/201701201431/dump.201701201431`
Type in `log` and scroll down till the last few seconds to see the root cause

## Common Linux Commands

 * `lsmod` = list current loaded modules
http://free-electrons.com/doc/legacy/command-line/command_memento.pdf
 * `insmod/modprobe` = insert module
 * `rmmod` = remove module
 * `ifconfig -a` = lists all connectivity, even the deactivate ones. Use it to view how many bytes have been TX/RX
 * `history | grep xxxx` = filter history commands - http://www.linfo.org/pipes.html
 * `dmesg | tail -20` = show last 20 lines of dmesg
 * To search through the previous commandline output, use the following: `make | tee output.txt`
 * `grep "warning" output.txt`
 * Use `sync` anytime after issuing a `dd` command
 * To search for a specfic string in a bunch of files: `grep -rnw '/path/to/somewhere/' -e "pattern"`     `http://stackoverflow.com/questions/16956810/how-to-find-all-files-containing-specific-text-on-linux`
 * Send the `SIGQUIT` signal with `Ctrl+\`
 * `lsof | grep '<process>'` will list any process that are holding a handle on the given <process>
 * `rm -rf <dir>` does not remove hidden files/folders!!!
 * `CTRL+D` will send an "end of file" to the running script, usually shutting it down
 * `rsync` looks to be useful in copying files remotely and locally
 * `udhcpc -i eth0` gets new IP from dhcp server for `eth0`
 * `dmesg | grep tty` to find connected serial ports. Often virtual USB->Serial devices enumerate as ttyUSB0/ttyUSB1/etc
 * [SysV to SysD Cheatsheet](https://fedoraproject.org/wiki/SysVinit_to_Systemd_Cheatsheet)
 * To open a 2-way socket connection via shell: `socat - UNIX-CONNECT:<location_of_socket>`
 * [Reason behind `kilall -9`](https://unix.stackexchange.com/a/254506)
 * `aplay -D hw:0,0 <my_file.wav>` specifies the card and device. [More Info](https://superuser.com/questions/53957/what-do-alsa-devices-like-hw0-0-mean-how-do-i-figure-out-which-to-use)
 * Find active sshd connections with IP or other services (if running systemV): `systemctl | grep running`. [More Info](https://askubuntu.com/a/795242)
 * [Formatting with colors inside of bash](http://misc.flogisoft.com/bash/tip_colors_and_formatting)
    - RED='\033[0;31m'
    - GREEN='\033[0;32m'
    - YELLOW='\033[0;33m'
    - NC='\033[0m' # no color
 * `set -e` causes the shell to exit if any subcommand or pipeline returns a non-zero status.
 * [Load uncompressed kernel image in ARM](http://free-electrons.com/blog/uncompressed-linux-kernel-on-arm/)
 * To convert string to all lowercase: `echo "MyStRiNG" | awk '{print tolower($0)}'`
 * If you want to remount a fs from read-only to RW, do: `mount -orw,remount /dev/root`
 * x window trick to learn executable name based on x window: 
	* `sudo apt install x11-utils` 
    * `xprop WM_CLASS`
    * *click on window* *see output*. That output will show executable name of that window! No more running top to try and discern the actual process name!
 * Use `xdg-open` to open any file using its default handler (ex: `xdg-open mytext.txt` will use default text viewer)
 * Use the [online debian package search](https://packages.debian.org/search?searchon=contents&keywords=sdl-config) to find how to spell the special debian package that contains what you need
 * An equivalent of `dd if=/dev/zero` is: `tr '\0' '\377' < /dev/zero | dd bs=64K of=/dev/sdx` from [source](https://stackoverflow.com/questions/10905062/how-do-i-get-an-equivalent-of-dev-one-in-linux)
 * [How to use tar and gzip](https://www.crybit.com/difference-between-tar-and-gzip/)
 * > A block device is a special file that refers to a device. A block special file is normally distinguished from a character special file by providing access to the device in a manner such that the hardware characteristics of the device are not visible.
 * CPPFLAGS is supposed to be for flags for the C PreProcessor; CXXFLAGS is for flags for the C++ compiler. The default rules in make (on my machine, at any rate) pass CPPFLAGS to just about everything, CFLAGS is only passed when compiling and linking C, and CXXFLAGS is only passed when compiling and linking C++
 * You can always remount the fs RW with `mount -orw,remount /dev/root`
 * [Sending stdout to multiple commands](https://unix.stackexchange.com/questions/28503/how-can-i-send-stdout-to-multiple-commands)
	* `grep --color=always --exclude-dir=".svn" --exclude-dir=".git" -rnw ./ -e "armadillo-image-install" -l | tee >(wc -l)`
 * To shutdown: `init 0` or `shutdown -h now`
 * `export MAKE_CPU_COUNT=1` before compilation to easily find any errors. If using multiple build threads, redirect STDOUT and STDERR to a file to grep: `MAKE_CPU_COUNT=25; ./update_dependencies 2>&1 | tee ~/Desktop/build-dep.log`
 * To find files with certain extensions: `grep connx -r -i -n --include=*.{cpp,h,pro}`
 * `cat /dev/ttyUSB0` will show continuous data on the serial port. No baud necessary. You can't interact though. 
 * `sudo screen /dev/ttyUSB0 115200` opens a two-way connection with a serial port at 115200 baud
	* To Quit: “Ctrl-a” then “k”
	* Add this to your ~/.screenrc.
	```
	# Enable mouse scrolling and scroll bar history scrolling
	termcapinfo xterm* ti@:te@
	```
 * move back to previous directory in history `cd -`
 * Use `ghex2` to visually change some bytes in a binary
 * To find where USB serial devices enumerate as: `ls -l /sys/bus/usb-serial/devices`
 * Use `htop` as a substitute of `top` for more detailed info on system processes
 * On mounting a single partition within a single image: https://unix.stackexchange.com/a/230632
     * Be sure the units are correct `sudo parted <my_disk.img> unit s print`
 * 'fc-query <name_of_ttf_file> to get the name of the 'font-family'

### Commandline

 * From http://teohm.com/blog/shortcuts-to-move-faster-in-bash-command-line/
 * Move back one character. Ctrl + b
 * Move forward one character. Ctrl + f
 * Undo. Ctrl + -
 * Move to the start of line. Ctrl + a
 * Move to the end of line. Ctrl + e
 * Cut from cursor to the end of line. Ctrl + k
 * Cut from cursor to the end of word. Ctrl + d

### Variables and Quotes
 * Putting spaces around equals sign (=) will cause the shell to mistake the variable name for a command name
 * Can surround variable name with curly braces for clarity: `${myvar}
   - `lang="dutch"
   - `echo "I speak ${lang}" => I speak dutch
   - `echo 'I speak ${lang}' => I speak ${lang}
 * Back quotes, or back-ticks, are treated the same as double quotes, but they also execut contents of the string as a shell command
   - echo "There are `wc -l < /etc/passwd` lines in the passwd file => There are 28 lines in the passwd file
 * STDIN, STDOUT, STDERR correspond to file descriptors of 0, 1, and 2 ALWAYS
   - Redirects both STDOUT and STDERR: `>&`
   - Redirect only STDERR: `2>`
   - To use the search command and ignore all ERR messages such as when running as an unprivledged user, use: `find / -name core 2> /dev/null
 * `tee` copies input to two places, like a tee fixture in plumbing. 
   - `find / -name core | tee /dev/tty | wc -l`: Prints both the pathnames of files named core and the number of files that were found to BOTH the terminal and tty serial output
   - Use `tee` most often when using a command that will take a long time to run. You can preview the initial results to make sure eveyrthing is working before letting it run and save to a file. 
 * `tail -f` wait for newlines to be printed to the end of the file and print them. Beware of buffered outputs tho
 * `grep`
   - -i to ignore case
   - -l print only names of matching files rather than printing each line that matches
   - `grep -l mdadm /var/log/*` prints log entries from `mdadm` have appeared such as `/var/log/auth.log` and `/var/log/syslog.0`
 * `find . -type f -name '*.log' | while read fname; do echo mv $fname ${fname/log/.LOG/}; done | bash -x` finds files with matching .log extension and then ranames them all to uppercase .LOG. This prints the commands to the terminal and then executes the steps in bash. @see pg 39
 * `$0`: name of file of script that is invoked. `$#` total of arguments supplied. 





### Git

 * [Merging/rebasing](https://stackoverflow.com/questions/25933056/how-can-i-do-a-bugfix-on-master-and-integrate-it-into-my-less-stable-branches/25934341#25934341)
 * [Pretty git branches software](https://stackoverflow.com/questions/1057564/pretty-git-branch-graphs)

### svn
 * View externals URLs `svn propget -R svn:externals`
 * Setup an external `svn propset svn:externals 'myExternalFolderDestination <my_url>'`

### systemd

 * Currently running processes: `systemctl | grep running`
 * Show enabled processes: `systemctl list-unit-files | grep enabled`
 * `>>` appends, use `>` for overwriting. 
	  - Ex: Appends to text file `echo "foo" >> ~/tmp.txt`
      - Ex: Overwrites `echo "foo" > ~/tmp.txt' 
 * To extract zip files: `unzip <file.zip> -d <destination>`
 * Get the last error code: `$?`
 * Get kernel headers: `sudo apt-get update` && `sudo apt-get install linux-generic`. Note, this will only install the headers for the currently booted kernel version. You can find the files in `/lib/modules`
 

Get the correct headers: `sudo apt-get update && sudo apt-get install linux-headers-$(uname -r)`


### u-boot

 * list files in partition: `fatls mmc 2:1`
 * load file into u-boot memory: `load mmc 2:1 10800000 <file>
 * To test if multiple cores are present, use `cpu <n> test` 
 * The variable, `filesize` is automatically set to equal the size of the kernel `zImage.bin`


## Utilities 

`disks` for formatting
[Unix as an IDE](https://sanctum.geek.nz/arabesque/series/unix-as-ide/)
### Expect
 * [expect programming](http://www.thegeekstuff.com/2010/10/expect-examples) for automated scripts over ssh or from std input
 * [More expect programming](https://likegeeks.com/expect-command/)
 * [All available commands](https://www.tcl.tk/man/expect5.31/expect.1.html)
 * `#!/usr/bin/expect -d` for debugging

## Bash

 * To ignore a section of code: 

  ```
  : <<'END'
  <blah>
  <blah>
  END
  ```

 * To copy/paste pipe inside the terminal using BASH: https://stackoverflow.com/a/27456981
   - `sudo apt-get install xclip` then `xclip -sel clip < <whatever you want to copy to clipboard>
 * [usage() function example](https://stackoverflow.com/a/687820)

## vim

 * To enable color highlighting, paste this into ~/.vimrc:
   ```
    if $COLORTERM == 'gnome-terminal'
  		set t_Co=256
	endif
   ```

## Yocto Stuff

 * Use [hands-on labs about kernel development](https://www.yoctoproject.org/sites/yoctoproject.org/files/elc2013-kernel-lab.pdf)
 * [Good resource for adding stuff to kernel](https://www.yoctoproject.org/sites/yoctoproject.org/files/elc2013-kernel-lab.pdf) 
 * Excellent resource on bitbake stuff [Yocto / Bitbake notes](https://confluence.agjunction.net:8443/pages/viewpage.action?pageId=82481008)
 * Page 19 shows how to tell if module was built and how to auto-load it
rootfs: build-root/poky/build-max-atom/tmp/work/max_atom-poky-linux/max-image-install/1.0-r0
 * CheatSheet bitbake cmds: https://community.nxp.com/docs/DOC-94953
 * Another cheatsheet: http://www.openembedded.org/wiki/Bitbake_cheat_sheet
 * bitbake max-image-base and bitbake linux-yocto -f -c compile
main config: yocto/build-root/poky/meta-agj/meta-max/conf/distro/poky-max.conf
	PN - Name of package.
	PR - Revision of package. The default value is "r0"
	PV - Version of package.
 * On deleting images: https://lists.yoctoproject.org/pipermail/yocto/2012-July/008296.html
	bitbake -c clean TARGET
	then, bitbake TARGET
 * To force more threads for compilation, use: {{BB_NUMBER_THREADS}} in local.conf
 * If you run into build errors, run bitbake -c cleansstate <packagename>
 * List Recipes :: bitbake-layers show-recipes | less
 * Good info on creating layers
bitbake-layers show-appends shows all of the .bbappend files
 * It is vital that the S variable is set to ${WORKDIR} or else you may see "lic_files_chksum invalid: points to invalid location" errors. @see http://www.yoctoproject.org/docs/1.7.1/ref-manual/ref-manual.html#var-S
 * Good info on how to include files in the rootfs: http://stackoverflow.com/questions/34067897/bitbake-not-installing-my-file-in-the-rootfs-image
 * To learn how to replace the default splash image: https://www.mail-archive.com/yocto@yoctoproject.org/msg08094.html
 * Differences between, clean, cleanall, and cleansstate
 * clean: Removes all output files for a target 
 * cleansstate:Removes all output files and shared state (sstate) cache for a target
 * cleanall: Removes all output files, shared state (sstate) cache, and downloaded source files for a target
 * Search for the manifest file inside of the deploy folder to figure out which packages have been included in the image
 * Show all available recipes: bitbake-layers show-recipes
 * `TOOLCHAIN_HOST_TASK` and `TOOLCHAIN_TARGET_TASK` variables can be modified to include packages that can run on host or target inside the SDK when you run `bitbake -c populate_sdk`
 * `IMAGE_FEATURES` in the mega-manual lists what available options there are for this
 * Add the following to your `local.conf` to add build history and package size information for images:
	```
	INHERIT += "buildhistory"
	BUILDHISTORY_COMMIT = "1"
 *  `export BB_NUMBER_THREADS=7` will take advantage of more cores. You can also set this inside of your `local.conf`
	```
 * Use `PACKAGECONFIG_CONFARGS` if the `bb` file doesn't have explicitly set up the array like this: `PACKAGECONFIG[f1] = "--with-f1,--without-f1,build-deps-f1,rt-deps-f1"`
 * If you get an error, set CPU thread to 1 by `export MAKE_CPU_COUNT=1` and/or `BB_NUMBER_THREADS="1"` in your local.conf. Then bitbake to see the error without having to scroll all over the place. You can also just grep the log output if using multi-thread. 
 * To find similar recipes by part of the name: `bitbake-layers show-recipes "*-image-*"`
 * To find recipes in numerous layers: http://layers.openembedded.org/layerindex/branch/krogoth/layers/
 * `inherit core-image` will also pull in the `packagegroup-base.bb` recipe inside of poky. Look in this for ideas to add to `FEATURE_INSTALL` such as X11, zeroconf, etc
 * you can force any individual bitbake command with `bitbake <recipe> -f -c <step>` will force the build step
 * The standard BitBake behavior in most cases is: do_fetch, do_unpack, do_patch, do_configure, do_compile, do_install, do_package, do_package_write_*, and do_build


### Docs

[Users Guide](http://www.bcmcom.com/CustomerDL/AR6MXCS/Freescale_Yocto_Project_User's_Guide.pdf)
[Mega Manual]


### Yocto Errors

#### Error: "Files/directories were installed, but not shipped in any package: xxx"

This means that the recipe was successfully compiled, but doesn't know what files to add to the resultant package. This can be resolved by adding this to the individual recipe file (for example, see the init-script.bb file inside of armadillo):
`FILES_${PN} += "init"`
This says to package the "init" file from the resultant recipe. Omitting this line will cause the above error. If you want to include the -dev binary, simply do:
`FILES_${PN}-dev += "init"`
The will place the packages inside of: `build/tmp/work/cortexa8hf-neon-poky-linux-gnueabi`. [See here for more info](http://www.yoctoproject.org/docs/latest/ref-manual/ref-manual.html#var-FILES) 

#### Error: "QA Issue: <package> not found in the base feeds (ad10 coretex-......blah blah)"

You get this error when bitbake can't find the file in the PACKAGES directive. You can check in the `/tmp/work/cortexa.../<package>` directory to see that it did actually compile the source. Consult the mailing list for more info.
One solution was to add a bbappend file for the <package> that included one line: `ALLOW_EMPTY_${PN} = "1"`. This will get rid of the error, but it WON'T actually include anything since the <package> binary is missing in the work folder. 

## Random

### Ubuntu
 - Chromium doesn't support panning out of the box like it does in Windows. You have to download the [AutoScroll Extension](https://chrome.google.com/webstore/detail/occjjkgifpmdgodlplnacmkejpdionan) to get the panning working with the push of the middle button

### Cryptography

 > An analogy to public key encryption is that of a locked mail box with a mail slot. The mail slot is exposed and accessible to the public – its location (the  street address) is, in essence, the public key. Anyone knowing the street address can go to the door and drop a written message through the slot. However, only the person who possesses the key can open the mailbox and read the message.

 > An analogy for digital signatures is the sealing of an envelope with a personal wax seal. The message can be opened by anyone, but the presence of the unique seal authenticates the sender.
