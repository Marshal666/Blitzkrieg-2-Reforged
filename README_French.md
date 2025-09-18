[English](README.md)        [Русский](README_Russian.md)        [中文](README_Chinese.md)        [हिन्दी](README_Hindi.md)        [Español](README_Spanish.md)        [Français](README_French.md)        [Deutsch](README_German.md)        [Português](README_Portuguese.md)        [日本語](README_Japanese.md)        [Bahasa Indonesia](README_Indonesian.md)

[![Blitzkrieg II Trailer](Blitzkrieg_2.png)](https://www.youtube.com/watch?v=Cw8rA2hvDGg)

Le jeu vidéo [Blitzkrieg 2] est le deuxième opus de la légendaire série de jeux de stratégie en temps réel, développé par [Nival Interactive] et sorti en 2005.

Le jeu est toujours disponible sur [Steam] et [GOG.com].

En 2025, le code source du jeu a été publié sous une [special license] qui interdit toute utilisation commerciale, mais est entièrement ouverte à la communauté du jeu, à l’éducation et à la recherche. Veuillez examiner attentivement les termes de la [license agreement] avant de l’utiliser.

## Pile technologique

- **Moteur de jeu** : moteur 3D personnalisé, principalement écrit en C++  
- **Langage de script** : Lua  
- **Animation** : Granny Animation (RAD Game Tools) ⚠️ *Licence commerciale - non incluse*
- **Vidéo** : Bink Video Technology ⚠️ *Licence commerciale - non incluse*
- **Audio** : système audio FMOD ⚠️ *Licence commerciale - non incluse*  

## Contenu du dépôt

- `Complete` — données et ressources du jeu  
- `Design` — documents de conception et ressources artistiques  
- `Soft` — code source et outils de développement  
- `Sound` — ressources sonores du jeu  
- `Tools` — outils de développement et de compilation  
- `Localizations` — fichiers de localisation
- `Versions` — différentes configurations de compilation et environnements de test  
- `Versions/Temporary/Engine/Sources` — code source complet du moteur de jeu  

---

# Lancement du jeu

## Lancement de base  
1. Accédez au répertoire `Complete/bin/`  
2. Lancez l’exécutable du jeu (s’il est présent)  

---

# Éditeur de cartes et outils de développement

## Éditeur de cartes  
- **Emplacement** : `Complete/Editor/`  
- **Documentation** : `Design/Manuals/MapEditorManual/`  
- **Manuel** : `Design/Manuals/MapEditorManual/Final/`  
- **FAQ** : `Design/Manuals/MapEditorManual/FAQ/`  

## Outils de développement  
- **Plugins Maya** : `Tools/MayaScripts/`  
- **Convertisseurs de textures** : `Tools/TexConv.exe`, `Tools/DxTex.exe`  
- **Générateur de polices** : `Tools/FontGen.exe`  
- **Outils Granny** : `Tools/Granny/`  

---


# Compilation du projet

## Prérequis de compilation  
- Microsoft Visual Studio (2003)  
- DirectX SDK  
- Dépendances supplémentaires indiquées dans la documentation

---

## Informations sur les licences

Ce projet est publié sous une **licence spéciale non commerciale** de NIVAL INTERNATIONAL LTD.

### ✅ Ce qui est inclus et open source :
- **Code source du moteur de jeu** - Licence personnalisée de NIVAL INTERNATIONAL LTD (usage non commercial uniquement)
- **Bibliothèque de compression zlib** - Licence zlib (permissive, usage commercial autorisé)
- **Scripts, assets et données du jeu** - Licence personnalisée de NIVAL INTERNATIONAL LTD (usage non commercial uniquement)

### ⚠️ Outils supplémentaires non inclus dans le code source :
- **Système audio FMOD**
- **Technologie vidéo Bink**
- **Système d'animation Granny3D**
- **Composants UI Stingray Studio**
- **Base de données MySQL**
- **Compression de texture S3TC**

### 📋 Licences tierces :
- **zlib** (v1.1.3) - Copyright (C) 1995-1998 Jean-loup Gailly and Mark Adler - Licence zlib

Veuillez consulter l'[accord de licence](LICENSE.md) complet avant d'utiliser ce code.  


