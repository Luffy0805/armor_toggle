# Minetest Mod: Armor Toggle

By Luffy0805  
Version: 1.0.2  
License: MIT

---
---

## Installation

1. Place the mod folder into the `mods/` directory  
2. Enable the mod in your chosen world  
3. The `3d_armor` mod is required

---

## Description

This mod allows players to **hide or show their 3D armor** at any time in-game.  
Ideal for roleplay servers, screenshots, or personal preference.  
The visibility state is **remembered between sessions**.

**Visual and sound effects** are triggered each time the state changes.

---

## Features

* Hide/show armor using simple chat commands  
* Short command `/av` for quick toggling  
* Particles and sounds when switching visibility  
* The state is automatically restored on login  
* Auto re-apply if the skin or armor changes  
* Compatible with `3d_armor` and similar visual mods

---

## Commands

```bash
/armor_view <on|off|status>
---


* `/armor_view on → Show the armor
* `/armor_view off → Hide the armor
* `/armor_view or /armor_view status → Show current state

```bash
/av
```

*Quickly toggle between visible/invisible

```

## Sounds & Particles
A sound is played: smooth_swish.ogg

Particles appear around the player when toggling

Customizable particle textures: smoke.png (you can use any texture you like)

Customization available (around line 20):

Size

Glow intensity

Texture

Speed and spread

## Recommended Structure

```
mods/
└── armor_toggle/
    ├── mod.conf
    ├── init.lua
    ├── README-fr.txt
    ├── README.md
    ├── sounds/
    │   └── smooth_swish.ogg
    └── textures/
        ├── blank.png
        └── smoke.png
---

---

Notes
All sounds must be in .ogg format, preferably mono (not stereo)
Volume can be adjusted via gain in the code
---

License
Code: MIT
Textures/Sounds: MIT
