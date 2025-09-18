[English](README.md)        [Русский](README_Russian.md)        [中文](README_Chinese.md)        [हिन्दी](README_Hindi.md)        [Español](README_Spanish.md)        [Français](README_French.md)        [Deutsch](README_German.md)        [Português](README_Portuguese.md)        [日本語](README_Japanese.md)        [Bahasa Indonesia](README_Indonesian.md)

[![Blitzkrieg II Trailer](Blitzkrieg_2.png)](https://www.youtube.com/watch?v=Cw8rA2hvDGg)

O jogo de computador [Blitzkrieg 2] é a segunda parte da lendária série de jogos de estratégia militar em tempo real, desenvolvido pela [Nival Interactive] e lançado em 2005.

O jogo ainda está disponível no [Steam] e no [GOG.com].

Em 2025, o código-fonte do jogo foi divulgado sob uma [special license] que proíbe o uso comercial, mas é totalmente aberto para a comunidade do jogo, fins educacionais e de pesquisa. Leia atentamente os termos do [license agreement] antes de utilizá-lo.

## Pilha tecnológica

- **Motor de jogo**: motor 3D próprio, escrito principalmente em C++  
- **Linguagem de scripts**: Lua  
- **Animação**: Granny Animation (RAD Game Tools) ⚠️ *Licença comercial - não incluída*
- **Vídeo**: Bink Video Technology ⚠️ *Licença comercial - não incluída*
- **Áudio**: sistema de som FMOD ⚠️ *Licença comercial - não incluída*  

## Conteúdo deste repositório

- `Complete` — dados e recursos do jogo  
- `Design` — documentos de design e recursos artísticos  
- `Soft` — código-fonte e ferramentas de desenvolvimento  
- `Sound` — recursos de áudio do jogo  
- `Tools` — ferramentas de desenvolvimento e build  
- `Localizations` — arquivos de localização
- `Versions` — diferentes configurações de build e ambientes de teste  
- `Versions/Temporary/Engine/Sources` — código-fonte completo do motor do jogo  

---

# Executando o jogo

## Execução básica  
1. Acesse o diretório `Complete/bin/`  
2. Execute o arquivo executável do jogo (se disponível)  

---

# Editor de mapas e ferramentas de desenvolvimento

## Editor de mapas  
- **Localização**: `Complete/Editor/`  
- **Documentação**: `Design/Manuals/MapEditorManual/`  
- **Manual**: `Design/Manuals/MapEditorManual/Final/`  
- **FAQ**: `Design/Manuals/MapEditorManual/FAQ/`  

## Ferramentas de desenvolvimento  
- **Plugins para Maya**: `Tools/MayaScripts/`  
- **Conversores de textura**: `Tools/TexConv.exe`, `Tools/DxTex.exe`  
- **Gerador de fontes**: `Tools/FontGen.exe`  
- **Ferramentas Granny**: `Tools/Granny/`  

---


# Construção do projeto

## Requisitos de compilação  
- Microsoft Visual Studio (2003)  
- DirectX SDK  
- Dependências adicionais especificadas na documentação

---

## Informações sobre licenças

Este projeto é lançado sob uma **licença especial não comercial** da NIVAL INTERNATIONAL LTD.

### ✅ O que está incluído e é open source:
- **Código-fonte do motor do jogo** - Licença personalizada da NIVAL INTERNATIONAL LTD (apenas uso não comercial)
- **Biblioteca de compressão zlib** - Licença zlib (permissiva, uso comercial permitido)
- **Scripts, assets e dados do jogo** - Licença personalizada da NIVAL INTERNATIONAL LTD (apenas uso não comercial)

### ⚠️ Ferramentas adicionais não incluídas no código-fonte:
- **FMOD Audio System**
- **Bink Video Technology**
- **Granny3D Animation System**
- **Stingray Studio UI Components**
- **MySQL Database**
- **S3TC Texture Compression**

### 📋 Licenças de terceiros:
- **zlib** (v1.1.3) - Copyright (C) 1995-1998 Jean-loup Gailly and Mark Adler - Licença zlib

Consulte o [acordo de licença](LICENSE.md) completo antes de usar este código.  

