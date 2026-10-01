# Guía de instalación — Windows y Mac

Instalación paso a paso de todo lo necesario para el curso. Es la misma guía que `docs/guia_instalacion.pdf`, en formato Markdown. Son unos **45 minutos**. Si puedes, hazla antes de la primera sesión; si no, en la primera sesión veremos cómo hacerlo y tendrás que tenerlo listo para la segunda.

Los pasos 1-8 son para **Windows**; si usas un **Mac**, ve a [Si usas un Mac](#si-usas-un-mac). Sigue el orden: cada paso da por hecho el anterior. Si un paso falla, no sigas adelante; busca el mensaje en la tabla [Si algo falla](#si-algo-falla).

## Antes de empezar

| Necesitas | Por qué |
|---|---|
| **Windows 10 u 11**, 4 GB de RAM y 3 GB libres en disco | Python, las librerías y Claude Code ocupan unos 2 GB. |
| **Poder instalar programas** en ese ordenador | En un **portátil de empresa** es posible que no puedas instalar software, o que la VPN o el proxy bloqueen las descargas. Pregunta antes a tu departamento de IT o usa un ordenador personal. |
| **Conexión a internet** estable | Se descargan unos 500 MB. |

### Qué herramientas usaremos

| Herramienta | Para qué |
|---|---|
| **Jupyter Notebook** (recomendado para los notebooks) | Abre los notebooks en el navegador con doble clic en `abrir_jupyter`. Se instala solo con las librerías del curso (paso 5) y ya usa el entorno del curso: no hay que elegir nada. |
| **Visual Studio Code** | El editor para archivos `.py`, terminal y Git en una sola ventana. Lo usaremos sobre todo a partir del Día 6. También abre notebooks. |
| **PyCharm** | Si ya lo usas y te sientes cómodo, puedes seguir con él. Las explicaciones del curso se harán con VS Code. |
| **Anaconda** | **No hace falta.** El curso usa el Python de python.org con un entorno virtual y versiones fijadas. Si ya lo tienes, puede convivir, pero no uses «Anaconda Prompt» para el curso. |

**Cómo abrir PowerShell**: pulsa la tecla Windows, escribe `PowerShell` y pulsa Intro. La línea empieza por `PS C:\Users\TuNombre>`. Cuando un paso diga «abre una terminal nueva», cierra la ventana y abre otra: algunos programas solo se reconocen en las terminales abiertas después de instalarlos.

**Si ya tienes algo instalado**: con Python 3.11 o anterior, instala 3.13 igualmente (pueden convivir; ver paso 5). Si ya tienes Git o VS Code, sáltate su paso y comprueba solo la verificación.

### Opción rápida: instalación automática

1. Descarga la carpeta del curso en Documentos desde https://github.com/arnauivern11/curso-python-cac-alumnos (paso 4: con `git clone` o como zip, que tendrás que extraer).
2. Dentro de la carpeta, haz **doble clic en `instalar_entorno.bat`**. Si Windows muestra «Windows protegió su PC», pulsa **Más información → Ejecutar de todas formas**.
3. El script instala lo que te falte (Python, Git, VS Code con sus extensiones, Claude Code y las librerías del curso) y termina con el checklist. Tarda entre 10 y 20 minutos. Si Windows te pide permiso para instalar algún programa, acepta.
4. Si todo sale **OK**, continúa en el **paso 6** y el **paso 8**. Si algún paso sale **FALLA**, hazlo a mano con esta guía. El registro completo queda en `instalacion.log`.

Puedes volver a ejecutarlo cuando quieras: lo que ya esté instalado no se reinstala. Para ver solo el checklist: `powershell -ExecutionPolicy Bypass -File .\instalar_entorno.ps1 -SoloComprobar`.

## 1. Python (≈ 10 min)

1. Entra en [python.org/downloads/windows](https://www.python.org/downloads/windows/) y descarga el **Windows installer (64-bit)** de **Python 3.13**. Las versiones de NumPy y SciPy fijadas en `requirements.txt` necesitan **Python 3.12 o superior**: no se instalan en 3.11.
2. Abre el instalador y, **antes de pulsar nada más, marca la casilla «Add python.exe to PATH»**, en la parte inferior de la primera pantalla.
3. Pulsa **Install Now**. Si al final aparece «Disable path length limit», púlsalo.
4. Abre una terminal nueva y comprueba:
   ```
   python --version
   ```
   Debe mostrar `Python 3.13.x` (o 3.12, 3.14).

> ⚠️ **Error típico**: `python` abre la Microsoft Store. Desactiva el alias en Configuración → Aplicaciones → Configuración avanzada de aplicaciones → Alias de ejecución de aplicaciones (*python.exe* y *python3.exe*) y abre una terminal nueva.

> ⚠️ **Error típico**: `'python' no se reconoce como un comando interno o externo`. No marcaste la casilla del PATH. Ejecuta de nuevo el instalador → **Modify** → siguiente → marca «Add Python to environment variables».

## 2. Git (≈ 5 min)

1. Descarga el instalador de 64 bits desde [git-scm.com/downloads/win](https://git-scm.com/downloads/win) y pulsa **Next** en todas las pantallas: las opciones por defecto son las adecuadas.
2. Abre una terminal nueva y configura tu identidad (una sola vez):
   ```
   git config --global user.name "Nombre Apellido"
   git config --global user.email "tu@correo.com"
   git --version
   ```

Consulta `docs/cheatsheet_git.md` para los comandos del día a día.

## 3. Visual Studio Code (≈ 5 min)

1. Descarga VS Code desde [code.visualstudio.com](https://code.visualstudio.com/). En el instalador, en «Tareas adicionales», marca **«Agregar a PATH»** y las dos opciones **«Abrir con Code»**.
2. En VS Code, abre Extensiones (`Ctrl+Mayús+X`) e instala **Python** y **Jupyter**, las dos de Microsoft.

## 4. El material del curso (≈ 5 min)

El material está en **https://github.com/arnauivern11/curso-python-cac-alumnos**. Descárgalo en tus **Documentos** de una de estas dos formas:

- **Con Git (recomendado)**: así podrás recibir las novedades y las soluciones con `git pull`. Se crea la carpeta `curso-python-cac-alumnos`.
  ```powershell
  cd $HOME\Documents
  git clone https://github.com/arnauivern11/curso-python-cac-alumnos.git
  ```
- **Como zip**: descarga [https://github.com/arnauivern11/curso-python-cac-alumnos/archive/refs/heads/main.zip](https://github.com/arnauivern11/curso-python-cac-alumnos/archive/refs/heads/main.zip) (o **Code → Download ZIP** en la página del repositorio), clic derecho → **Extraer todo** en Documentos. La carpeta se llama `curso-python-cac-alumnos-main`. No trabajes dentro del zip sin extraerlo.

Ábrela en VS Code con **Archivo → Abrir carpeta**. Si pregunta si confías en los autores de la carpeta, responde **Sí**.

## 5. Entorno virtual y librerías (≈ 10 min)

En VS Code, abre una terminal con **Terminal → Nueva terminal** (`Ctrl+ñ`), ya situada en la carpeta del curso:

```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install -r requirements.txt
python -c "import pandas, numpy, scipy, sklearn, matplotlib, seaborn, sqlmodel; print('Todo OK')"
```

- Si tu `python --version` era 3.11 o anterior, crea el entorno con `py -3.13 -m venv .venv`.
- Con el entorno activado verás `(.venv)` al principio de la línea. Actívalo **cada vez que abras una terminal nueva** para el curso.
- `pip install` tarda entre 3 y 10 minutos (incluye Jupyter Notebook); es normal que aparezcan muchas líneas.

> ⚠️ **Error típico**: `No se puede cargar el archivo ...\Activate.ps1 porque la ejecución de scripts está deshabilitada en este sistema`. Ejecuta una vez `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned`, confirma con `S` y vuelve a activar el entorno.

## 6. Abrir los notebooks (≈ 3 min)

**Con Jupyter Notebook (recomendado)**

1. En la carpeta del curso, haz **doble clic en `abrir_jupyter.bat`** (en Mac: `bash abrir_jupyter.sh` en Terminal).
2. Se abre una ventana negra y, en unos segundos, el navegador con las carpetas del curso. **Deja la ventana negra abierta** mientras trabajas.
3. Entra en `dia_01_entorno_e_ia`, abre `01_teoria_entorno_windows.ipynb` y ejecuta la primera celda con `Mayús+Intro`. Debe mostrar `[1]` y el resultado. No hace falta elegir kernel: Jupyter ya usa el entorno del curso.

Para cerrar Jupyter, guarda los notebooks y cierra la ventana negra (en Mac, `Ctrl+C` dos veces). Jupyter guarda solo cada dos minutos.

**Con VS Code (alternativa; la usaremos en el Día 6)**

1. **Archivo → Abrir carpeta** → la carpeta del curso, y abre el mismo notebook.
2. Arriba a la derecha: **Seleccionar kernel** → **Entornos de Python** → **.venv**, y ejecuta la primera celda.

> ⚠️ **Error típico**: en VS Code, `.venv` no aparece, o aparece y desaparece enseguida. Regístralo con nombre propio, en la terminal de VS Code y dentro de la carpeta del curso: `.venv\Scripts\python -m ipykernel install --user --name curso --display-name "Curso Python"`. Después: **Seleccionar otro kernel… → Jupyter Kernel… → «Curso Python»**. O, sencillamente, usa Jupyter Notebook.

## 7. Claude Code (≈ 5 min)

En PowerShell (sirve la terminal de VS Code) ejecuta el instalador oficial. No hacen falta permisos de administrador:

```powershell
irm https://claude.ai/install.ps1 | iex
```

Abre una **terminal nueva** y comprueba que responde con un número de versión:

```powershell
claude --version
```

No hace falta que inicies sesión todavía: veremos cómo usarlo en la primera sesión.

> ⚠️ **Error típico**: `'irm' no se reconoce`. Estás en CMD, no en PowerShell: la línea de PowerShell empieza por `PS`.

> ⚠️ **Error típico**: `claude` no se reconoce justo después de instalarlo. Cierra todas las terminales (y VS Code) y abre una nueva.

## 8. Preparar las sesiones (≈ 5 min)

- **Comprueba que sabes compartir pantalla** en la aplicación de videollamada. Si te pedimos que compartas, elige la ventana de VS Code.
- **Dos pantallas, si puedes**: la videollamada en una y VS Code en la otra. Con una sola, divide la pantalla con `Windows + ←` y `Windows + →`.
- **Letra de VS Code**: `Ctrl` + `+` para ampliarla y `Ctrl` + `-` para reducirla.
- **Auriculares con micrófono**, para evitar el eco.
- **Antes de cada sesión**: si trabajas con el repositorio de Git, en una terminal en la carpeta del curso guarda tu trabajo (`git add .` y `git commit -m "Mi trabajo"`) y ejecuta `git pull` para recibir las novedades y las soluciones del día anterior. Después, abre Jupyter con `abrir_jupyter`.
- **Cuando algo falle durante una sesión**: copia el mensaje de error completo **como texto** y pégalo en el chat. Es mucho más útil que una foto de la pantalla.

## Si usas un Mac

Necesitas **macOS 13 (Ventura) o posterior** (procesador Apple o Intel) y que tu usuario sea **administrador** del Mac.

**Opción rápida: instalación automática**

1. Descarga la carpeta del curso en **Documentos** desde https://github.com/arnauivern11/curso-python-cac-alumnos: con `cd ~/Documents` y `git clone https://github.com/arnauivern11/curso-python-cac-alumnos.git`, o como [zip](https://github.com/arnauivern11/curso-python-cac-alumnos/archive/refs/heads/main.zip), que se descomprime con doble clic.
2. Abre **Terminal** (`⌘ + Espacio`, escribe `Terminal`, Intro).
3. Escribe `bash ` (con un espacio al final), **arrastra `instalar_entorno.sh`** desde la carpeta del curso a la ventana de Terminal y pulsa Intro.
4. El script instala lo que falte: Homebrew, Python 3.13, Git, VS Code con sus extensiones, Claude Code y las librerías del curso (10-20 minutos). Te pedirá la contraseña del Mac (al escribirla no se ve nada, es normal). Si aparece una ventana para instalar las «herramientas de línea de comandos», acéptala y vuelve a ejecutar el script al terminar.
5. Al acabar, **cierra Terminal y abre una ventana nueva**. Para ver solo el checklist: `bash instalar_entorno.sh --solo-comprobar`.

**Diferencias con los pasos de Windows**

| En Windows | En Mac |
|---|---|
| PowerShell | Terminal |
| `python -m venv .venv` | `python3.13 -m venv .venv` |
| `.venv\Scripts\Activate.ps1` | `source .venv/bin/activate` |
| Doble clic en `abrir_jupyter.bat` | `bash abrir_jupyter.sh` en Terminal |
| `Ctrl` en los atajos de VS Code | `⌘` (por ejemplo, `⌘+⇧+X` para Extensiones); ejecutar una celda sigue siendo `⇧+Intro` |
| `irm https://claude.ai/install.ps1 \| iex` | `curl -fsSL https://claude.ai/install.sh \| bash` |

**Si algo falla en Mac**

| Lo que ves | Qué hacer |
|---|---|
| `zsh: command not found: claude` (o `brew`, `code`) | Cierra Terminal y abre una ventana nueva: la configuración está en `~/.zprofile`. |
| `.venv` aparece en «Seleccionar kernel» y desaparece enseguida | En Terminal, dentro de la carpeta del curso: `.venv/bin/python -m ipykernel install --user --name curso --display-name "Curso Python"`; después **Seleccionar otro kernel… → Jupyter Kernel… → «Curso Python»**. |
| `xcrun: error: invalid active developer path` | Ejecuta `xcode-select --install`, acepta y vuelve a ejecutar el script. |
| Homebrew dice que tu usuario no es administrador | Pide permisos, o instala a mano Python (python.org), VS Code (code.visualstudio.com) y Git (`xcode-select --install`). |
| Aviso de macOS anterior a 13 | Actualiza en Ajustes del Sistema → General → Actualización de software: sin macOS 13, Claude Code no funciona. |

## Checklist final

Con el entorno activado (`(.venv)` visible), cada comando debe responder sin error:

| Comando | Debe responder |
|---|---|
| `python --version` | `Python 3.12` o superior |
| `git --version` | `git version 2.…` |
| `claude --version` | Un número de versión |
| `jupyter --version` | Una lista de componentes con sus versiones |
| `python -c "import pandas, numpy, scipy, sklearn, matplotlib, seaborn, sqlmodel; print('Todo OK')"` | `Todo OK` |
| Doble clic en `abrir_jupyter.bat` y primera celda de `dia_01_entorno_e_ia/01_teoria_entorno_windows.ipynb` | Se abre el navegador y la celda muestra `[1]` y su resultado |

## Si algo falla

| Lo que ves | Qué hacer |
|---|---|
| `'python' no se reconoce como un comando` | Paso 1: modifica la instalación marcando el PATH y abre una terminal nueva. |
| `python` abre la Microsoft Store | Desactiva los alias de ejecución de *python.exe* (paso 1). |
| `la ejecución de scripts está deshabilitada en este sistema` | `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` (paso 5). |
| `No matching distribution found for numpy==2.5.3` (o scipy) | El entorno se creó con Python 3.11 o anterior. Borra `.venv` y créalo con `py -3.13 -m venv .venv`. |
| Errores de `SSL`, `proxy` o `timeout` en `pip install` o `git clone` | La red o la VPN de tu empresa bloquean la descarga. Desconecta la VPN, prueba otra red o consulta a IT. |
| `ModuleNotFoundError` en el notebook | En VS Code, el kernel no es `.venv` (paso 6). Lo más sencillo: abre el notebook con `abrir_jupyter`. |
| `.venv` aparece en «Seleccionar kernel» y desaparece enseguida | `.venv\Scripts\python -m ipykernel install --user --name curso --display-name "Curso Python"` (en Mac, `.venv/bin/python -m ipykernel install --user --name curso --display-name "Curso Python"`) y después **Seleccionar otro kernel… → Jupyter Kernel… → «Curso Python»**. |
| `git` o `claude` no se reconocen tras instalarlos | Cierra todas las terminales y VS Code, y vuelve a abrirlos. |
| `fatal: destination path ... already exists` | Ya habías descargado el curso: entra en esa carpeta con `cd`. |
| `ImportError: DLL load failed` … «Una directiva de Control de aplicaciones bloqueó este archivo» | **Smart App Control** de Windows 11 bloquea las librerías recién instaladas. Prueba primero a repetir el checklist al cabo de unos minutos (`-SoloComprobar`): a veces el bloqueo desaparece solo. Si sigue, en un equipo de empresa, consulta a IT. En uno personal, puedes desactivarlo en Seguridad de Windows → Control de aplicaciones y navegador → Smart App Control (en muchas versiones no se puede volver a activar sin reinstalar Windows), o usar otro ordenador. |

Si no consigues terminarlo, no pasa nada: en la primera sesión veremos la instalación paso a paso, y tendrás hasta la segunda para dejarlo listo. Apunta en qué paso te quedaste y copia el texto del error.
