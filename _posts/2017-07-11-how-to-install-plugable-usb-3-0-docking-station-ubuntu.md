---
layout: single
title: UD-3900 Pluggable Docking Station with Ubuntu Dual-Monitors
context: Ramblings
date: 2017-07-11 08:03:00
categories: blog
---

I struggled for a bit to get my [UD-3900](plugable.com/products/ud-3900/) working under Ubuntu MATE 16.04.2. Here are the steps I took:

1) Ensure that the kernel is AT LEAST 4.8 by running `uname -r`. I tried to downgrade my kernel to 4.4 after failing a few times to no avail.

2) Update your system. `sudo apt-get update` and `sudo apt-get dist-upgrade`

3) [Download the DisplayLink Driver](http://www.displaylink.com/downloads/ubuntu)

4) If you haven't already, install dkms `sudo apt-get install dkms`

5) `chmod a+x displaylink-driver-xxxx` 

6) `./displaylink-driver-xx`

7) nano `/usr/share/X11/xorg.cong.d/20-displaylink.conf`
   Paste this into that file:
```
Section "Device" 
  Identifier "Intel Graphics"
  Driver "intel"
EndSection
```

8) `reboot`

After a reboot, I had to wait 50 seconds before Ubuntu recognized the screens. If something went wrong, you can uninstall the driver `sudo displaylink-installer uninstall`

Use `lsusb` to see if the driver is installed or not. 

[DisplyLink Troubleshoot Article](http://support.displaylink.com/knowledgebase/articles/1181623-displaylink-ubuntu-driver-after-recent-x-upgrades)



