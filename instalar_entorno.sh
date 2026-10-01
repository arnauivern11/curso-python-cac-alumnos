#!/bin/bash
#
# Instala y comprueba todo lo necesario para el curso de Python (macOS).
#
# Automatiza los pasos de docs/guia_instalacion.pdf, versión Mac:
#   1. Homebrew (el instalador de paquetes de macOS)
#   2. Python 3.13 (si no hay un Python 3.12 o superior)
#   3. Git
#   4. Visual Studio Code y sus extensiones Python y Jupyter
#   5. Claude Code
#   6. Entorno virtual .venv con las librerías de requirements.txt
#   7. Checklist final
# Lo que ya está instalado no se vuelve a instalar.
#
# Uso, desde la app Terminal:
#   bash instalar_entorno.sh                   # instala lo que falte y comprueba
#   bash instalar_entorno.sh --solo-comprobar  # solo el checklist
#
# Written for the bash 3.2 that ships with macOS: no associative arrays,
# no mapfile, no ${var,,}, and no `set -u` (empty arrays would trip it).

COURSE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VENV_PY="$COURSE_DIR/.venv/bin/python"
LOG_FILE="$COURSE_DIR/instalacion.log"
ZPROFILE="$HOME/.zprofile"
MIN_MACOS_MAJOR=13          # Claude Code requires macOS 13+
SOLO_COMPROBAR=0
PYTHON_EXE=""

RES_ITEM=()
RES_STATE=()
RES_DETAIL=()

case "${1:-}" in
    --solo-comprobar) SOLO_COMPROBAR=1 ;;
    "") ;;
    *) echo "Uso: bash instalar_entorno.sh [--solo-comprobar]"; exit 2 ;;
esac

# ---------------------------------------------------------------- helpers

if [ -t 1 ]; then
    C_STEP=$'\033[36m'; C_OK=$'\033[32m'; C_WARN=$'\033[33m'; C_END=$'\033[0m'
else
    C_STEP=""; C_OK=""; C_WARN=""; C_END=""
fi

step() { printf '\n%s==> %s%s\n' "$C_STEP" "$1" "$C_END"; }
ok()   { printf '    %sOK%s  %s\n' "$C_OK" "$C_END" "$1"; }
warn() { printf '    %s!!%s  %s\n' "$C_WARN" "$C_END" "$1"; }

