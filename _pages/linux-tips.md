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
 * `>>` appends, use `>` for overwriting. 
	  - Ex: Appends to text file `echo "foo" >> ~/tmp.txt`
      - Ex: Overwrites `echo "foo" > ~/tmp.txt' 
 * To extract zip files: `unzip <file.zip> -d <destination>`
 * Get the last error code `$?` 
 * `test`

## Utilities 

`disks` for formatting


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
