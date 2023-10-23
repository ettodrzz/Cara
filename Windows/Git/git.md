# [Git](https://gitforwindows.org/) + [Moar](https://github.com/walles/moar)

**Git** es quizá el [sistema de control de versiones](https://en.wikipedia.org/wiki/Distributed_version_control) más popular, creado por [Linus Torvalds](https://en.wikipedia.org/wiki/Linus_Torvalds) (Sí, el ingeniero que también desarrolló el kernel de Linux). En palabras más simples, es como una máquina del tiempo para nuestro código o proyectos. Por eso es tan importante.

**Moar** es un [paginador](https://en.wikipedia.org/wiki/Terminal_pager), que sirve para leer textos largos en la terminal de una forma más cómoda (como el de `git log`). ¿Por qué no simplemente usar [less](https://github.com/jftuga/less-Windows)? Bueno... Moar por defecto es más legible, por ejemplo, se le puede pasar el parámetro `--no-clear-on-exit` y no romperá los textos anteriores de la terminal.

<img src= "./git-1.gif" alt = "Demostración de Git y Moar." width = "50%">

# Índice

- Administración
    - [Instalación](#instalación)
    - [Actualización](#actualización)
    - [Eliminación](#eliminación)
- Uso
    - Configuración
    - GitHub SSH

# Instalación

### Script

La forma más rápida de instalar ambos programas es con el siguiente comando.

```powershell
irm -Uri "https://raw.githubusercontent.com/ettodrzz/Cara/main/Windows/Git/git.ps1" -OutFile "$Env:Temp\git.ps1"; .$Env:Temp\git.ps1
```

*Guardará los archivos ejecutables en `%LocalAppData$\Programs` y le creará sus rutas en la [variable de entorno](https://en.wikipedia.org/wiki/Environment_variable#Assignment:_DOS,_OS/2_and_Windows) Path del usuario actual*.

# Actualización

### Script

Si anteriormente se instalaron ambos programas de forma correcta con el mismo script, ejecutarlo otra vez hará que busque y descargue nuevas versiones de Git y Moar.

```powershell
irm -Uri "https://raw.githubusercontent.com/ettodrzz/Cara/main/Windows/Git/git.ps1" -OutFile "$Env:Temp\git.ps1"; .$Env:Temp\git.ps1
```

# Eliminación

### Script

Si anteriormente se instalaron ambos programas de forma correcta con el mismo script. También se puede usar para eliminar estos programas, tan sólo es agregarle el parámetro `-Remove` o `-R`.

```powershell
irm -Uri "https://raw.githubusercontent.com/ettodrzz/Cara/main/Windows/Git/git.ps1" -OutFile "$Env:Temp\git.ps1"; .$Env:Temp\git.ps1 -Remove
```

*Eliminará los archivos ejecutables que están en `%LocalAppData$\Programs` y las rutas que están en la variable de entorno Path del usuario actual*.