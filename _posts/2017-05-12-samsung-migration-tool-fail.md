---
layout: single
title: Samsung Migration Tool Fail
context: Ramblings
date: 2017-05-12 08:03:00
categories: blog
---

I tried the [Offical Samsung Data Migration Tool](http://www.samsung.com/semiconductor/minisite/ssd/download/tools.html) to clone one of the approved Samsung EVO series SSDs to a larger one so that I could use it in another laptop. I was met with an ambiguous error code of `-00001` with some other text. It would never begin the process and would hang after 50 seconds of it transferring it. I then tried various other things that google suggested to me such as cleaning the recycle bin, deleting restore points and Windows Pagefile, and defragmenting. I suspected that the SATA-to-USB converter may have had a faulty chipset or something, however I ended up using another program called [Macrium Reflect](https://www.macrium.com/reflectfree) that worked! I simply used their free edition and a few clicks and 25 mins later, my 255 GIG SSD was transfered. I also tried another cloning program called [MiniTool Partition Wizard](https://www.macrium.com/reflectfree) which also failed. 

The one downside of Macrium is that is a fairly large download of a couple hundred MB. Other than that - worked great. All you have to do is click `Clone this Disk...` and select your target and then begin. You will more than likely need to install additional hardware drivers on your new machine if you plan on placing the cloned SSD into a new laptop. You can get the drivers installed auto-magically from Dell which has become surprisingly streamlined since you can now download an auto-detection program that will download and install the drivers for you. 

![Macrium Reflect working](/assets/images/macrium.png)

Also note that I did a 1:1 clone that did NOT extend the existing partitions, meaning that I had to enter the disk manager on the new laptop after the transfer, right-click my NTFS partition and click "Extend Partition". Now the unallocated space was moved to the primary partition. 

