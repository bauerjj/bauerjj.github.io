---
layout: single
title: Fix tearing for NVIDIA in Ubuntu 18.04 Mate
context: Ramblings
date: 2018-10-22
categories: blog
comments: true
---

I noticed terrible tearing inside firefox after upgrading to 18.04 and getting new 2k monitors finally. I had a guess that it was related to vsync not being enabled, however the NVIDIA X Server Settings indicated that "Sync to VBlank" was already enabled and I took that to mean that vsync was enabled. I still had the problem until I [tried this solution](https://ubuntu-mate.community/t/fix-firefox-smooth-scrolling-tearing-youtube-video-tearing/17182/10) which was to enable vsync inside the proprietary driver. I changed my driver for my Quadro K2100M integrated graphics to using the "NVIDIA driver metapackage from nvidia-driver-390 (proprietary, tested)" inside of "Software and Updates". In summary, do the following:

```
$ sudo echo "options nvidia-drm modeset=1" >> /etc/modprobe.d/nvidia-drm-nomodeset.conf
$ sudo update-initramfs -u
$ sudo reboot
```

Check with:

`sudo cat /sys/module/nvidia_drm/parameters/modeset`

Now you can scroll vertically with no noticeable tearing. 
