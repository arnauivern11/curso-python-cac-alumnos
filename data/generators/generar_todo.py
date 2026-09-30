"""
Regenera todos los datasets sinteticos del curso en data/raw/, en el orden
correcto (algunos generadores dependen de la salida de otros).

Ejecucion: python data/generators/generar_todo.py
"""
import runpy
from pathlib import Path

SCRIPTS_EN_ORDEN = [
    "generar_cartera_polizas.py",
    "generar_siniestros.py",
    "generar_primas_mensuales.py",
    "generar_compras_seguros.py",
    "generar_proyecto_final.py",
]

if __name__ == "__main__":
    directorio = Path(__file__).resolve().parent
    for nombre in SCRIPTS_EN_ORDEN:
        print(f"--- {nombre} ---")
        runpy.run_path(str(directorio / nombre), run_name="__main__")