# Table row padded by characters, not bytes (printf %-22s miscounts "í").
row() {
    local pad=$((22 - ${#1}))
    [ "$pad" -lt 1 ] && pad=1
    printf '%s%*s %-6s %s\n' "$1" "$pad" "" "$2" "$3"
}

add_result() {  # item ok(0/1) detail
    RES_ITEM+=("$1")
    if [ "$2" = "0" ]; then RES_STATE+=("OK"); else RES_STATE+=("FALLA"); fi
    RES_DETAIL+=("$3")
}

# Append a line to ~/.zprofile once, so new Terminal windows find the tool.
persist_line() {
    touch "$ZPROFILE"
    grep -qxF "$1" "$ZPROFILE" 2>/dev/null || printf '\n%s\n' "$1" >> "$ZPROFILE"
}

# Apple Silicon and Intel locations; INSTALADOR_BREW_PATHS only exists for automated tests.
BREW_PATHS="${INSTALADOR_BREW_PATHS:-/opt/homebrew/bin/brew /usr/local/bin/brew}"

load_brew() {
    local b
    for b in $BREW_PATHS; do
        if [ -x "$b" ]; then
            eval "$("$b" shellenv)"
            BREW="$b"
            return 0
        fi
    done
    return 1
}

python_version() {  # prints "3.13" or nothing
    "$1" -c 'import sys; print("%d.%d" % sys.version_info[:2])' 2>/dev/null
}

version_ge() {  # version_ge 3.13 3.12 -> true
    local a_major a_minor b_major b_minor
    a_major="${1%%.*}"; a_minor="${1#*.}"; a_minor="${a_minor%%.*}"
    b_major="${2%%.*}"; b_minor="${2#*.}"; b_minor="${b_minor%%.*}"
    [ "$a_major" -gt "$b_major" ] || { [ "$a_major" -eq "$b_major" ] && [ "$a_minor" -ge "$b_minor" ]; }
}

find_python() {  # prints the path of a Python >= 3.12
    local c v prefix=""
    [ -n "${BREW:-}" ] && prefix="$("$BREW" --prefix 2>/dev/null)"
    for c in python3.13 python3.12 python3.14 \
             "$prefix/bin/python3.13" "$prefix/bin/python3.12" \
             /Library/Frameworks/Python.framework/Versions/3.13/bin/python3.13 \
             /Library/Frameworks/Python.framework/Versions/3.12/bin/python3.12 \
             python3; do
        if command -v "$c" >/dev/null 2>&1; then
            c="$(command -v "$c")"
        elif [ ! -x "$c" ]; then
            continue
        fi
        v="$(python_version "$c")"
        if [ -n "$v" ] && version_ge "$v" "3.12"; then
            echo "$c"
            return 0
        fi
    done
    return 1
}

git_works() {
    # /usr/bin/git exists on every Mac, but without the Command Line Tools it only
    # opens an install dialog, so check that it really runs.
    git --version >/dev/null 2>&1
}

find_code() {
    local p
    if command -v code >/dev/null 2>&1; then command -v code; return 0; fi
    for p in "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" \
             "$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"; do
        if [ -x "$p" ]; then echo "$p"; return 0; fi
    done
    return 1
}

find_claude() {
    if command -v claude >/dev/null 2>&1; then command -v claude; return 0; fi
    if [ -x "$HOME/.local/bin/claude" ]; then echo "$HOME/.local/bin/claude"; return 0; fi
    return 1
}

# ---------------------------------------------------------------- install steps

install_brew() {
    step "1/6  Homebrew"
    if load_brew; then
        ok "Homebrew en $BREW"
        return 0
    fi
    echo "    Se va a instalar Homebrew. Te pedirá la contraseña de tu Mac"
    echo "    (al escribirla no verás nada en pantalla: es normal) y que pulses Intro."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if load_brew; then
        persist_line "eval \"\$($BREW shellenv)\""
        ok "Homebrew instalado en $BREW"
    else
        warn "No se ha podido instalar Homebrew (¿tu usuario es administrador del Mac?)."
        warn "Sigue la guía de instalación para instalar cada programa a mano."
    fi
}

install_python() {
    step "2/6  Python 3.12 o superior"
    PYTHON_EXE="$(find_python)"
    if [ -z "$PYTHON_EXE" ] && [ -n "${BREW:-}" ]; then
        echo "    Instalando Python 3.13 con Homebrew..."
        "$BREW" install python@3.13
        PYTHON_EXE="$(find_python)"
    fi
    if [ -n "$PYTHON_EXE" ]; then
        ok "Python $(python_version "$PYTHON_EXE") en $PYTHON_EXE"
    else
        warn "No se ha podido instalar Python. Descárgalo de python.org (versión 3.13, macOS) y vuelve a ejecutar este script."
    fi
}

install_git() {
    step "3/6  Git"
    if ! git_works && [ -n "${BREW:-}" ]; then
        echo "    Instalando Git con Homebrew..."
        "$BREW" install git
    fi
    if ! git_works; then
        warn "Git no está disponible. Se abrirá la instalación de las herramientas de línea de comandos de Apple:"
        warn "acéptala, espera a que termine y vuelve a ejecutar este script."
        xcode-select --install >/dev/null 2>&1
        return 1
    fi
    ok "$(git --version)"
    if [ -z "$(git config --global user.name)" ]; then
        echo "    Git necesita tu nombre y tu correo para firmar tus cambios (no se envían a ningún sitio)."
        local name email
        read -r -p "    Nombre y apellido (Intro para saltar): " name
        [ -n "$name" ] && git config --global user.name "$name"
        read -r -p "    Correo electrónico (Intro para saltar): " email
        [ -n "$email" ] && git config --global user.email "$email"
    fi
}

install_vscode() {
    step "4/6  Visual Studio Code y extensiones"
    local code
    code="$(find_code)"
    if [ -z "$code" ] && [ -n "${BREW:-}" ]; then
        echo "    Instalando Visual Studio Code con Homebrew..."
        "$BREW" install --cask visual-studio-code
        code="$(find_code)"
    fi
    if [ -z "$code" ]; then
        warn "No se ha podido instalar VS Code. Descárgalo de code.visualstudio.com."
        return 1
    fi
    ok "VS Code en $code"
    local ext
    for ext in ms-python.python ms-toolsai.jupyter; do
        if "$code" --install-extension "$ext" --force >/dev/null 2>&1; then
            ok "Extensión $ext"
        else
            warn "No se ha podido instalar la extensión $ext: instálala desde VS Code."
        fi
    done
}

install_claude() {
    step "5/6  Claude Code"
    if [ -z "$(find_claude)" ]; then
        # Download first and check it is a shell script: company proxies, VPNs or blocked
        # networks sometimes return an HTML page, and piping that into bash gives
        # "syntax error near unexpected token '<'".
        echo "    Descargando el instalador oficial (claude.ai/install.sh)..."
        local tmp
        tmp="$(mktemp "${TMPDIR:-/tmp}/claude-install.XXXXXX")"
        if ! curl -fsSL https://claude.ai/install.sh -o "$tmp"; then
            warn "No se ha podido descargar el instalador de Claude Code (¿sin conexión o red bloqueada?)."
        elif head -n 1 "$tmp" | grep -q '^#!' && bash -n "$tmp" 2>/dev/null; then
            bash "$tmp"
        else
            warn "No se ejecuta el instalador de Claude Code: la red ha devuelto una página web en lugar del instalador."
            warn "Suele pasar con la VPN o el proxy de una empresa."
        fi
        rm -f "$tmp"
        if [ -z "$(find_claude)" ] && [ -n "${BREW:-}" ]; then
            echo "    Probando la otra vía oficial, Homebrew (claude-code)..."
            "$BREW" install --cask claude-code
        fi
    fi
    # The native installer puts claude in ~/.local/bin, which is not on PATH by default.
    case ":$PATH:" in
        *":$HOME/.local/bin:"*) ;;
        *) export PATH="$HOME/.local/bin:$PATH"
           # shellcheck disable=SC2016  # $HOME must stay literal inside ~/.zprofile
           persist_line 'export PATH="$HOME/.local/bin:$PATH"' ;;
    esac
    local claude
    claude="$(find_claude)"
    if [ -n "$claude" ]; then
        ok "Claude Code $("$claude" --version 2>/dev/null)"
    else
        warn "No se ha podido instalar Claude Code. No hace falta para empezar: lo veremos en las sesiones."
        warn "Si usas un ordenador o una red de empresa, prueba más tarde desde otra red."
    fi
}

install_venv() {
    step "6/6  Entorno virtual .venv y librerías del curso"
    if [ ! -f "$COURSE_DIR/requirements.txt" ]; then
        warn "No encuentro requirements.txt: este script debe estar en la carpeta del curso."
        return 1
    fi
    if [ -x "$VENV_PY" ]; then
        local v
        v="$(python_version "$VENV_PY")"
        if [ -z "$v" ] || ! version_ge "$v" "3.12"; then
            warn "El .venv existente usa Python ${v:-desconocido}; se vuelve a crear con Python 3.12 o superior."
            rm -rf "$COURSE_DIR/.venv"
        fi
    fi
    if [ ! -x "$VENV_PY" ]; then
        if [ -z "$PYTHON_EXE" ]; then warn "Sin Python no se puede crear el entorno."; return 1; fi
        "$PYTHON_EXE" -m venv "$COURSE_DIR/.venv" || { warn "No se ha podido crear .venv."; return 1; }
    fi
    echo "    Instalando librerías (entre 3 y 10 minutos)..."
    "$VENV_PY" -m pip install --upgrade pip --quiet
    if "$VENV_PY" -m pip install -r "$COURSE_DIR/requirements.txt"; then
        ok "Librerías instaladas"
    else
        warn "pip install ha fallado: revisa las últimas líneas de arriba."
    fi
}

# ---------------------------------------------------------------- checklist

checklist() {
    step "Checklist final"
    load_brew >/dev/null 2>&1
    case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) export PATH="$HOME/.local/bin:$PATH" ;; esac

    local py code claude out i
    py="$(find_python)"
    if [ -n "$py" ]; then add_result "Python >= 3.12" 0 "Python $(python_version "$py")"
    else add_result "Python >= 3.12" 1 "no encontrado"; fi

    if git_works; then add_result "Git" 0 "$(git --version)"
    else add_result "Git" 1 "no disponible"; fi

    code="$(find_code)"
    if [ -n "$code" ]; then add_result "VS Code" 0 "instalado"
    else add_result "VS Code" 1 "no encontrado"; fi

    claude="$(find_claude)"
    if [ -n "$claude" ]; then add_result "Claude Code" 0 "$("$claude" --version 2>/dev/null)"
    else add_result "Claude Code" 1 "no encontrado"; fi

    if [ -x "$VENV_PY" ]; then
        add_result "Entorno .venv" 0 "Python $(python_version "$VENV_PY")"
        out="$("$VENV_PY" -c "import pandas, numpy, scipy, sklearn, matplotlib, seaborn, sqlmodel, notebook; print('Todo OK')" 2>&1 | tail -n 1)"
        if [ "$out" = "Todo OK" ]; then add_result "Librerías del curso" 0 "$out"
        else add_result "Librerías del curso" 1 "$out"; fi
    else
        add_result "Entorno .venv" 1 "no existe"
        add_result "Librerías del curso" 1 "falta el entorno .venv"
    fi

    echo ""
    row "Paso" "Estado" "Detalle"
    row "----" "------" "-------"
    local failed=0
    for ((i = 0; i < ${#RES_ITEM[@]}; i++)); do
        row "${RES_ITEM[$i]}" "${RES_STATE[$i]}" "${RES_DETAIL[$i]}"
        [ "${RES_STATE[$i]}" = "FALLA" ] && failed=$((failed + 1))
    done
    echo ""
    if [ "$failed" -eq 0 ]; then
        printf '%sTodo listo. Para empezar: bash abrir_jupyter.sh (paso 6 de la guía).%s\n' "$C_OK" "$C_END"
        echo "Cierra esta ventana de Terminal y abre una nueva para que los cambios de PATH tengan efecto."
    else
        printf '%sHay pasos pendientes. Busca cada uno en la guía de instalación.%s\n' "$C_WARN" "$C_END"
        echo "El registro completo está en: $LOG_FILE"
    fi
    [ "$failed" -eq 0 ]  # exit status of the script: 0 only if everything is OK
}

# ---------------------------------------------------------------- main

main() {
    echo "Instalación del entorno del curso de Python (macOS)"
    echo "Carpeta del curso: $COURSE_DIR"

    if [ "$(uname -s)" != "Darwin" ]; then
        echo "Este script es para macOS. En Windows, usa instalar_entorno.bat."
        exit 1
    fi
    local macos major
    macos="$(sw_vers -productVersion 2>/dev/null)"
    major="${macos%%.*}"
    echo "macOS $macos ($(uname -m))"
    if [ -n "$major" ] && [ "$major" -lt "$MIN_MACOS_MAJOR" ]; then
        warn "El curso necesita macOS $MIN_MACOS_MAJOR (Ventura) o posterior; con macOS $macos Claude Code no funciona."
        warn "Actualiza macOS desde Ajustes del Sistema → General → Actualización de software."
    fi

    if [ "$SOLO_COMPROBAR" -eq 0 ]; then
        # Each step reports its own failure; the script always moves on to the next one.
        install_brew
        install_python
        install_git
        install_vscode
        install_claude
        install_venv
    fi
    checklist
}

main 2>&1 | tee "$LOG_FILE"
exit "${PIPESTATUS[0]}"
