---
layout: single
title: Terminator Setup in Ubuntu
context: Ramblings
date: 2017-10-19 
categories: blog
comments: true
---

I have found that [terminator](https://gnometerminator.blogspot.com/p/introduction.html) is one of the best terminal programs available for managing multiple terminals. I was tired of switching between contexts until I stumbled upon terminator. It makes it easy to spawn multiple terminal instances within a single window by creating another tab or by splitting the existing terminal. 

Install:

```
sudo add-apt-repository ppa:gnome-terminator
sudo apt-get update
sudo apt-get install terminator
```

Here is my exmaple config. This will create a 4 window pane. Paste this inside of `~/.config/terminator/config`. You may need to create the file if it isn't there. Restart terminator to see the new setup. Be sure to replace `jbauer` with your username. 

```
[global_config]
  suppress_multiple_term_dialog = True
  inactive_color_offset = 0.99
[keybindings]
  paste = <Control>v
  copy = <Control>
[profiles]
  [[default]]
    background_image = None
    scrollback_infinite = True
[layouts]
  [[default]]
    [[[child0]]]
      fullscreen = False
      last_active_term = 87bdb8ee-fa88-4131-97c9-2209607d2fed
      last_active_window = True
      maximised = False
      order = 0
      parent = ""
      position = 525:100
      size = 1249, 733
      title = jbauer@ubuntu: ~
      type = Window
    [[[child1]]]
      order = 0
      parent = child0
      position = 594
      ratio = 0.477582065653
      type = HPaned
    [[[child2]]]
      order = 0
      parent = child1
      position = 366
      ratio = 0.50272851296
      type = VPaned
    [[[child5]]]
      order = 1
      parent = child1
      position = 366
      ratio = 0.50272851296
      type = VPaned
    [[[terminal3]]]
      directory = /home/jbauer/Desktop
      order = 0
      parent = child2
      profile = default
      type = Terminal
      uuid = d1af43fc-c268-4e1d-a53d-dd501827ac55
    [[[terminal4]]]
      order = 1
      parent = child2
      profile = default
      type = Terminal
      uuid = f25f1048-779f-4c96-a7c4-fd63554cb278
    [[[terminal6]]]
      order = 0
      parent = child5
      profile = default
      type = Terminal
      uuid = 87bdb8ee-fa88-4131-97c9-2209607d2fed
    [[[terminal7]]]
      directory = /home/jbauer/Desktop
      order = 1
      parent = child5
      profile = default
      type = Terminal
      uuid = f281f00c-958e-40d3-84d5-a87294fbb75f
  [[defaultold]]
    [[[child1]]]
      parent = window0
      profile = default
      type = Terminal
    [[[window0]]]
      parent = ""
      type = Window
  [[cool]]
    [[[child0]]]
      fullscreen = False
      last_active_term = 87bdb8ee-fa88-4131-97c9-2209607d2fed
      last_active_window = True
      maximised = False
      order = 0
      parent = ""
      position = 525:100
      size = 1249, 733
      title = jbauer@ubuntu: ~
      type = Window
    [[[child1]]]
      order = 0
      parent = child0
      position = 594
      ratio = 0.477582065653
      type = HPaned
    [[[child2]]]
      order = 0
      parent = child1
      position = 366
      ratio = 0.50272851296
      type = VPaned
    [[[child5]]]
      order = 1
      parent = child1
      position = 366
      ratio = 0.50272851296
      type = VPaned
    [[[terminal3]]]
      order = 0
      parent = child2
      profile = default
      type = Terminal
      uuid = d1af43fc-c268-4e1d-a53d-dd501827ac55
    [[[terminal4]]]
      order = 1
      parent = child2
      profile = default
      type = Terminal
      uuid = f25f1048-779f-4c96-a7c4-fd63554cb278
    [[[terminal6]]]
      order = 0
      parent = child5
      profile = default
      type = Terminal
      uuid = 87bdb8ee-fa88-4131-97c9-2209607d2fed
    [[[terminal7]]]
      order = 1
      parent = child5
      profile = default
      type = Terminal
      uuid = f281f00c-958e-40d3-84d5-a87294fbb75f
[plugins]
```
