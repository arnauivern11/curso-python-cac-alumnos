"""
Genera data/raw/compras_seguros.csv: dataset de compras/contratacion de
seguros con incidencias tipicas de calidad de datos a proposito (nulos,
duplicados, tipos mezclados), pensado para el bloque de ejercicios de la
Unidad 7. Sustituye al dataset roto "direct_insurance.csv" del material
heredado (referenciado pero nunca incluido en el repositorio original).

Ejecucion: python data/generators/generar_compras_seguros.py
"""
from __future__ import annotations

import numpy as np
import pandas as pd

from _common import CANALES_VENTA, PRODUCTOS, PROVINCIAS, SEED, ensure_raw_dir, get_faker

N = 800


def generar() -> pd.DataFrame:
    rng = np.random.default_rng(SEED + 3)
    fk = get_faker()

    productos = rng.choice(PRODUCTOS, size=N, p=[0.5, 0.25, 0.15, 0.10])
    provincias = rng.choice(PROVINCIAS, size=N)
    canales = rng.choice(CANALES_VENTA, size=N)
    edad_cliente = rng.integers(18, 80, size=N).astype(float)
    fechas_compra = pd.to_datetime("2023-01-01") + pd.to_timedelta(
        rng.integers(0, 700, size=N), unit="D"
    )
    importe_base = {"AUTO": 420, "HOGAR": 260, "VIDA": 310, "SALUD": 780}
    importe = np.array([importe_base[p] for p in productos]) * rng.normal(1.0, 0.2, size=N)
    importe = importe.round(2)
    descuento_aplicado = rng.choice([0, 5, 10, 15, 20], size=N, p=[0.4, 0.25, 0.2, 0.1, 0.05])
    satisfaccion = rng.integers(1, 6, size=N).astype(float)

    df = pd.DataFrame(
        {
            "compra_id": [f"CMP{i:05d}" for i in range(N)],
            "cliente_id": [f"CLI{2000 + (i % 650)}" for i in range(N)],
            "fecha_compra": fechas_compra.date,
            "producto": productos,
            "provincia": provincias,
            "canal_venta": canales,
            "edad_cliente": edad_cliente,
            "importe": importe,
            "descuento_aplicado_pct": descuento_aplicado,
            "satisfaccion": satisfaccion,
        }
    )

    # Incidencias de calidad de datos, a proposito (ejercicio de limpieza):
    idx_nulos_edad = rng.choice(N, size=25, replace=False)
    df.loc[idx_nulos_edad, "edad_cliente"] = np.nan

    idx_nulos_satisfaccion = rng.choice(N, size=40, replace=False)
    df.loc[idx_nulos_satisfaccion, "satisfaccion"] = np.nan

    # duplicados exactos de algunas filas (compra registrada dos veces)
    duplicados = df.sample(n=15, random_state=SEED).copy()
    df = pd.concat([df, duplicados], ignore_index=True)

    return df.sample(frac=1, random_state=SEED).reset_index(drop=True)


if __name__ == "__main__":
    df = generar()
    out = ensure_raw_dir() / "compras_seguros.csv"
    df.to_csv(out, index=False)
    print(f"Escrito {out} ({len(df)} filas)")
