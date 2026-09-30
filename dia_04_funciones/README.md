# Día 4 — Funciones

**Unidad del programa:** Unidad 4.

## Objetivos del día

- Definir funciones con parámetros posicionales, `keyword` y con valor por defecto, y usar `return` correctamente (incluyendo retorno de varios valores).
- Documentar funciones con docstrings estilo Google y anotaciones de tipo (`typing`).
- Usar `*args`/`**kwargs` para aceptar un número variable de argumentos, y los operadores `*`/`**` para desempaquetar iterables y diccionarios.
- Entender los namespaces de Python (`built-in`, global, local, *enclosing*) y la regla LEGB.
- Escribir funciones anónimas con `lambda` y combinarlas con `map()`/`filter()`.
- (Opcional/bonus) Reconocer decoradores simples y las utilidades más comunes de `functools`.
- Usar un asistente de IA para refactorizar una función, documentarla y detectar casos borde — validando siempre el resultado con un caso de prueba antes de aceptarlo.

## Orden de los notebooks

1. `01_teoria_funciones_basicas.ipynb` — definición, parámetros, `return`, docstrings, typing, bloque de IA (refactorización asistida) y mini-proyecto del juego del trile. **Core.**
2. `02_teoria_args_kwargs.ipynb` — `*args`, `**kwargs`, orden de parámetros, operadores de *unpacking*. **Core.**
3. `03_teoria_scope_namespaces.ipynb` — namespaces y regla LEGB. **Core.**
4. `04_teoria_lambda_map_filter.ipynb` — `lambda`, `map()`, `filter()`. **Core.**
5. `05_teoria_decoradores_bonus.ipynb` — decoradores simples, `functools.wraps`, `@timer`/`@debug`. **Opcional / bonus.**
6. `06_teoria_functools_bonus.ipynb` — `lru_cache`, `partial`, `reduce`. **Opcional / bonus.**
7. `07_ejercicios.ipynb` — seis ejercicios de dificultad creciente sobre el bloque core.
8. `08_soluciones.ipynb` — soluciones comentadas (no la abras antes de intentar los ejercicios).

## Temporización orientativa

| Bloque | Duración | ¿Core u opcional? |
|---|---|---|
| `01_teoria_funciones_basicas.ipynb` | 100 min | Core |
| `02_teoria_args_kwargs.ipynb` | 60 min | Core |
| `03_teoria_scope_namespaces.ipynb` | 45 min | Core |
| `04_teoria_lambda_map_filter.ipynb` | 45 min | Core |
| `05_teoria_decoradores_bonus.ipynb` | 45-60 min | **Opcional / bonus** |
| `06_teoria_functools_bonus.ipynb` | 30-40 min | **Opcional / bonus** |
| `07_ejercicios.ipynb` + puesta en común | 60-75 min | Core |

Total del bloque core (sin decoradores/`functools`): aproximadamente una jornada completa (5-5.5 horas). Si el grupo va bien de tiempo, `05` y `06` se pueden impartir tal cual, en ese orden, entre `04` y `07`. **Si el grupo va justo, sáltate `05` y `06` sin remordimiento**: no forman parte del contenido obligatorio de la Unidad 4 según el programa, y los ejercicios de `07_ejercicios.ipynb` no dependen de ellos en ningún momento — el Ejercicio 6 (refactorización) reutiliza únicamente lo visto en `01`.

## Requisitos previos

Día 3 (control de flujo) y Día 2 (fundamentos: números, strings, listas, diccionarios, tuplas). No hace falta nada nuevo del entorno más allá de lo instalado en `docs/guia_alumno_setup.md`.
