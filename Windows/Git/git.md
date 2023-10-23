# [Git](https://gitforwindows.org/) + [Moar](https://github.com/walles/moar)

**Git** es quizá el [sistema de control de versiones](https://en.wikipedia.org/wiki/Distributed_version_control) más popular, creado por [Linus Torvalds](https://en.wikipedia.org/wiki/Linus_Torvalds) (Sí, el ingeniero que también desarrolló el kernel de Linux). En palabras más simples, es como una máquina del tiempo para nuestro código o proyectos. Por eso es tan importante.

**Moar** es un [paginador](https://en.wikipedia.org/wiki/Terminal_pager), que sirve para leer textos largos en la terminal de una forma más cómoda (como el de `git log`). ¿Por qué no simplemente usar [less](https://github.com/jftuga/less-Windows)? Bueno... Moar por defecto es más legible, por ejemplo, se le puede pasar el parámetro `--no-clear-on-exit` y no romperá los textos anteriores de la terminal.

<img src= "./git-1.gif" alt = "Demostración de Git y Moar." width = "50%">

El siguiente script de PowerShell funciona para instalar, actualizar o eliminar ambos programas de una forma más cómoda.