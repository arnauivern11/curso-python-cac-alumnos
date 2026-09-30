<#
.SYNOPSIS
    Instala y comprueba todo lo necesario para el curso de Python (Windows).

.DESCRIPTION
    Automatiza los pasos de docs/guia_instalacion.pdf:
      1. Python 3.13 (si no hay un Python 3.12 o superior)
      2. Git
      3. Visual Studio Code y sus extensiones Python y Jupyter
      4. Claude Code
      5. Entorno virtual .venv con las librerias de requirements.txt
      6. Checklist final
    Lo que ya esta instalado no se vuelve a instalar. Usa winget, el instalador
    de paquetes de Windows 10/11. Se ejecuta desde la carpeta del curso,
    normalmente con doble clic en instalar_entorno.bat.

.PARAMETER SoloComprobar
    No instala nada: solo ejecuta el checklist final.

.EXAMPLE
    powershell -ExecutionPolicy Bypass -File .\instalar_entorno.ps1
    powershell -ExecutionPolicy Bypass -File .\instalar_entorno.ps1 -SoloComprobar
#>
param(
    [switch]$SoloComprobar
)

$ErrorActionPreference = "Stop"
$CourseDir = $PSScriptRoot
$VenvPython = Join-Path $CourseDir ".venv\Scripts\python.exe"
$LogFile = Join-Path $CourseDir "instalacion.log"
$Results = [System.Collections.Generic.List[object]]::new()

# ---------------------------------------------------------------- helpers

function Write-Step([string]$Text) {
    Write-Host ""
    Write-Host "==> $Text" -ForegroundColor Cyan
}

function Write-Ok([string]$Text) { Write-Host "    OK  $Text" -ForegroundColor Green }
function Write-Warn([string]$Text) { Write-Host "    !!  $Text" -ForegroundColor Yellow }

function Add-Result([string]$Item, [bool]$Ok, [string]$Detail) {
    $Results.Add([pscustomobject]@{ Paso = $Item; Estado = $(if ($Ok) { "OK" } else { "FALLA" }); Detalle = $Detail })
}

function Update-SessionPath {
    # Reload PATH from the registry so tools installed a moment ago are found.
    $machine = [Environment]::GetEnvironmentVariable("Path", "Machine")
    $user = [Environment]::GetEnvironmentVariable("Path", "User")
    $env:Path = "$machine;$user"
}

function Test-Command([string]$Name) {
    $cmd = Get-Command $Name -ErrorAction SilentlyContinue
    if ($null -eq $cmd) { return $false }
    # The Microsoft Store "python" alias lives in WindowsApps and is not a real Python
    # (winget also lives there, and that one is real).
    if ($Name -like "python*" -and $cmd.Source -like "*\WindowsApps\*") { return $false }
    return $true
}

function Invoke-Winget([string]$Id, [string]$Label, [string[]]$Extra = @()) {
    if (-not (Test-Command "winget")) {
        Write-Warn "Falta $Label y no encuentro winget para instalarlo automáticamente."
        Write-Warn "Instala 'Instalador de aplicación' desde la Microsoft Store, o instala $Label a mano con la guía."
        return
    }
    Write-Host "    Instalando $Label con winget (puede tardar unos minutos)..."
    $wingetArgs = @("install", "--exact", "--id", $Id, "--silent",
                    "--accept-package-agreements", "--accept-source-agreements") + $Extra
    # Out-Host keeps winget's output off the pipeline so it never ends up in a return value.
    & winget @wingetArgs | Out-Host
    # winget returns non-zero for "already installed" too; the caller re-checks the tool instead.
    Update-SessionPath
}

function Get-PythonVersion([string]$Exe) {
    try {
        $out = & $Exe -c "import sys; print('%d.%d' % sys.version_info[:2])" 2>$null
        if ($LASTEXITCODE -eq 0 -and $out) { return [version]$out.Trim() }
    } catch { }
    return $null
}

function Find-Python {
    # Return the path of a Python >= 3.12, or $null.
    $candidates = [System.Collections.Generic.List[string]]::new()
    if (Test-Command "py") {
        foreach ($v in "3.13", "3.12", "3.14") {
            try {
                $exe = & py "-$v" -c "import sys; print(sys.executable)" 2>$null
                if ($LASTEXITCODE -eq 0 -and $exe) { $candidates.Add($exe.Trim()) }
            } catch { }
        }
    }
    if (Test-Command "python") { $candidates.Add((Get-Command python).Source) }
    foreach ($v in "313", "312", "314") {
        $candidates.Add((Join-Path $env:LOCALAPPDATA "Programs\Python\Python$v\python.exe"))
        $candidates.Add((Join-Path $env:ProgramFiles "Python$v\python.exe"))
    }
    foreach ($exe in $candidates) {
        if (-not (Test-Path $exe)) { continue }
        $ver = Get-PythonVersion $exe
        if ($ver -and $ver -ge [version]"3.12") { return $exe }
    }
    return $null
}

