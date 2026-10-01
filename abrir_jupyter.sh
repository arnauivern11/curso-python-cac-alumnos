#!/bin/bash
# Abre Jupyter Notebook con el entorno del curso (.venv): no hace falta activar nada ni elegir kernel.
# Uso, desde Terminal: bash abrir_jupyter.sh   (ver docs/guia_instalacion.pdf, página «Si usas un Mac»)
cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1
if [ ! -x .venv/bin/python ]; then
    echo "No se encuentra el entorno .venv del curso: ejecuta antes  bash instalar_entorno.sh"
    exit 1
fi
echo "Abriendo Jupyter Notebook en el navegador..."
echo ""
echo "  Deja esta ventana de Terminal abierta mientras trabajas."
echo "  Para cerrar Jupyter: guarda tus notebooks y pulsa Ctrl+C dos veces en esta ventana."
echo ""
exec .venv/bin/python -m notebook
