# Día 8 — pandas avanzado y visualización

**Unidad del programa:** Unidad 7 (cierre) + Unidad 8.

## Objetivos del día

- Dominar `.groupby()`: `.agg()` con varias métricas a la vez, iteración sobre grupos, y duplicados/muestreo con criterio.
- Combinar DataFrames con `pd.concat()` y `.merge()` (equivalente a un `JOIN` de SQL o un `BUSCARV` que trae varias columnas de golpe), y construir tablas dinámicas con `pivot_table()`.
- Exportar resultados a CSV y Excel.
- **Validar una transformación de `groupby`/`merge` contra un cálculo de control** — primer bloque de IA del día.
- Entender la jerarquía de objetos de Matplotlib (`Figure`/`Axes`/`Axis`), el enfoque *stateless*, y crear gráficos con `plt.subplots()`.
- Usar seaborn para distribución (`histplot`/`jointplot`/`pairplot`) y variables categóricas (`countplot`/`barplot`/`boxplot`/`violinplot`/`stripplot`/`swarmplot`).
- **Revisar con criterio un gráfico generado por IA** (eje Y desde cero, paleta adecuada, tipo de gráfico correcto) — segundo bloque de IA del día.
- Construir mapas de calor (`heatmap`/`clustermap`) de correlaciones numéricas, V de Cramér y series temporales año × mes.

## Orden de los notebooks

1. `01_teoria_groupby_avanzado.ipynb` — duplicados con `subset`/`keep`, muestreo aleatorio (`.sample()`), `groupby` completo (`.get_group()`, `.agg()`, iteración sobre grupos).
2. `02_teoria_merge_concat_pivot_io.ipynb` — `pd.concat()`, `.merge()` (unión `cartera_polizas` ↔ `siniestros`), `pivot_table()`, exportar a CSV/Excel, y el primer bloque de IA (validar `groupby`+`merge` contra un cálculo de control, con el ratio de siniestralidad como ejemplo).
3. `03_teoria_matplotlib_basico.ipynb` — jerarquía Figure/Axes/Axis, *stateful* vs. *stateless*, `plt.subplots()`, `subplot2grid()`, gestión de memoria de `Figure`s.
4. `04_teoria_seaborn_distribucion_categorica.ipynb` — distribution plots, Teorema del Límite Central, categorical plots, y el segundo bloque de IA (revisión manual de un gráfico generado por IA).
5. `05_teoria_matrix_plots_heatmap.ipynb` — V de Cramér, `heatmap`, `pivot_table` + `heatmap` año × mes, `clustermap`.
6. `06_ejercicios.ipynb` — 6 ejercicios de dificultad creciente: `groupby`/`merge`/`pivot_table`, validación contra cálculo de control, y visualización (incluida una versión propia de `emblem_plot()`).
7. `07_soluciones.ipynb` — soluciones comentadas (no la abras antes de intentar los ejercicios).

## Datasets usados

Todos en `data/raw/` (documentados en `data/generators/README.md`), ya generados — no se editan a mano:

- `cartera_polizas.csv` — `groupby` por provincia, `merge` con `siniestros.csv`, correlación numérica, scatter/histograma en Matplotlib básico.
- `siniestros.csv` — `groupby`/`agg`, V de Cramér entre categóricas, distribution y categorical plots en seaborn, `emblem_plot()`.
- `primas_mensuales.csv` — `pivot_table` (año × mes × producto) y `heatmap`/`clustermap`; sustituye a `sns.load_dataset('flights')` para el mismo propósito (serie temporal año × mes).

## Sustituciones de dependencias rotas o remotas

- `01 Introducción a MatPlotLib .ipynb` original dependía de `cal_housing.tgz` (roto, sin URL de descarga funcional) → sustituido por `cartera_polizas.csv` (`prima_anual`, `edad_tomador`, `franquicia`) en `03_teoria_matplotlib_basico.ipynb`.
- `02 Seaborn - Distribution Plots.ipynb` y `03 Seaborn - Categorical Plots.ipynb` originales usaban `sns.load_dataset('tips')` (descarga remota) → sustituido por `siniestros.csv` en `04_teoria_seaborn_distribucion_categorica.ipynb`.
- `04 Seabor - Matrix Plots.ipynb` original usaba `sns.load_dataset('flights')` (descarga remota) → sustituido por `primas_mensuales.csv` en `05_teoria_matrix_plots_heatmap.ipynb`.
- `sns.violinplot(..., scale="count")` (parámetro obsoleto) corregido a `density_norm="count"`, el nombre vigente en seaborn 0.13 (versión fijada en `requirements.txt`).

## Temporización orientativa

| Bloque | Duración |
|---|---|
| `01_teoria_groupby_avanzado.ipynb` | 90 min |
| `02_teoria_merge_concat_pivot_io.ipynb` | 100-120 min |
| `03_teoria_matplotlib_basico.ipynb` | 75-90 min |
| `04_teoria_seaborn_distribucion_categorica.ipynb` | 100-120 min |
| `05_teoria_matrix_plots_heatmap.ipynb` | 60-75 min |
| `06_ejercicios.ipynb` + puesta en común | 90-120 min |

Total orientativo: una jornada larga o jornada y media según el ritmo del grupo — es el día con más contenido nuevo del curso (cierre de la Unidad 7 + Unidad 8 completa).

## Requisitos previos

Día 7 completo (pandas y NumPy — fundamentos). El bloque de IA de visualización (`04_teoria_seaborn_distribucion_categorica.ipynb`) da por hecho que el grupo ya conoce la política de uso de IA del curso (`docs/uso_ia_en_el_curso.md`).
