---
layout: single
title: Setup Leger Nano S on Ubuntu Linux
context: Ramblings
date: 2018-03-20 
categories: blog
comments: true
---

This is a quick HOW-TO for getting your new Ledger Nano S running in Ubuntu

**Install**

1. Choose a PIN on your Nano S
2. Record the 24-word seed on the supplied papers
3. Create a new udev rule so that ubuntu will recognize the USB device. 
	```
	sudo subl /etc/udev/rules.d/ledger.rules
	```
4. Paste the following into the udev rules file. Be sure to replace your username:
	```
	SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0000", MODE="0660", TAG+="uaccess", TAG+="udev-acl" OWNER="<UNIX username>"
	SUBSYSTEMS=="usb", ATTRS{idVendor}=="2c97", ATTRS{idProduct}=="0001", MODE="0660", TAG+="uaccess", TAG+="udev-acl" OWNER="<UNIX username>"
	```
5. Reload the rules. `udevadm control --reload-rules && udevadm trigger`. Optionally just unplug and replug your Nano S. 
6. Your Nano S should now present you with its public key on its screen. See the usb listing: 
	```
	lsusb -d 2c97:0001 -v
	```

**Verify Authenticity**

The following will ensure that you are using a valid Nano S. Sources: [Ledger Nano S help page](https://support.ledgerwallet.com/hc/en-us/articles/115005321449-How-to-verify-the-security-integrity-of-my-Nano-S-) and [Python Tools for Ledger Nano S](https://github.com/LedgerHQ/blue-loader-python)

1. `sudo apt-get install libudev-dev libusb-1.0.0-dev python-dev virtualenv`
2. `virtualenv ledger`
3. `source ledger/bin/activiate`
4. `pip install ECPy==0.8.1`
5. `pip install --no-cache-dir ledgerblue`
6. For firmware 1.3.1 or below: `python -m ledgerblue.checkGenuine --targetId 0x31100002` else `python -m ledgerblue.checkGenuine --targetId 0x31100003` 

You should now be confident in your device and be able to load apps using their [ledger manager](https://chrome.google.com/webstore/detail/ledger-manager/beimhnaefocolcplfimocfiaiefpkgbf)
