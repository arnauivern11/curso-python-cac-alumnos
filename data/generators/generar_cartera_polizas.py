"""
Genera data/raw/cartera_polizas.csv: una cartera sintetica de polizas de una
aseguradora ficticia ("Fenix Seguros"), usada como dataset base en varias
unidades del curso (pandas, visualizacion, bases de datos).

Ejecucion: python data/generators/generar_cartera_polizas.py
"""
from __future__ import annotations

import numpy as np
import pandas as pd

from _common import CANALES_VENTA, PRODUCTOS, PROVINCIAS, SEED, ensure_raw_dir, get_faker

N_POLIZAS = 3000


def generar() -> pd.DataFrame:
    rng = np.random.default_rng(SEED)
    fk = get_faker()

    productos = rng.choice(PRODUCTOS, size=N_POLIZAS, p=[0.45, 0.30, 0.15, 0.10])
    provincias = rng.choice(PROVINCIAS, size=N_POLIZAS)
    canales = rng.choice(CANALES_VENTA, size=N_POLIZAS, p=[0.35, 0.30, 0.25, 0.10])

    fechas_alta = pd.to_datetime("2021-01-01") + pd.to_timedelta(
        rng.integers(0, 365 * 4, size=N_POLIZAS), unit="D"
    )

    edad_tomador = rng.integers(18, 85, size=N_POLIZAS)

    prima_base = {
        "AUTO": 420,
        "HOGAR": 260,
        "VIDA": 310,
        "SALUD": 780,
    }
    prima_anual = np.array([prima_base[p] for p in productos], dtype=float)
    prima_anual *= rng.normal(1.0, 0.18, size=N_POLIZAS)
    prima_anual += (edad_tomador - 40) * rng.normal(1.5, 0.5, size=N_POLIZAS)
    prima_anual = prima_anual.clip(min=90).round(2)

    franquicia = np.where(
        productos == "AUTO", rng.choice([150, 300, 450, 600], size=N_POLIZAS),
        np.where(productos == "HOGAR", rng.choice([0, 150, 300], size=N_POLIZAS), 0),
    )

    prob_anulada = 0.10 + (prima_anual > np.percentile(prima_anual, 80)) * 0.08
    anulada = rng.random(N_POLIZAS) < prob_anulada

    fecha_baja = pd.Series(pd.NaT, index=range(N_POLIZAS))
    idx_anuladas = np.where(anulada)[0]
    dias_hasta_baja = rng.integers(30, 365 * 3, size=len(idx_anuladas))
    fecha_baja.iloc[idx_anuladas] = fechas_alta.values[idx_anuladas] + pd.to_timedelta(
        dias_hasta_baja, unit="D"
    )

    nombres = [fk.name() for _ in range(N_POLIZAS)]

    df = pd.DataFrame(
        {
            "poliza_id": [f"POL{100000 + i}" for i in range(N_POLIZAS)],
            "asegurado_id": [f"AS{20000 + (i % 2600)}" for i in range(N_POLIZAS)],
            "nombre_asegurado": nombres,
            "edad_tomador": edad_tomador,
            "producto": productos,
            "provincia": provincias,
            "canal_venta": canales,
            "fecha_alta": fechas_alta.date,
            "fecha_baja": fecha_baja.dt.date,
            "prima_anual": prima_anual,
            "franquicia": franquicia,
            "anulada": anulada,
        }
    )
    return df


if __name__ == "__main__":
    df = generar()
    out = ensure_raw_dir() / "cartera_polizas.csv"
    df.to_csv(out, index=False)
    print(f"Escrito {out} ({len(df)} filas)")
