# Mod Minetest : Armor Toggle

Par Luffy0805
Version : 1.0.2
Licence : MIT

---
---

## Installation

1. Placer le dossier du mod dans le répertoire `mods/`
2. Activer le mod dans le monde souhaité
3. Le mod `3d_armor` est obligatoire

---

## Description

Ce mod permet aux joueurs de **masquer ou afficher leur armure 3D** à tout moment en jeu.
Idéal pour les serveurs roleplay, les captures d'écran, ou par préférence personnelle.
L'état de visibilité est **mémorisé entre les connexions**.

Des **effets visuels et sonores** sont joués à chaque changement d'état.

---

## Fonctionnalités

* Masquage/affichage de l'armure via commandes simples
* Commande courte `/av` pour un accès rapide
* Particules et sons lors du changement d'état
* L'état est restauré automatiquement à la connexion
* Reprise automatique si l'armure ou le skin est modifié
* Compatible avec `3d_armor` et les mods visuels similaires

---

## Commandes

```bash
/armor_view <on|off|status>
```

* `/armor_view on` → Afficher l'armure
* `/armor_view off` → Masquer l'armure
* `/armor_view` ou `/armor_view status` → Affiche l'état actuel

```bash
/av
```

* Bascule rapidement entre visible/invisible

---

## Sons & Particules

* Un son est joué : smooth_swish.ogg
* Des particules apparaissent autour du joueur lors du changement
* Textures de particules personnalisables : smoke.png (Mais vous pouvez ajouter la texture de votre choix)
* Personnalisation possible (l.20) :

  * Taille
  * Intensité lumineuse (glow)
  * Texture
  * Vitesse et dispersion


## Structure recommandée

```
mods/
└── armor_toggle/
    ├── mod.conf
    ├── init.lua
    ├── README-fr.txt
    ├── README.md
    ├── sounds/
    │   ├── smooth_swish.ogg
    └── textures/
        ├── blank.png
        └── smoke.png
```

---

## Remarques

* Tous les sons doivent être au format `.ogg`, de préférence en mono, pas en stéréo
* Le volume peut être modifié via `gain` dans le code
* 
---

## Licence

Code : MIT
Textures/Sons : MIT
