"""
Genera data/raw/siniestros.csv: siniestros sinteticos ligados a las polizas
de data/raw/cartera_polizas.csv (debe generarse antes con
generar_cartera_polizas.py).

Ejecucion: python data/generators/generar_siniestros.py
"""
from __future__ import annotations

import numpy as np
import pandas as pd

from _common import RAW_DIR, SEED, ensure_raw_dir

TIPOS_POR_PRODUCTO = {
    "AUTO": ["colision", "robo", "rotura_lunas", "incendio", "asistencia_en_carretera"],
    "HOGAR": ["danos_por_agua", "robo", "incendio", "averia_electrodomesticos"],
    "VIDA": ["fallecimiento", "invalidez"],
    "SALUD": ["hospitalizacion", "consulta_especialista", "cirugia"],
}

IMPORTE_MEDIO_POR_TIPO = {
    "colision": 1800, "robo": 900, "rotura_lunas": 220, "incendio": 4500,
    "asistencia_en_carretera": 150, "danos_por_agua": 1100, "averia_electrodomesticos": 300,
    "fallecimiento": 60000, "invalidez": 25000, "hospitalizacion": 3200,
    "consulta_especialista": 90, "cirugia": 5200,
}


def generar() -> pd.DataFrame:
    rng = np.random.default_rng(SEED + 1)
    cartera = pd.read_csv(RAW_DIR / "cartera_polizas.csv", parse_dates=["fecha_alta"])

    # cada poliza tiene entre 0 y 3 siniestros, mas probable si es AUTO/SALUD
    prob_siniestro = cartera["producto"].map({"AUTO": 0.55, "SALUD": 0.5, "HOGAR": 0.3, "VIDA": 0.05})
    n_siniestros_por_poliza = rng.poisson(prob_siniestro)

    filas = []
    siniestro_id = 1
    for _, poliza in cartera.iterrows():
        n = n_siniestros_por_poliza[poliza.name]
        if n == 0:
            continue
        tipos_posibles = TIPOS_POR_PRODUCTO[poliza["producto"]]
        for _ in range(n):
            tipo = rng.choice(tipos_posibles)
            importe_medio = IMPORTE_MEDIO_POR_TIPO[tipo]
            importe = max(50, rng.gamma(shape=2.0, scale=importe_medio / 2.0))
            dias_desde_alta = int(rng.integers(10, 365 * 3))
            fecha = poliza["fecha_alta"] + np.timedelta64(dias_desde_alta, "D")
            estado = rng.choice(["cerrado", "cerrado", "cerrado", "abierto"])
            filas.append(
                {
                    "siniestro_id": f"SIN{500000 + siniestro_id}",
                    "poliza_id": poliza["poliza_id"],
                    "producto": poliza["producto"],
                    "provincia": poliza["provincia"],
                    "fecha_siniestro": fecha.date(),
                    "tipo_siniestro": tipo,
                    "importe_pagado": round(importe, 2),
                    "estado": estado,
                }
            )
            siniestro_id += 1

    return pd.DataFrame(filas)


if __name__ == "__main__":
    df = generar()
    out = ensure_raw_dir() / "siniestros.csv"
    df.to_csv(out, index=False)
    print(f"Escrito {out} ({len(df)} filas)")
