# Git + Moar

### Índice

- Administración
    - [Requisito previo](#requisito-previo)
    - [Instalación](#instalación)
    - [Eliminación](#eliminación)
- Uso
    - [Configuración](#configuración)
    - [GitHub SSH](#github-ssh)

### Acerca de

[↗ Git](https://github.com/git-for-windows/git "Repositorio de Git") es un sistema de control de versiones, creado por Linus Torvalds (Sí, el ingeniero que también desarrolló el kernel de Linux). En palabras más simples, es como una máquina del tiempo para nuestro código o proyecto, por eso es tan importante. Aquí muestro como descargar MinGit, una versión liviana, sin programas extras como Git BASH y Git GUI, usable desde PowerShell.

[↗ Moar](https://github.com/walles/moar "Repositorio de Moar") es un paginador, sirve para leer textos largos en la terminal de una forma más cómoda (como el de `git log`). ¿Por qué no simplemente usar [↗ Less](https://github.com/jftuga/less-Windows "Repositorio de Less")?... Moar es más legible, por ejemplo, se le puede pasar el parámetro `--no-clear-on-exit` y no romperá los anteriores textos en la terminal.

Escribí un [↗ script de PowerShell para administrar Git y Moar](https://github.com/ettodrzz/Cara/blob/main/Windows/Git/git-mgr-es.ps1 "Código del script"). Su función es instalar, actualizar o eliminar estos programas (compatible sólo con Windows de 64 bits).

# Requisito previo

Si se va a ejecutar el script, antes de eso, la directiva de ejecución debe estar puesta en `RemoteSigned` o `Unrestricted`.

1. Revisar cuál es la directiva de ejecución actual:

```powershell
Get-ExecutionPolicy
```

2. Cambiar a `RemoteSigned` o `Unrestricted` si es necesario:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

↑ *Cambia la directiva de ejecución a `RemoteSigned` del usuario actual. También se puede usar el scope `Process` si se quiere hacer el cambio sólo en la sesión actual de PowerShell.*

# Instalación

El script guarda los archivos de programa de Git y Moar en `%LocalAppData%\Programs` y crea las rutas en la variable de entorno Path del usuario actual.

También se puede ocupar para actualizar. Si anteriormente se instalaron ambos programas de forma correcta con el mismo script, este buscará nuevas versiones.

Ejecutar el script:

```powershell
irm -Uri "https://raw.githubusercontent.com/ettodrzz/Cara/main/Windows/Git/git-mgr-es.ps1" -OutFile "$Env:Temp\git-mgr-es.ps1"; .$Env:Temp\git-mgr-es.ps1
```

↑ *Descarga el script en la carpeta de archivos temporales (%Temp%), después lo ejecuta.*

# Eliminación

Si anteriormente se instalaron ambos programas de forma correcta con el mismo script, esta es la forma más rápida de eliminar sus archivos de programa en `%LocalAppData%\Programs` y quitar sus rutas en la variable de entorno Path del usuario actual, tan sólo es agregarle el parámetro `-Eliminar` o `-E`.

Ejecutar el script:

```powershell
irm -Uri "https://raw.githubusercontent.com/ettodrzz/Cara/main/Windows/Git/git-mgr-es.ps1" -OutFile "$Env:Temp\git-mgr-es.ps1"; .$Env:Temp\git-mgr-es.ps1 -Eliminar
```

↑ *Descarga el script en la carpeta de archivos temporales (%Temp%), después lo ejecuta.*

# Configuración

### Editor y paginador

Como MinGit no incluye editor ni paginador, entonces se tienen que especificar para evitar los siguientes errores:

- `error: cannot spawn vi: No such file or directory`
- `error: unable to start editor 'vi'`
- `error: cannot spawn less: No such file or directory`

El script automáticamente descarga el archivo [↗ gitconfig](https://github.com/ettodrzz/Cara/blob/main/Windows/Git/gitconfig "Código del archivo"), remplazando el existente en `%LocalAppData%\Programas\Git\etc`. Esto pone a Notepad como el editor y Moar como el paginador.

### Identidad

Para empezar a manipular repositorios, antes es necesario establecer una identidad. Esta información es importante que sea similar a la de GitHub.

```powershell
git config --global user.name "John Doe"
```

```powershell
git config --global user.email johndoe@example.com
```

### Nombre de la rama inicial

Cuando se crea un nuevo repositorio, una buena practica es usar el nombre *main* para la rama principal, esto para cumplir con las [↗ directrices de la comunidad](https://sfconservancy.org/news/2020/jun/23/gitbranchname/ "¿Por qué Main?").

```powershell
git config --global init.defaultBranch main
```

# GitHub SSH

Es un método de autenticación seguro que permite conectarse a GitHub sin tener que introducir una contraseña cada vez.

1. Crear una nueva llave:

```powershell
ssh-keygen -t ed25519 -C johndoe@example.com
```

↑ *Genera dos llaves, una pública y otra privada.*

2. Copiar la llave pública en el Portapapeles de Windows:

```powershell
Get-Content $Home\.ssh\id_ed25519.pub | clip
```

3. Ir a la configuración [↗ Add new SSH Key](https://github.com/settings/ssh/new "Acceso directo a la configuración") de GitHub.
    - En `Title`, escribir algo que haga referencia a donde se usaría la llave, por ejemplo, *Escritorio Personal*.
    - En `Key`, pegar la llave.
    - Guardar cambios.

4. Comprobar la conexión:

```powershell
ssh -T git@github.com
```