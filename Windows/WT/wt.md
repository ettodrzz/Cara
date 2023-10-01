# [Windows Terminal](https://learn.microsoft.com/en-us/windows/terminal)

Es como un administrador de [interfaces de línea de comandos](https://en.wikipedia.org/wiki/Command-line_interface), en donde por ejemplo, se puede abrir Command Prompt y PowerShell en la misma ventana, pero en diferentes pestañas. Se caracteriza por tener un soporte más amplio de símbolos, ser personalizable, renderizar texto por GPU, entre otras funciones.

# Instalación

Se puede instalar desde la Microsoft Store.

[`↗ Windows Terminal`](https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701)

Otra opción de hacerlo es con [winget](https://github.com/ettodrzz/Cara/blob/main/Windows/Winget/winget.md).

```powershell
# Instala desde PowerShell o Command Prompt
winget install Microsoft.WindowsTerminal

# Comprueba la versión instalada
wt --version
```

# Configuración

La forma más cómoda para restaurar mi configuración es usando PowerShell, con el cmdlet [Invoke-WebRequest](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-webrequest?view=powershell-5.1).

```powershell
# Descarga la configuración
iwr -Uri https://raw.githubusercontent.com/ettodrzz/Cara/main/Windows/WT/settings.json -OutFile $Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json

# Descarga configuración extra
iwr -Uri https://raw.githubusercontent.com/ettodrzz/Cara/main/Windows/WT/state.json -OutFile $Env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\state.json
```

# Eliminación

```powershell
# Desinstala desde PowerShell o Command Prompt
winget uninstall Microsoft.WindowsTerminal
```