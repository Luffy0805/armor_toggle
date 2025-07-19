# Minetest Mod: Armor Toggle

By Luffy0805
Version: 1.0.2
License: MIT

---

---

## Installation

1. Place the mod folder into the `mods/` directory
2. Enable the mod in your desired world
3. The `3d_armor` mod is required

---

## Description

This mod allows players to **hide or show their 3D armor** at any time in-game.
Perfect for roleplay servers, screenshots, or personal preference.
The visibility state is **remembered between logins**.

**Visual and sound effects** are played each time the state changes.

---

## Features

* Hide/show armor using simple chat commands
* Short command `/av` for quick access
* Particles and sounds on state change
* State is automatically restored on login
* Auto re-application if skin or armor is modified
* Compatible with `3d_armor` and similar visual mods

---

## Commands

```bash
/armor_view <on|off|status>
```

* `/armor_view on` → Show armor
* `/armor_view off` → Hide armor
* `/armor_view` or `/armor_view status` → Show current state

```bash
/av
```

* Quickly toggle between visible/invisible

---

## Sounds & Particles

* A sound is played: `smooth_swish.ogg`
* Particles appear around the player when toggling
* Customizable particle textures: `smoke.png` (you can add any texture you want)
* Customization options (line 20):

  * Size
  * Glow intensity
  * Texture
  * Speed and spread

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
```

---

## Notes

* All sounds must be in `.ogg` format, preferably mono and not stereo
* Volume can be adjusted via `gain` in the code

---

## License

Code: MIT
Textures/Sounds: MIT
