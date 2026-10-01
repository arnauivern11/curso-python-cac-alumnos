@echo off
rem Abre Jupyter Notebook con el entorno del curso (.venv): no hace falta activar nada ni elegir kernel.
rem Ver docs/guia_instalacion.pdf, paso 6.
cd /d "%~dp0"
if not exist ".venv\Scripts\python.exe" (
    echo No se encuentra el entorno .venv del curso: ejecuta antes instalar_entorno.bat
    echo.
    pause
    exit /b 1
)
echo Abriendo Jupyter Notebook en el navegador...
echo.
echo   Deja esta ventana abierta mientras trabajas.
echo   Para cerrar Jupyter: guarda tus notebooks y cierra esta ventana.
echo.
".venv\Scripts\python.exe" -m notebook
pause
