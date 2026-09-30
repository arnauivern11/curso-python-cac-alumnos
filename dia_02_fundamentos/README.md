# Día 2 — Fundamentos de Python

**Unidad del programa:** Unidad 2.

## Objetivos del día

- Trabajar con los tipos numéricos de Python, sus operadores y la precedencia entre ellos.
- Usar variables entendiendo que son referencias a objetos, no "cajas" que copian valores, y aplicar las convenciones de nombres de PEP 8.
- Usar booleanos, operadores de comparación y lógicos, y distinguir `==` de `is`.
- Crear, indexar, trocear (*slicing*) y formatear strings.
- Crear y manipular listas, diccionarios y tuplas, entendiendo mutabilidad frente a inmutabilidad.
- Leer y escribir archivos de texto con `open()`/`with` y los distintos modos de apertura.
- Pedirle a un asistente de IA una analogía de Excel para un concepto de Python, y saber verificarla en vez de darla por buena sin más.

## Orden de los notebooks

1. `01_teoria_numeros_variables.ipynb` — tipos numéricos, aritmética, precedencia, variables y `id()`, nombres PEP 8.
2. `02_teoria_booleanos_operadores.ipynb` — `bool`, comparaciones, operadores lógicos, `==` frente a `is`, y un bloque bonus de `set`.
3. `03_teoria_strings.ipynb` — creación, indexado/slicing, inmutabilidad, métodos, formateo con f-strings.
4. `04_teoria_listas.ipynb` — creación, indexado/slicing, mutabilidad (y el riesgo de los alias), métodos, listas anidadas, list comprehension.
5. `05_teoria_diccionarios.ipynb` — creación, acceso, anidamiento, `.items()`/`.get()`, dict comprehension, y el **bloque de IA** de analogías de Excel.
6. `06_teoria_tuplas.ipynb` — construcción, inmutabilidad, métodos, unpacking, cuándo usar una tupla en vez de una lista.
7. `07_teoria_io_archivos.ipynb` — qué es un archivo y una ruta, `open()`/`with`, modos de apertura, lectura y escritura.
8. `08_ejercicios.ipynb` — 8 ejercicios de dificultad creciente sobre todo el día.
9. `09_soluciones.ipynb` — soluciones comentadas (no la abras antes de intentar los ejercicios).

## Temporización orientativa

| Bloque | Duración |
|---|---|
| `01_teoria_numeros_variables.ipynb` | 45-60 min |
| `02_teoria_booleanos_operadores.ipynb` | 45 min |
| `03_teoria_strings.ipynb` | 60 min |
| `04_teoria_listas.ipynb` | 60 min |
| `05_teoria_diccionarios.ipynb` (incluye bloque de IA) | 60 min |
| `06_teoria_tuplas.ipynb` | 30-40 min |
| `07_teoria_io_archivos.ipynb` | 40-50 min |
| `08_ejercicios.ipynb` + puesta en común | 60-75 min |

Total orientativo: una jornada completa. Si el grupo va sobrado de tiempo, el Ejercicio 8 (integrador) da pie a una buena discusión en grupo sobre el paralelismo entre "lista de diccionarios" y una hoja de cálculo — es la idea que reaparecerá en el Día 7 con pandas.

## Requisitos previos

Haber completado el Día 1 (`dia_01_entorno_e_ia/`): entorno instalado y comprobado, saber ejecutar y reiniciar un notebook, y tener Claude Code operativo para el bloque de IA de `05_teoria_diccionarios.ipynb`.
