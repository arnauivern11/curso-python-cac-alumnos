"""
Genera data/raw/primas_mensuales.csv: serie mensual de primas emitidas por
producto, en formato largo (anio, mes, producto, primas_emitidas, num_polizas).
Sustituye al dataset remoto sns.load_dataset('flights') para los ejemplos de
heatmap / pivot_table de la Unidad 8, con datos del propio dominio del curso.

Ejecucion: python data/generators/generar_primas_mensuales.py
"""
from __future__ import annotations

import numpy as np
import pandas as pd

from _common import PRODUCTOS, SEED, ensure_raw_dir

ANIOS = [2021, 2022, 2023, 2024]
MESES = list(range(1, 13))

BASE_POR_PRODUCTO = {"AUTO": 55, "HOGAR": 38, "VIDA": 18, "SALUD": 12}
CRECIMIENTO_ANUAL = {"AUTO": 1.06, "HOGAR": 1.09, "VIDA": 1.04, "SALUD": 1.15}
ESTACIONALIDAD = {  # factor multiplicativo por mes (1=enero ... 12=diciembre)
    1: 0.95, 2: 0.90, 3: 1.00, 4: 1.02, 5: 1.05, 6: 1.10,
    7: 1.15, 8: 0.85, 9: 1.08, 10: 1.05, 11: 1.00, 12: 1.20,
}


def generar() -> pd.DataFrame:
    rng = np.random.default_rng(SEED + 2)
    filas = []
    for producto in PRODUCTOS:
        base = BASE_POR_PRODUCTO[producto]
        for i, anio in enumerate(ANIOS):
            crecimiento = CRECIMIENTO_ANUAL[producto] ** i
            for mes in MESES:
                num_polizas = base * crecimiento * ESTACIONALIDAD[mes]
                num_polizas = max(1, round(num_polizas * rng.normal(1.0, 0.05)))
                prima_media = {"AUTO": 420, "HOGAR": 260, "VIDA": 310, "SALUD": 780}[producto]
                primas_emitidas = round(num_polizas * prima_media * rng.normal(1.0, 0.03), 2)
                filas.append(
                    {
                        "anio": anio,
                        "mes": mes,
                        "producto": producto,
                        "num_polizas": int(num_polizas),
                        "primas_emitidas": primas_emitidas,
                    }
                )
    return pd.DataFrame(filas)


if __name__ == "__main__":
    df = generar()
    out = ensure_raw_dir() / "primas_mensuales.csv"
    df.to_csv(out, index=False)
    print(f"Escrito {out} ({len(df)} filas)")