function Find-Code {
    if (Test-Command "code") { return (Get-Command code).Source }
    $paths = @(
        (Join-Path $env:LOCALAPPDATA "Programs\Microsoft VS Code\bin\code.cmd"),
        (Join-Path $env:ProgramFiles "Microsoft VS Code\bin\code.cmd")
    )
    foreach ($p in $paths) { if (Test-Path $p) { return $p } }
    return $null
}

function Find-Claude {
    if (Test-Command "claude") { return (Get-Command claude).Source }
    $p = Join-Path $env:USERPROFILE ".local\bin\claude.exe"
    if (Test-Path $p) { return $p }
    return $null
}

# ---------------------------------------------------------------- install steps

function Install-Python {
    Write-Step "1/5  Python 3.12 o superior"
    $py = Find-Python
    if (-not $py) {
        # Per-user install, added to PATH, with the py launcher.
        Invoke-Winget "Python.Python.3.13" "Python 3.13" @("--override", "/quiet InstallAllUsers=0 PrependPath=1 Include_launcher=1")
        $py = Find-Python
    }
    if ($py) { Write-Ok "Python $(Get-PythonVersion $py) en $py" }
    else { Write-Warn "No se ha podido instalar Python. Sigue el paso 1 de la guía." }
    return $py
}

function Install-Git {
    Write-Step "2/5  Git"
    if (-not (Test-Command "git")) {
        Invoke-Winget "Git.Git" "Git"
    }
    if (-not (Test-Command "git")) {
        Write-Warn "No se ha podido instalar Git. Sigue el paso 2 de la guía."
        return
    }
    Write-Ok (& git --version)
    $name = (& git config --global user.name) 2>$null
    if (-not $name) {
        Write-Host "    Git necesita tu nombre y tu correo para firmar tus cambios (no se envían a ningún sitio)."
        $newName = Read-Host "    Nombre y apellido (Intro para saltar)"
        if ($newName) { & git config --global user.name $newName }
        $newEmail = Read-Host "    Correo electrónico (Intro para saltar)"
        if ($newEmail) { & git config --global user.email $newEmail }
    }
}

function Install-VSCode {
    Write-Step "3/5  Visual Studio Code y extensiones"
    $code = Find-Code
    if (-not $code) {
        Invoke-Winget "Microsoft.VisualStudioCode" "Visual Studio Code" @("--scope", "user")
        $code = Find-Code
    }
    if (-not $code) {
        Write-Warn "No se ha podido instalar VS Code. Sigue el paso 3 de la guía."
        return
    }
    Write-Ok "VS Code en $code"
    foreach ($ext in "ms-python.python", "ms-toolsai.jupyter") {
        & $code --install-extension $ext --force | Out-Null
        Write-Ok "Extensión $ext"
    }
}

function Install-Claude {
    Write-Step "4/5  Claude Code"
    if (-not (Find-Claude)) {
        Write-Host "    Ejecutando el instalador oficial (claude.ai/install.ps1)..."
        # Run the official installer in a child process so nothing it does can end this script.
        & powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://claude.ai/install.ps1 | iex" | Out-Host
        Update-SessionPath
        $bin = Join-Path $env:USERPROFILE ".local\bin"
        if (Test-Path $bin) { $env:Path = "$env:Path;$bin" }
    }
    $claude = Find-Claude
    if ($claude) { Write-Ok "Claude Code $(& $claude --version)" }
    else { Write-Warn "No se ha podido instalar Claude Code. Sigue el paso 7 de la guía." }
}

