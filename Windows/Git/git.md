# Git + Moar

### Índice

- Administración
    - [Requisito previo](#requisito-previo)
    - [Instalación](#instalación)
    - [Actualización](#actualización)
    - [Eliminación](#eliminación)
- Uso
    - [Configuración](#configuración)
    - [GitHub SSH](#github-ssh)

### Acerca de

[↗ Git](https://github.com/git-for-windows/git "Repositorio de Git") es un sistema de control de versiones, creado por Linus Torvalds (Sí, el ingeniero que también desarrolló el kernel de Linux). En palabras más simples, es como una máquina del tiempo para nuestro código o proyecto, por eso es tan importante. Aquí muestro como descargar MinGit, es una versión liviana, sin programas extras como Git BASH y Git GUI, usable desde PowerShell.

[↗ Moar](https://github.com/walles/moar "Repositorio de Moar") es un paginador, sirve para leer textos largos en la terminal de una forma más cómoda (como el de `git log`). ¿Por qué no simplemente usar [↗ Less](https://github.com/jftuga/less-Windows "Repositorio de Less")?... Moar es más legible, por ejemplo, se le puede pasar el parámetro `--no-clear-on-exit` y no romperá los anteriores textos en la terminal.

Escribí un [↗ script de PowerShell para administrar Git y Moar](https://github.com/ettodrzz/Cara/blob/main/Windows/Git/git-es.ps1 "Código del script"). Su función es instalar, actualizar o eliminar estos programas (compatible sólo con Windows de 64 bits).

# Requisito previo

Si se va a ejecutar el script, antes de eso, la directiva de ejecución debe estar puesta en `RemoteSigned` o `Unrestricted`.

1. Revisar cuál es la directiva de ejecución actual:

```powershell
Get-ExecutionPolicy
```

2. Cambiar a `RemoteSigned` o `Unrestricted` si es necesario:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# Este comando cambia la directiva de ejecución a RemoteSigned en el usuario actual.
# También se puede usar el scope Process si se quiere hacer el cambio sólo en la sesión actual de PowerShell.
```

# Instalación

### Script

Esta es la forma más rápida de guardar los archivos ejecutables de Git y Moar en `%LocalAppData%\Programs` y crear sus rutas en la variable de entorno Path del usuario actual.

Ejecutar el script:

```powershell
irm -Uri "https://raw.githubusercontent.com/ettodrzz/Cara/main/Windows/Git/git-es.ps1" -OutFile "$Env:Temp\git-es.ps1"; .$Env:Temp\git-es.ps1
# Este comando descarga el script en la carpeta de archivos temporales, después lo ejecuta.
```

### Manual

Usar la interfaz gráfica es más tedioso. Es la alternativa si el script falla, se requiere instalar una anterior versión o guardar los archivos ejecutables en una diferente ruta.

1. Guardar los archivos de programa
    - Git
        1. En la página de la [↗ última versión](https://github.com/git-for-windows/git/releases/latest "Versión más reciente de Git"), guardar el archivo `MinGit-...-64-bit.zip`
        2. Hacer `clic-derecho` en el archivo descargado y seleccionar `Extract All...`
        3. Extraer los archivos en `C:\Users\UserName\AppData\Local\Programs\Git`
        4. Descargar el archivo [↗ gitconfig](https://github.com/ettodrzz/Cara/blob/main/Windows/Git/gitconfig "Código del archivo") y remplazar el archivo existente en `C:\Users\UserName\AppData\Local\Programs\Git\etc` [Más información...](#editor-y-paginador)
    - Moar
        1. En la página de la [↗ última versión](https://github.com/walles/moar/releases/latest "Versión más reciente de Moar"), guardar el archivo `moar-v...-windows-amd64.exe`
        2. Renombrar el archivo descargado como `moar.exe` y moverlo a `C:\Users\UserName\AppData\Local\Programs\Moar`
        4. (Opcional) Descargar la [↗ licencia](https://github.com/walles/moar/blob/master/LICENSE "Licencia de Moar") y moverla a `C:\Users\UserName\AppData\Local\Programs\Moar`
2. Crear las rutas en la variable de entorno Path
    1. Abrir Windows Run (presionando simultáneamente las teclas `Win` + `R`)
    2. Escribir `SystemPropertiesAdvanced` y presionar la tecla `Enter`
    3. Seleccionar `Environment Variables...`
    4. En `User variables for UserName`, hacer `doble-clic` en `Path`
    5. Crear las rutas `%LocalAppData%\Programs\Git\mingw64\bin` y `%LocalAppData%\Programs\Moar`
    6. Guardar los cambios
3. Reiniciar el shell

# Actualización

### Script

Si anteriormente se instalaron ambos programas de forma correcta con el mismo script, esta es la forma más rápida de actualizar los archivos ejecutables de Git y Moar en `%LocalAppData%\Programs`.

Ejecutar el script:

```powershell
irm -Uri "https://raw.githubusercontent.com/ettodrzz/Cara/main/Windows/Git/git-es.ps1" -OutFile "$Env:Temp\git-es.ps1"; .$Env:Temp\git-es.ps1
# Este comando descarga el script en la carpeta de archivos temporales, después lo ejecuta.
```

### Manual

Usar la interfaz gráfica es más tedioso. Es la alternativa si el script falla o se requiere cambiar a una anterior versión.

- Git
    1. En la página de la [↗ última versión](https://github.com/git-for-windows/git/releases/latest "Versión más reciente de Git"), guardar el archivo `MinGit-...-64-bit.zip`
    2. Hacer `clic-derecho` en el archivo descargado y seleccionar `Extract All...`
    3. Extraer los archivos (remplazando los archivos existentes) en `C:\Users\UserName\AppData\Local\Programs\Git`
    4. Descargar el archivo [↗ gitconfig](https://github.com/ettodrzz/Cara/blob/main/Windows/Git/gitconfig "Código del archivo") y remplazar el archivo existente en `C:\Users\UserName\AppData\Local\Programs\Git\etc` [Más información...](#editor-y-paginador)
- Moar
    1. En la página de la [↗ última versión](https://github.com/walles/moar/releases/latest "Versión más reciente de Moar"), guardar el archivo `moar-v...-windows-amd64.exe`
    2. Renombrar el archivo descargado como `moar.exe` y remplazar el archivo existente en `C:\Users\UserName\AppData\Local\Programs\Moar`

# Eliminación

### Script

Si anteriormente se instalaron ambos programas de forma correcta con el mismo script, esta es la forma más rápida de eliminar los archivos ejecutables de Git y Moar en `%LocalAppData%\Programs` y quitar sus rutas en la variable de entorno Path del usuario actual, tan sólo es agregarle el parámetro `-Remove` o `-R`.

Ejecutar el script:

```powershell
irm -Uri "https://raw.githubusercontent.com/ettodrzz/Cara/main/Windows/Git/git-es.ps1" -OutFile "$Env:Temp\git-es.ps1"; .$Env:Temp\git-es.ps1 -Remove
# Este comando descarga el script en la carpeta de archivos temporales, después lo ejecuta.
```

### Manual

Usar la interfaz gráfica es más tedioso. Es la alternativa si el script falla.

1. Eliminar las carpetas `C:\Users\UserName\AppData\Local\Programs\Git` y `C:\Users\UserName\AppData\Local\Programs\Moar`
2. Quitar las rutas en la variable de entorno Path
    1. Abrir Windows Run (presionando simultáneamente las teclas `Win` + `R`)
    2. Escribir `SystemPropertiesAdvanced` y presionar la tecla `Enter`
    3. Seleccionar `Environment Variables...`
    4. En `User variables for UserName`, hacer `doble-clic` en `Path`
    5. Eliminar las rutas `%LocalAppData%\Programs\Git\mingw64\bin` y `%LocalAppData%\Programs\Moar`
    6. Guardar los cambios
3. Reiniciar el shell

# Configuración

### Editor y paginador

Como MinGit no incluye editor ni paginador, entonces se tienen que especificar para evitar los siguientes errores:

```powershell
# error: cannot spawn vi: No such file or directory
# error: unable to start editor 'vi'
# error: cannot spawn less: No such file or directory
```

El script automáticamente descarga el archivo [↗ gitconfig](https://github.com/ettodrzz/Cara/blob/main/Windows/Git/gitconfig "Código del archivo"), remplazando el existente en `%LocalAppData%\Programas\Git\etc`. Esto pone a Notepad como el editor y Moar como el paginador.

### Identidad

Para empezar a manipular repositorios, antes es necesario establecer una identidad. Esta información es importante que sea similar a la de GitHub.

```powershell
git config --global user.name "John Doe"
# Esta configuración se guarda en C:\Users\UserName\.gitconfig
```

```powershell
git config --global user.email johndoe@example.com
# Esta configuración se guarda en C:\Users\UserName\.gitconfig
```

### Nombre de la rama inicial

Cuando se crea un nuevo repositorio, una buena practica es usar el nombre "main" para la rama principal, esto para cumplir con las [↗ directrices de la comunidad](https://sfconservancy.org/news/2020/jun/23/gitbranchname/ "¿Por qué Main?").

```powershell
git config --global init.defaultBranch main
# Esta configuración se guarda en C:\Users\UserName\.gitconfig
```

# GitHub SSH