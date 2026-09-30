"""
Genera data/raw/polizas_auto_anulacion.csv: dataset sintetico para el
proyecto final opcional (modelo de anulacion de polizas de auto en lineas
personales). Incluye senal real (variables que influyen genuinamente en la
probabilidad de anulacion) mas ruido, algunos nulos y un outlier a proposito,
para que el ejercicio de limpieza y modelado tenga sentido.

Ejecucion: python data/generators/generar_proyecto_final.py
"""
from __future__ import annotations

import numpy as np
import pandas as pd

from _common import CANALES_VENTA, PROVINCIAS, SEED, ensure_raw_dir

N = 5000


def generar() -> pd.DataFrame:
    rng = np.random.default_rng(SEED + 4)

    edad_conductor = rng.integers(18, 80, size=N)
    antiguedad_carnet = np.clip(edad_conductor - rng.integers(18, 25, size=N), 0, None)
    tipo_vehiculo = rng.choice(["turismo", "furgoneta", "moto", "todoterreno"], size=N, p=[0.65, 0.12, 0.13, 0.10])
    antiguedad_vehiculo = rng.integers(0, 20, size=N)
    potencia_cv = rng.integers(60, 300, size=N).astype(float)
    uso = rng.choice(["particular", "mixto"], size=N, p=[0.8, 0.2])
    km_anuales = rng.integers(2000, 40000, size=N)
    provincia = rng.choice(PROVINCIAS, size=N)
    canal_venta = rng.choice(CANALES_VENTA, size=N)
    forma_pago = rng.choice(["mensual", "anual"], size=N, p=[0.6, 0.4])
    num_siniestros_3_anios = rng.poisson(0.35, size=N)
    antiguedad_poliza_meses = rng.integers(1, 180, size=N)
    recibo_impagado_alguna_vez = rng.random(N) < 0.12

    prima_anual = (
        250
        + potencia_cv * 1.1
        + (antiguedad_vehiculo * 3)
        - (antiguedad_carnet * 1.8)
        + num_siniestros_3_anios * 90
        + rng.normal(0, 40, size=N)
    ).clip(min=180).round(2)

    # senal real para la anulacion: prima alta, impago previo, pago mensual,
    # poliza joven y muchos siniestros aumentan la probabilidad de anular
    logit = (
        -2.6
        + 0.9 * recibo_impagado_alguna_vez
        + 0.55 * (forma_pago == "mensual")
        + 0.35 * num_siniestros_3_anios
        + 0.012 * (prima_anual - prima_anual.mean()) / prima_anual.std()
        - 0.010 * (antiguedad_poliza_meses - antiguedad_poliza_meses.mean()) / antiguedad_poliza_meses.std()
        - 0.25 * (canal_venta == "agente")
    )
    prob_anulacion = 1 / (1 + np.exp(-logit))
    anulada = rng.random(N) < prob_anulacion

    df = pd.DataFrame(
        {
            "poliza_id": [f"AUTO{300000 + i}" for i in range(N)],
            "edad_conductor": edad_conductor,
            "antiguedad_carnet": antiguedad_carnet,
            "tipo_vehiculo": tipo_vehiculo,
            "antiguedad_vehiculo": antiguedad_vehiculo,
            "potencia_cv": potencia_cv,
            "uso": uso,
            "km_anuales": km_anuales,
            "provincia": provincia,
            "canal_venta": canal_venta,
            "forma_pago": forma_pago,
            "num_siniestros_3_anios": num_siniestros_3_anios,
            "antiguedad_poliza_meses": antiguedad_poliza_meses,
            "recibo_impagado_alguna_vez": recibo_impagado_alguna_vez,
            "prima_anual": prima_anual,
            "anulada": anulada,
        }
    )

    # nulos a proposito (ejercicio de limpieza antes de modelar)
    idx_nulos_potencia = rng.choice(N, size=60, replace=False)
    df.loc[idx_nulos_potencia, "potencia_cv"] = np.nan

    # un outlier claro a proposito
    df.loc[rng.integers(0, N), "prima_anual"] = 45000.0

    return df.sample(frac=1, random_state=SEED).reset_index(drop=True)


if __name__ == "__main__":
    df = generar()
    out = ensure_raw_dir() / "polizas_auto_anulacion.csv"
    df.to_csv(out, index=False)
    tasa = df["anulada"].mean()
    print(f"Escrito {out} ({len(df)} filas, tasa de anulacion {tasa:.1%})")
