# [Git](https://gitforwindows.org/) + [Moar](https://github.com/walles/moar)

**Git** es quizá el [sistema de control de versiones](https://en.wikipedia.org/wiki/Distributed_version_control) más popular, creado por [Linus Torvalds](https://en.wikipedia.org/wiki/Linus_Torvalds) (Sí, el ingeniero que también desarrolló el kernel de Linux). En palabras más simples, es como una máquina del tiempo para nuestro código o proyectos. Por eso es tan importante.

**Moar** es un [paginador](https://en.wikipedia.org/wiki/Terminal_pager), que sirve para leer textos largos en la terminal de una forma más cómoda (como el de `git log`). ¿Por qué no simplemente usar [less](https://github.com/jftuga/less-Windows)? Bueno... Moar por defecto es más legible, por ejemplo, se le puede pasar el parámetro `--no-clear-on-exit` y no romperá los textos anteriores de la terminal.

<img src= "./git-1.gif" alt = "Demostración de Git y Moar." width = 75% max-width = 920px>

Este repositorio contiene un [script](https://github.com/ettodrzz/Cara/blob/main/Windows/Git/git.ps1) para administrar estos programas.

# Índice

- Administración
    - [Requisito previo](#requisito-previo)
    - [Instalación](#instalación)
    - [Actualización](#actualización)
    - [Eliminación](#eliminación)
- Uso
    - Configuración
    - GitHub SSH

# Requisito previo

Si se va a ejecutar el script, antes de eso, la [directiva de ejecución](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies?view=powershell-5.1) debe estar puesta en `RemoteSigned` o `Unrestricted`.

Se puede revisar cuál es la directiva de ejecución actual con:

```powershell
Get-ExecutionPolicy
```

El comando a continuación cambia la directiva de ejecución a *RemoteSigned* en el usuario actual.

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Se puede usar el scope `Process` si se quiere hacer el cambio sólo en la sesión actual de PowerShell, la directiva de ejecución se eliminaría cuando se cierre el shell.

# Instalación

### [Script](https://github.com/ettodrzz/Cara/blob/main/Windows/Git/git.ps1)

La forma más rápida de instalar ambos programas es con el siguiente comando.

```powershell
irm -Uri "https://raw.githubusercontent.com/ettodrzz/Cara/main/Windows/Git/git.ps1" -OutFile "$Env:Temp\git.ps1"; .$Env:Temp\git.ps1
```

Guardará los archivos ejecutables en `%LocalAppData$\Programs` y le creará sus rutas en la [variable de entorno](https://en.wikipedia.org/wiki/Environment_variable#Assignment:_DOS,_OS/2_and_Windows) Path del usuario actual.

### Manual

Para instalar estos programas con la interfaz gráfica, hay que seguir los pasos:

- Guardar los archivos
    - Git
        1. Descargar la [última versión](https://github.com/git-for-windows/git/releases/latest) (MinGit-[...]-bit.zip)
        2. Hacer clic-derecho en el archivo descargado, y seleccionar `Extract All...`
        3. Extraer los archivos en *C:\Users\\[UserName]\AppData\Local\Programs\Git*
    - Moar
        1. Descargar la [última versión](https://github.com/walles/moar/releases/latest) (moar-v[...]-windows-amd64.exe)
        2. Renombrar el archivo descargado como *moar.exe*
        3. Mover este archivo a *C:\Users\\[UserName]\AppData\Local\Programs\Moar*
- Crear las rutas en la variable de entorno Path
    1. Abrir [Windows Run](https://es.wikipedia.org/wiki/Comando_Ejecutar) (presionando simultáneamente `Win` + `R`)
    2. Escribir *SystemPropertiesAdvanced*, y presionar `Enter`
    3. Seleccionar `Environment Variables...`
    4. En *User variables for [UserName]*, hacer doble-clic en *Path*
    5. Seleccionar `New`, y escribir *%LocalAppData%\Programs\Git\mingw64\bin*
    6. Seleccionar `New`, y escribir *%LocalAppData%\Programs\Moar*
    7. Guardar los cambios
- Reiniciar el shell para recargar la rutas en la variable de entorno Path

# Actualización

### [Script](https://github.com/ettodrzz/Cara/blob/main/Windows/Git/git.ps1)

Si anteriormente se instalaron ambos programas de forma correcta con el mismo script, al ejecutarlo otra vez, descargará nuevas versiones de Git y Moar.

```powershell
irm -Uri "https://raw.githubusercontent.com/ettodrzz/Cara/main/Windows/Git/git.ps1" -OutFile "$Env:Temp\git.ps1"; .$Env:Temp\git.ps1
```

### Manual

Para actualizar estos programas con la interfaz gráfica, hay que seguir los pasos:

- Git
    1. Descargar la [última versión](https://github.com/git-for-windows/git/releases/latest) (MinGit-[...]-bit.zip)
    2. Hacer clic-derecho en el archivo descargado, y seleccionar `Extract All...`
    3. Extraer los archivos en *C:\Users\\[UserName]\AppData\Local\Programs\Git*
- Moar
    1. Descargar la [última versión](https://github.com/walles/moar/releases/latest) (moar-v[...]-windows-amd64.exe)
    2. Renombrar el archivo descargado como *moar.exe*
    3. Mover este archivo a *C:\Users\\[UserName]\AppData\Local\Programs\Moar*

# Eliminación

### [Script](https://github.com/ettodrzz/Cara/blob/main/Windows/Git/git.ps1)

Si anteriormente se instalaron ambos programas de forma correcta con el mismo script. También se puede usar para eliminar estos programas, tan sólo es agregarle el parámetro `-Remove` o `-R`.

```powershell
irm -Uri "https://raw.githubusercontent.com/ettodrzz/Cara/main/Windows/Git/git.ps1" -OutFile "$Env:Temp\git.ps1"; .$Env:Temp\git.ps1 -Remove
```

Eliminará los archivos ejecutables que están en `%LocalAppData$\Programs` y las rutas que están en la [variable de entorno](https://en.wikipedia.org/wiki/Environment_variable#Assignment:_DOS,_OS/2_and_Windows) Path del usuario actual.

### Manual

Para desinstalar estos programas con la interfaz gráfica, hay que seguir los pasos:

- Eliminar los archivos
    1. Eliminar las carpetas *C:\Users\\[UserName]\AppData\Local\Programs\Git* y *C:\Users\\[UserName]\AppData\Local\Programs\Moar*
- Quitar las rutas en la variable de entorno Path
    1. Abrir [Windows Run](https://es.wikipedia.org/wiki/Comando_Ejecutar) (presionando simultáneamente `Win` + `R`)
    2. Escribir *SystemPropertiesAdvanced*, y presionar `Enter`
    3. Seleccionar `Environment Variables...`
    4. En *User variables for [UserName]*, hacer doble-clic en *Path*
    5. Eliminar las rutas *%LocalAppData%\Programs\Git\mingw64\bin* y *%LocalAppData%\Programs\Moar*
    7. Guardar los cambios
- Reiniciar el shell para recargar la rutas en la variable de entorno Path