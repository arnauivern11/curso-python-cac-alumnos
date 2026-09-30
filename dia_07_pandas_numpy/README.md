# Día 7 — pandas y NumPy: fundamentos

**Unidad del programa:** Unidad 7 (primera mitad).

## Objetivos del día

- Entender qué es un array de NumPy, cómo se diferencia de una lista de Python, y por qué pandas se apoya en NumPy por dentro (vectorización, broadcasting básico).
- Crear y explorar `Series` de pandas: atributos, métodos habituales (`head`/`tail`/`sort_values`/`sort_index`/`apply`), operaciones vectorizadas y filtros.
- Crear y leer `DataFrame`s desde CSV y Excel, y explorar sus atributos básicos (`shape`, `columns`, `dtypes`).
- Seleccionar, crear, modificar y eliminar columnas; gestionar nulos (`dropna`/`fillna`) y duplicados (`duplicated`/`drop_duplicates`) con criterio de negocio, no de forma automática.
- Filtrar filas con condiciones lógicas, `isin`, `isnull`, `between` y `query`.
- Traducir una fórmula de Excel (`SUMAR.SI`, `CONTAR.SI`) a su equivalente en pandas, y validar el resultado contra un cálculo de control hecho a mano — el bloque de IA del día.

## Orden de los notebooks

1. `01_teoria_numpy.ipynb` — arrays de NumPy, creación, atributos, operaciones vectorizadas, broadcasting básico, comparación con listas de Python. No es un curso completo de NumPy: lo justo para entender por qué pandas funciona como funciona.
2. `02_teoria_series.ipynb` — qué es una `Series`, creación, atributos, métodos habituales, vectorización, filtros.
3. `03_teoria_dataframes_basico.ipynb` — qué es un `DataFrame`, `read_csv`/`read_excel`, atributos básicos, renombrar columnas.
4. `04_teoria_seleccion_filtrado_nulos.ipynb` — columnas (seleccionar/crear/modificar/eliminar), gestión de nulos, duplicados, filtros (`isin`/`isnull`/`between`/`query`), y el bloque de IA de traducción Excel→pandas.
5. `05_ejercicios.ipynb` — 10 ejercicios de dificultad creciente sobre `data/raw/compras_seguros.csv`.
6. `06_soluciones.ipynb` — soluciones comentadas (no la abras antes de intentar los ejercicios).

## Datasets usados

Todos en `data/raw/` (documentados en `data/generators/README.md`), ya generados — no se editan a mano:

- `cartera_polizas.csv` — dataset principal de la teoría (DataFrame básico, selección, filtros, nulos con significado propio en `fecha_baja`).
- `siniestros.csv` — usado puntualmente en ejercicios "Para ti" de la teoría.
- `compras_seguros.csv` — dataset de los ejercicios del día; tiene nulos y duplicados **a propósito** para practicar limpieza. Sustituye al dataset roto `direct_insurance.csv` del material heredado.

## Temporización orientativa

| Bloque | Duración |
|---|---|
| `01_teoria_numpy.ipynb` | 45-60 min |
| `02_teoria_series.ipynb` | 60 min |
| `03_teoria_dataframes_basico.ipynb` | 60-75 min |
| `04_teoria_seleccion_filtrado_nulos.ipynb` | 90-100 min |
| `05_ejercicios.ipynb` + puesta en común | 60-90 min |

Total orientativo: una jornada completa.

## Requisitos previos

Día 2 (listas, diccionarios), Día 3 (control de flujo), Día 4 (funciones, docstrings, typing). Conviene tener ya asumida la política de uso de IA del curso (`docs/uso_ia_en_el_curso.md`), porque el bloque de IA de hoy pide validar explícitamente contra un cálculo de control, no solo comprobar que el código se ejecuta.
