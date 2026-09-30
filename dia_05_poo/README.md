# Día 5 — Programación orientada a objetos aplicada

**Unidad del programa:** Unidad 5.

## Objetivos del día

- Definir clases con atributos de instancia y de clase, y distinguir cuándo usar cada uno.
- Escribir métodos de instancia, métodos de clase (`@classmethod`) y métodos dunder básicos (`__repr__`, `__eq__`, `__lt__`, `__len__`).
- Usar `@property`/`@setter` para exponer atributos calculados o validados.
- Aplicar herencia básica entre clases, usando `super().__init__()` correctamente.
- Usar `dataclasses` y `Enum` para clases centradas en datos con valores restringidos.
- Revisar críticamente un fragmento de código con un fallo sutil de lógica (no una excepción) y saber detectarlo sin recurrir a otro asistente de IA.

## Orden de los notebooks

1. `01_teoria_clases_atributos_metodos.ipynb` — qué es la POO, clases vs. instancias, atributos de instancia/clase, métodos de instancia, métodos de clase (`@classmethod`) y métodos dunder básicos.
2. `02_teoria_properties_herencia.ipynb` — `@property`/`@setter`, herencia básica (`super().__init__()`), anti-patrones, y el bloque de IA del día: revisión crítica guiada de un fallo sutil (con solución explicada).
3. `03_teoria_dataclasses_enum.ipynb` — `dataclasses`, el error del valor por defecto mutable, `Enum`, y un bloque opcional/bonus de magic methods avanzados y la idea general de patrón de diseño.
4. `04_ejercicios.ipynb` — cuatro ejercicios de dificultad creciente, incluido un segundo "encuentra el fallo sutil" distinto al de la teoría.
5. `05_soluciones.ipynb` — soluciones comentadas, con la explicación completa del fallo del Ejercicio 4 (no la abras antes de intentar los ejercicios).

## Temporización orientativa

| Bloque | Duración |
|---|---|
| `01_teoria_clases_atributos_metodos.ipynb` | 75-90 min |
| `02_teoria_properties_herencia.ipynb` | 75-90 min |
| `03_teoria_dataclasses_enum.ipynb` (sección 1-2, obligatoria) | 45-60 min |
| `03_teoria_dataclasses_enum.ipynb` (sección 3, opcional/bonus) | 20-30 min — **solo si sobra tiempo** |
| `04_ejercicios.ipynb` + puesta en común | 90-120 min |

Total orientativo: una jornada completa. La sección 3 de `03_teoria_dataclasses_enum.ipynb` (magic methods avanzados y patrones de diseño) es explícitamente opcional: el programa la marca como "solo introductoria si el ritmo lo permite", así que si el grupo va justo de tiempo, se salta sin que afecte al resto del día ni a los ejercicios.

## Requisitos previos

Día 4 (funciones, `*args`/`**kwargs`, docstrings, typing). El bloque de IA de este día da por hecho que el alumnado ya sabe leer y ejecutar un notebook con soltura (Día 1) y que conoce la política de uso de IA del curso (`docs/uso_ia_en_el_curso.md`).
