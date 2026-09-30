"""
Utilidades compartidas por los generadores de datos sinteticos del curso.

Todos los datasets del curso son ficticios: nombres, direcciones e importes
generados con semilla fija para que el curso sea reproducible. No representan
personas, polizas ni siniestros reales de ninguna aseguradora.
"""
from __future__ import annotations

import os
from pathlib import Path

from faker import Faker

SEED = 2026

RAW_DIR = Path(__file__).resolve().parent.parent / "raw"

PROVINCIAS = [
    "Barcelona", "Madrid", "Valencia", "Sevilla", "Zaragoza",
    "Malaga", "Alicante", "Vizcaya", "A Coruna", "Girona",
    "Tarragona", "Lleida", "Baleares", "Asturias", "Cantabria",
]

PRODUCTOS = ["AUTO", "HOGAR", "VIDA", "SALUD"]

CANALES_VENTA = ["agente", "online", "correduria", "telefono"]


def get_faker() -> Faker:
    fk = Faker("es_ES")
    Faker.seed(SEED)
    return fk


def ensure_raw_dir() -> Path:
    RAW_DIR.mkdir(parents=True, exist_ok=True)
    return RAW_DIR
