# Generadores de datos sintéticos

Todos los datasets que usa el curso son **sintéticos**, generados con semilla fija (reproducibles) por los scripts de esta carpeta. No contienen datos reales de pólizas, siniestros ni clientes de ninguna aseguradora. Los nombres de personas están generados con `Faker` (`es_ES`) y son ficticios.

Para regenerarlos todos: `python data/generators/generar_todo.py` (requiere `requirements.txt` instalado). Los CSV ya generados viven en `data/raw/` y **no se editan a mano**: si hace falta cambiar algo, se cambia el generador y se regenera.

## Datasets y su esquema

### `cartera_polizas.csv` — 3000 filas
Cartera de pólizas de la aseguradora ficticia "Fenix Seguros". Base para pandas (U7/U8), visualización (U8) y SQLAlchemy (U9).

| Columna | Tipo | Descripción |
|---|---|---|
| `poliza_id` | str | Identificador de póliza (`POL100000`...) |
| `asegurado_id` | str | Identificador de asegurado (varios asegurados pueden repetirse entre pólizas) |
| `nombre_asegurado` | str | Nombre ficticio (Faker) |
| `edad_tomador` | int | Edad del tomador |
| `producto` | str | `AUTO` / `HOGAR` / `VIDA` / `SALUD` |
| `provincia` | str | Provincia española |
| `canal_venta` | str | `agente` / `online` / `correduria` / `telefono` |
| `fecha_alta` | date | Fecha de alta de la póliza |
| `fecha_baja` | date (nullable) | Fecha de baja, solo si `anulada` es `True` |
| `prima_anual` | float | Prima anual en euros |
| `franquicia` | int | Franquicia (0 en VIDA/SALUD) |
| `anulada` | bool | Si la póliza ha sido anulada |

### `siniestros.csv` — 1200 filas
Siniestros ligados a `cartera_polizas.csv` por `poliza_id` (no todas las pólizas tienen siniestros). Usado para `groupby`/`merge` (U7/U8), visualización categórica (U8) y ejemplos de estadística (U10).

| Columna | Tipo | Descripción |
|---|---|---|
| `siniestro_id` | str | Identificador del siniestro |
| `poliza_id` | str | FK a `cartera_polizas.poliza_id` |
| `producto` | str | Heredado de la póliza |
| `provincia` | str | Heredada de la póliza |
| `fecha_siniestro` | date | Fecha del siniestro |
| `tipo_siniestro` | str | Depende del producto (p.ej. `colision`, `danos_por_agua`, `hospitalizacion`) |
| `importe_pagado` | float | Importe pagado en euros |
| `estado` | str | `abierto` / `cerrado` |

### `primas_mensuales.csv` — 192 filas
Serie mensual de primas emitidas por producto (formato largo: `anio`, `mes`, `producto`). Sustituye a `sns.load_dataset('flights')` para `pivot_table`/heatmap en la Unidad 8.

| Columna | Tipo | Descripción |
|---|---|---|
| `anio` | int | 2021-2024 |
| `mes` | int | 1-12 |
| `producto` | str | `AUTO` / `HOGAR` / `VIDA` / `SALUD` |
| `num_polizas` | int | Pólizas emitidas ese mes |
| `primas_emitidas` | float | Suma de primas emitidas ese mes (€) |

### `compras_seguros.csv` — 815 filas
Dataset de ejercicios de la Unidad 7, con incidencias de calidad de datos **a propósito** (nulos en `edad_cliente` y `satisfaccion`, 15 filas duplicadas) para practicar limpieza. Sustituye al dataset roto `direct_insurance.csv` del material heredado.

| Columna | Tipo | Descripción |
|---|---|---|
| `compra_id` | str | Identificador de compra |
| `cliente_id` | str | Identificador de cliente |
| `fecha_compra` | date | Fecha de contratación |
| `producto` | str | `AUTO` / `HOGAR` / `VIDA` / `SALUD` |
| `provincia` | str | Provincia |
| `canal_venta` | str | Canal de venta |
| `edad_cliente` | float (nullable) | Edad del cliente — **contiene nulos a propósito** |
| `importe` | float | Importe de la compra (€) |
| `descuento_aplicado_pct` | int | Descuento aplicado (%) |
| `satisfaccion` | float (nullable) | Puntuación 1-5 — **contiene nulos a propósito** |

### `polizas_auto_anulacion.csv` — 5000 filas
Dataset del proyecto final opcional (modelo de anulación de pólizas de auto). La variable objetivo `anulada` tiene señal real: pago mensual, impago previo, siniestralidad alta y pólizas jóvenes aumentan la probabilidad de anulación, con ruido añadido. Incluye nulos en `potencia_cv` y un outlier en `prima_anual`, a propósito, para el bloque de limpieza previo al modelado.

| Columna | Tipo | Descripción |
|---|---|---|
| `poliza_id` | str | Identificador |
| `edad_conductor` | int | Edad del conductor |
| `antiguedad_carnet` | int | Años desde la obtención del carnet |
| `tipo_vehiculo` | str | `turismo` / `furgoneta` / `moto` / `todoterreno` |
| `antiguedad_vehiculo` | int | Años del vehículo |
| `potencia_cv` | float (nullable) | Potencia en CV — **contiene nulos a propósito** |
| `uso` | str | `particular` / `mixto` |
| `km_anuales` | int | Kilometraje anual declarado |
| `provincia` | str | Provincia |
| `canal_venta` | str | Canal de venta |
| `forma_pago` | str | `mensual` / `anual` |
| `num_siniestros_3_anios` | int | Siniestros en los últimos 3 años |
| `antiguedad_poliza_meses` | int | Antigüedad de la póliza en meses |
| `recibo_impagado_alguna_vez` | bool | Si ha tenido algún recibo impagado |
| `prima_anual` | float | Prima anual (€) — **contiene un outlier a propósito** |
| `anulada` | bool | **Variable objetivo**: si la póliza fue anulada |

## Añadir un dataset nuevo

Crea `data/generators/generar_<nombre>.py` siguiendo el patrón de los existentes (usa `_common.py` para semilla, provincias, canales y Faker), añádelo a `SCRIPTS_EN_ORDEN` en `generar_todo.py` si otros generadores dependen de él, y documenta su esquema en este archivo.