function Install-Venv([string]$Python) {
    Write-Step "5/5  Entorno virtual .venv y librerías del curso"
    if (-not (Test-Path (Join-Path $CourseDir "requirements.txt"))) {
        Write-Warn "No encuentro requirements.txt: ejecuta este script desde la carpeta del curso."
        return
    }
    if (Test-Path $VenvPython) {
        $ver = Get-PythonVersion $VenvPython
        if (-not $ver -or $ver -lt [version]"3.12") {
            Write-Warn "El .venv existente usa Python $ver; se vuelve a crear con Python 3.12 o superior."
            Remove-Item (Join-Path $CourseDir ".venv") -Recurse -Force
        }
    }
    if (-not (Test-Path $VenvPython)) {
        if (-not $Python) { Write-Warn "Sin Python no se puede crear el entorno."; return }
        & $Python -m venv (Join-Path $CourseDir ".venv")
    }
    Write-Host "    Instalando librerías (entre 3 y 10 minutos)..."
    & $VenvPython -m pip install --upgrade pip --quiet
    & $VenvPython -m pip install -r (Join-Path $CourseDir "requirements.txt")
    if ($LASTEXITCODE -eq 0) { Write-Ok "Librerías instaladas" }
    else { Write-Warn "pip install ha fallado: revisa las últimas líneas de arriba." }

    # Allow activating the venv from PowerShell terminals (current user only, no admin needed).
    $policy = Get-ExecutionPolicy -Scope CurrentUser
    if ($policy -in @("Undefined", "Restricted", "AllSigned")) {
        Set-ExecutionPolicy -Scope CurrentUser RemoteSigned -Force
        Write-Ok "Política de ejecución de PowerShell: RemoteSigned (para activar .venv)"
    }
}

# ---------------------------------------------------------------- checklist

function Test-Checklist {
    Write-Step "Checklist final"
    Update-SessionPath
    $bin = Join-Path $env:USERPROFILE ".local\bin"
    if (Test-Path $bin) { $env:Path = "$env:Path;$bin" }

    $py = Find-Python
    Add-Result "Python >= 3.12" ([bool]$py) $(if ($py) { "Python $(Get-PythonVersion $py)" } else { "no encontrado (paso 1)" })

    $gitOk = Test-Command "git"
    Add-Result "Git" $gitOk $(if ($gitOk) { (& git --version) } else { "no encontrado (paso 2)" })

    $code = Find-Code
    Add-Result "VS Code" ([bool]$code) $(if ($code) { "instalado" } else { "no encontrado (paso 3)" })

    $claude = Find-Claude
    Add-Result "Claude Code" ([bool]$claude) $(if ($claude) { (& $claude --version) } else { "no encontrado (paso 7)" })

    $venvOk = Test-Path $VenvPython
    Add-Result "Entorno .venv" $venvOk $(if ($venvOk) { "Python $(Get-PythonVersion $VenvPython)" } else { "no existe (paso 5)" })

    if ($venvOk) {
        $imports = "import pandas, numpy, scipy, sklearn, matplotlib, seaborn, sqlmodel, notebook; print('Todo OK')"
        # Native stderr + ErrorActionPreference=Stop would throw in Windows PowerShell 5.1.
        $ErrorActionPreference = "Continue"
        $out = (& $VenvPython -c $imports 2>&1 | Select-Object -Last 1)
        $ErrorActionPreference = "Stop"
        Add-Result "Librerías del curso" ($LASTEXITCODE -eq 0) "$out"
        if ("$out" -match "DLL load failed|Control de aplicaciones|Application Control") {
            Write-Warn "Windows ha bloqueado una librería recién instalada (Smart App Control o una política de seguridad)."
            Write-Warn "Repite el checklist en unos minutos (instalar_entorno.bat -SoloComprobar); si sigue, consulta la tabla 'Si algo falla' de la guía."
        }
    } else {
        Add-Result "Librerías del curso" $false "falta el entorno .venv"
    }

    Write-Host ""
    $Results | Format-Table -AutoSize | Out-String | Write-Host
    $failed = @($Results | Where-Object { $_.Estado -eq "FALLA" })
    if ($failed.Count -eq 0) {
        Write-Host "Todo listo. Abre la carpeta del curso en VS Code y prueba un notebook (paso 6 de la guía)." -ForegroundColor Green
    } else {
        Write-Host "Hay pasos pendientes. Busca cada uno en la guía de instalación." -ForegroundColor Yellow
        Write-Host "El registro completo está en: $LogFile" -ForegroundColor Yellow
    }
}

# ---------------------------------------------------------------- main

Start-Transcript -Path $LogFile -Force | Out-Null
try {
    Write-Host "Instalación del entorno del curso de Python" -ForegroundColor Cyan
    Write-Host "Carpeta del curso: $CourseDir"

    if (-not $SoloComprobar) {
        Write-Host "Algunos instaladores pueden pedirte permiso de Windows: acepta para continuar."
        $python = $null
        $steps = @(
            { $script:python = Install-Python },
            { Install-Git },
            { Install-VSCode },
            { Install-Claude },
            { Install-Venv $script:python }
        )
        foreach ($step in $steps) {
            # A failing step is reported and the script moves on to the next one.
            try { & $step } catch { Write-Warn "Error: $($_.Exception.Message)" }
        }
    }
    Test-Checklist
} finally {
    Stop-Transcript | Out-Null
}
