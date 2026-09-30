# Día 9 — Fuentes de datos y estadística aplicada

**Unidades del programa:** Unidad 9 (SQLAlchemy/SQLModel, APIs) y Unidad 10 (estadística aplicada con SciPy).

## Objetivos del día

- Cerrar el CRUD completo (Create, Read, Update, Delete) con `SQLModel` sobre una base de datos SQLite en memoria, sin dejar artefactos `.db` en el repositorio.
- Entender el modelo relacional (primary key, foreign key) y por qué un ORM evita SQL injection por diseño.
- Consumir una API REST con `requests`: estructura de una llamada, JSON, manejo de errores HTTP (401, 404) y gestión de credenciales mediante variables de entorno (`python-dotenv`), sin depender de ningún servicio externo real.
- Calcular medidas de tendencia central, variabilidad y correlación con `scipy.stats` (no solo `pandas.describe()`).
- Trabajar con distribuciones de probabilidad (normal, binomial, Poisson): `pdf`/`pmf`, `cdf`, `ppf`, `rvs`, `.fit()`.
- Ejecutar e interpretar pruebas de hipótesis (`ttest_1samp`, `ttest_ind`, `chi2_contingency`), validando siempre el p-valor numéricamente antes de sacar conclusiones.

## Orden de los notebooks

**Mañana — Unidad 9 (fuentes de datos):**

1. `01_teoria_bbdd_fundamentos.ipynb` — qué es una base de datos, BD en archivo único vs. servidor, modelo relacional (PK/FK), SQL injection y sanitización, primer modelo `SQLModel`.
2. `02_teoria_bbdd_crud.ipynb` — CRUD completo con datos de `cartera_polizas.csv`: Create, Read (recordatorio), **Update** y **Delete** (lo que faltaba en el material heredado), SQLite en memoria con `poolclass=StaticPool`, y el primer bloque de IA del día (entender un parámetro de conexión de SQLAlchemy, verificado contra la documentación oficial y de forma empírica).
3. `03_teoria_apis_rest.ipynb` — estructura de una llamada REST, servidor HTTP local de prueba (`http.server`, hilo de fondo, puerto dinámico) para no depender de internet, `requests`, manejo de errores HTTP, credenciales con variables de entorno y `.env`/`.env.example`.

**Tarde — Unidad 10 (estadística aplicada):**

4. `04_teoria_estadistica_descriptiva.ipynb` — tendencia central (media, media ponderada, armónica, geométrica, mediana, moda), variabilidad (varianza, desviación estándar, skewness, percentiles) y correlación (Pearson, Spearman, Kendall) con `scipy.stats`, sobre `cartera_polizas.csv`/`siniestros.csv`.
5. `05_teoria_distribuciones_probabilidad.ipynb` — la API común de `scipy.stats` (`pdf`/`pmf`, `cdf`, `ppf`, `rvs`), y las distribuciones normal, binomial y Poisson aplicadas a edad de tomadores, anulación de pólizas y número de siniestros por póliza.
6. `06_teoria_pruebas_hipotesis.ipynb` — `ttest_1samp`, `ttest_ind` (con test de Welch), `chi2_contingency`, interpretación correcta del p-valor, y el segundo bloque de IA del día (traducir un resultado estadístico a lenguaje de negocio, validando siempre numéricamente).

**Cierre:**

7. `07_ejercicios.ipynb` — 6 ejercicios de dificultad creciente que mezclan BBDD/API y estadística, cada uno con criterio de validación explícito (`verificar_ejercicio_N()`).
8. `08_soluciones.ipynb` — soluciones comentadas con notas de corrección (no las abras antes de intentar los ejercicios).

## Temporización orientativa

| Bloque | Duración |
|---|---|
| `01_teoria_bbdd_fundamentos.ipynb` | 60-75 min |
| `02_teoria_bbdd_crud.ipynb` | 90-100 min |
| `03_teoria_apis_rest.ipynb` | 75-90 min |
| `04_teoria_estadistica_descriptiva.ipynb` | 75-90 min |
| `05_teoria_distribuciones_probabilidad.ipynb` | 90 min |
| `06_teoria_pruebas_hipotesis.ipynb` | 90-100 min |
| `07_ejercicios.ipynb` + puesta en común | 90-120 min |

Total orientativo: dos jornadas completas (mañana = Unidad 9, tarde = Unidad 10), o un día y medio si el grupo va sobrado de tiempo. Es el día más denso del curso en contenido nuevo puro (CRUD completo, APIs, distribuciones y pruebas de hipótesis no tenían ningún precedente en el material heredado) — si hace falta recortar, el primer candidato es reducir los ejemplos adicionales de `04_teoria_estadistica_descriptiva.ipynb` (la parte descriptiva ya la domina el alumnado desde su formación actuarial), nunca los notebooks 02, 03, 05 o 06, que son contenido nuevo obligatorio del programa.

## Requisitos previos

Día 5 (POO: una clase `SQLModel` es, por dentro, una clase de Python con anotaciones de tipo). Día 7/8 (pandas, para leer y transformar `cartera_polizas.csv`/`siniestros.csv`). Conocimientos previos de estadística descriptiva e inferencial de la formación actuarial del alumnado — este día no explica qué es una distribución normal, una hipótesis nula o un p-valor desde cero, solo cómo se calculan en Python con `scipy.stats`.
