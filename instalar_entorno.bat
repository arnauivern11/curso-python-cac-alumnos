@echo off
rem Doble clic para instalar el entorno del curso. Ver docs/guia_instalacion.pdf.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0instalar_entorno.ps1" %*
echo.
pause
