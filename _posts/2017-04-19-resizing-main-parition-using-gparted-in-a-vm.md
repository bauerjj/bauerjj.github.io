---
layout: single
title: Resizing Main Partition Using gparted in a VM
context: Ramblings
date: 2017-04-19 08:03:00
categories: blog
---

If your main partition (`/dev/sda1`) is filling up inside of your virtual machine, follow these steps to make it bigger inside of VMware Player

1. Locate the originally downloaded Ubuntu download image (~1.2GIG) or download it again
2. In VMware player, right-click the image and goto settings. Select CD/DVD (SATA) and then browse for the ubuntu image under Connection. Check the Enable at PowerOn checkbox.
3. Power on the image and during the initial splash screen, press F2to enter the BIOS. 
4. Change the boot sequence so that Boot From CD is first in queue. 
5. Restart the VM and when the CD boots up, press `Try Ubuntu`
6. Launch `gparted`
7. Temporarily remove the swap partition so that the unallocated region aligns with the first partition. 
8. Resize the main partition (/dev/sda1) to include all of the space MINUS 1024 MB!
9. Create an logical partition at the end and make it as the swap space.

![QtCreator Cross-Compiler](/assets/images/gparted.PNG)

10. Make sure to right-click the swap partition and select "SwapOn" 
11. Exit the live-cd and unmount the CD image inside of VMware player. You can leave the bios as is

## Converting a monolithic image to multiple separate files

When creating a VM, you can either create a single file or multiple files. The single file is better for performance, while the multiple file setup is easier to expand in 2GIG increments. Read [this article](https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=2006898) and then download [vdisk-manager](https://kb.vmware.com/selfservice/microsites/search.do?language=en_US&cmd=displayKC&externalId=1023856) since it doesn't come with VMPlayer and only Workstation in order to convert the large image into a lot of smaller separate files.