[English](README.md)        [Русский](README_Russian.md)        [中文](README_Chinese.md)        [हिन्दी](README_Hindi.md)        [Español](README_Spanish.md)        [Français](README_French.md)        [Deutsch](README_German.md)        [Português](README_Portuguese.md)        [日本語](README_Japanese.md)        [Bahasa Indonesia](README_Indonesian.md)

[![Blitzkrieg II Trailer](Blitzkrieg_2.png)](https://www.youtube.com/watch?v=Cw8rA2hvDGg)

El videojuego [Blitzkrieg 2] es la segunda entrega de la legendaria serie de juegos de estrategia en tiempo real, desarrollado por [Nival Interactive] y lanzado en 2005.

El juego sigue disponible en [Steam] y [GOG.com].

En 2025, el código fuente del juego fue publicado bajo una [special license] que prohíbe el uso comercial pero está completamente abierta para la comunidad, la educación y la investigación.  
Por favor, revise detenidamente los términos del [license agreement] antes de usarlo.

## Stack tecnológico

- **Motor de juego**: motor 3D propio, escrito principalmente en C++  
- **Lenguaje de scripts**: Lua  
- **Animación**: Granny Animation (RAD Game Tools) ⚠️ *Licencia comercial - no incluida*
- **Vídeo**: Bink Video Technology ⚠️ *Licencia comercial - no incluida*
- **Audio**: FMOD sound system ⚠️ *Licencia comercial - no incluida*  

## Qué contiene este repositorio

- `Complete` — datos y recursos del juego  
- `Design` — documentos de diseño y recursos artísticos  
- `Soft` — código fuente y herramientas de desarrollo  
- `Sound` — recursos de sonido del juego  
- `Tools` — herramientas de desarrollo y compilación  
- `Localizations` — archivos de localización
- `Versions` — diferentes configuraciones de compilación y entornos de prueba  
- `Versions/Temporary/Engine/Sources` — código fuente completo del motor del juego  

---

# Ejecución del juego

## Lanzamiento básico  
1. Vaya al directorio `Complete/bin/`  
2. Ejecute el archivo ejecutable del juego (si está disponible)  

---

# Editor de mapas e herramientas de desarrollo

## Editor de mapas  
- Ubicación: `Complete/Editor/`  
- Documentación: `Design/Manuals/MapEditorManual/`  
- Manual: `Design/Manuals/MapEditorManual/Final/`  
- FAQ: `Design/Manuals/MapEditorManual/FAQ/`  

## Herramientas de desarrollo  
- Plugins de Maya: `Tools/MayaScripts/`  
- Convertidores de texturas: `Tools/TexConv.exe`, `Tools/DxTex.exe`  
- Generador de fuentes: `Tools/FontGen.exe`  
- Herramientas de Granny: `Tools/Granny/`  

---


# Compilación del proyecto

## Requisitos de compilación  
- Microsoft Visual Studio (2003)  
- DirectX SDK  
- Dependencias adicionales indicadas en la documentación

---

## Información sobre licencias

Este proyecto se publica bajo una **licencia especial no comercial** de NIVAL INTERNATIONAL LTD.

### ✅ Lo que está incluido y es de código abierto:
- **Código fuente del motor del juego** - Licencia personalizada de NIVAL INTERNATIONAL LTD (solo uso no comercial)
- **Biblioteca de compresión zlib** - Licencia zlib (permisiva, uso comercial permitido)
- **Scripts, assets y datos del juego** - Licencia personalizada de NIVAL INTERNATIONAL LTD (solo uso no comercial)

### ⚠️ Herramientas adicionales no incluidas en el código fuente:
- **FMOD Audio System**
- **Bink Video Technology**
- **Granny3D Animation System**
- **Stingray Studio UI Components**
- **MySQL Database**
- **S3TC Texture Compression**

### 📋 Licencias de terceros:
- **zlib** (v1.1.3) - Copyright (C) 1995-1998 Jean-loup Gailly and Mark Adler - Licencia zlib

Consulte el [acuerdo de licencia](LICENSE.md) completo antes de usar este código.  

