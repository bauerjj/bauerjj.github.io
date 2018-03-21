---
layout: single
title: Mpow Bluetooth Receiver Streambot Car Modification
context: Ramblings
date: 2018-03-12 
categories: blog
comments: true
---

I received an [Mpow Bluetooth Receiver](https://www.amazon.com/Mpow-Bluetooth-Receiver-Streambot-Hands-Free/dp/B00MJMV0GU) as a gift for use in my car. It quickly became apparent that I would have to manually turn ON the device everytime I got in my car to have it connect to my phone. This required a 2-3 second hold on the play/pause button. I also had to turn it OFF once I arrived at my apartment since my phone would stay connected to it after I left my car. I found this tedious, so I created a simple modification that would no longer require any turning ON/OFF the adapter. The bluetooth receiver would turn ON automatically with the car and connect to your phone. It would then turn OFF with the car battery. 

**Modification**:

***Parts***

1. [VN2222LL-G-ND](https://www.digikey.com/product-detail/en/microchip-technology/VN2222LL-G/VN2222LL-G-ND/4902401) MOSFET N-CH 60V 0.23A TO92-3
2. [445-2873-ND](https://www.digikey.com/product-detail/en/tdk-corporation/FK26X7R1C475K/445-2873-ND/1008899) CAP CER 4.7UF 16V X7R RADIAL
3. [100KXBK-ND](https://www.digikey.com/product-detail/en/yageo/MFR-25FBF52-100K/100KXBK-ND/13473) RES 100K OHM 1/4W 1% AXIAL
4. [RNF14FTD1K00CT-ND](https://www.digikey.com/product-detail/en/stackpole-electronics-inc/RNF14FTD1K00/RNF14FTD1K00CT-ND/1975018) RES 1K OHM 1/4W 1% AXIAL

The basic premise is as follows:

1. Car turns ON, button press is simulated as pressed immideiatly. Bluetooth search sequence initated on the Mpow.
2. Capacitor chargers for approximatly 2-3 seconds until a threshold of between 0.6-2.5V is reached. The exact turn ON voltage depends on the transistor
3. Button press is simulated as being lifted. Mpow should be connected to phone now. 


R1 and C1 create a classic low-pass filter with a charging rate equivalent to the reistance multipled by the capacitance. We want to carefully tune these values to turn ON transistor Q1 after 3 seconds. This should put the Mpow in its discovery mode so that our phone can connect to it automatically when the car is started. R2 needs to be chosen so that the microcontroller on the Mpow sees a logic 1 (3.7V) when Q1 is OFF. I expermented with a few different values here and arrived at 1k. 

I used LTspice to simulate the circuit before I built it. Q1 will start turning ON around 0.6V. The exact turn ON voltage varies between the silicon, so some expermientation may be required. I found a value of XXX to work with the simulation and in real-life. 


Open the case up 

Here is my example config. This will create a 4 window pane. Paste this inside of `~/.config/terminator/config`. You may need to create the file if it isn't there. Restart terminator to see the new setup. Be sure to replace `jbauer` with your username. 

![4-screen terminator](/assets/images/terminator.png)

