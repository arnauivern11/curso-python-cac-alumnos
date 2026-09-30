# CLAUDE.md

Contexto para trabajar con Claude Code en este repositorio. Los alumnos del curso lo verán como ejemplo real de un `CLAUDE.md` bien escrito (unidad 1), así que se mantiene deliberadamente claro y corto.

## Qué es este repositorio

Material del curso de Python del Colegio de Actuarios de Cataluña (CAC). Alumnado: profesionales con nivel alto de estadística, probabilidad y modelización actuarial-financiera, y nivel básico o nulo de Python. El curso dura 10 días y cubre 12 unidades formativas, con Claude Code integrado como herramienta transversal (nunca como sustituto de entender el código).

## Estructura

```
docs/                         Documentación del curso (guía de instalación, política de IA, cheatsheets, manual del alumno)
dia_01_entorno_e_ia/ ... dia_10_ml_y_proyecto/
                               Un directorio por día de curso
  README.md                   Objetivos, unidades cubiertas, orden de notebooks, temporización
  01_teoria_*.ipynb           Teoría (una o varias, numeradas)
  NN_ejercicios.ipynb         Ejercicios del día (sin soluciones)
  NN_soluciones.ipynb         Soluciones comentadas
data/raw/                     Datasets sintéticos ya generados (los que usan los notebooks)
data/generators/              Scripts reproducibles que generan los datasets sintéticos
proyecto_final/                Proyecto final opcional (modelo de anulación de pólizas de auto)
```

## Convenciones

- **Idioma**: el material (markdown, enunciados, explicaciones) va en castellano. El código —variables, funciones, clases, comentarios de código— va en inglés, como es estándar profesional.
- **Notebooks**: teoría, ejercicios y soluciones siempre en archivos separados. Cada notebook de teoría empieza con una celda de cabecera (día, unidad, objetivos, duración estimada, requisitos previos) y alterna celdas markdown explicativas con celdas de código comentadas, nunca bloques largos de código sin contexto.
- **Datos**: no hay datos reales de pólizas, siniestros ni clientes. Todo dataset es sintético, generado por un script en `data/generators/` y documentado como tal. Si necesitas un ejemplo con "cara" de dato real, genera uno sintético nuevo o amplía un generador existente; no inventes cifras sueltas dentro de un notebook si el patrón ya existe en `data/generators/`.
- **Ejemplos**: siempre con contexto actuarial-financiero cuando sea razonable (carteras de pólizas, siniestralidad, primas, provisiones, amortizaciones) en vez de ejemplos genéricos sin dominio.
- **Estilo de código**: PEP 8, tipado (`typing`) donde aporte claridad, funciones con docstrings a partir de la unidad 4.

## Qué no tocar sin motivo

- Los datasets en `data/raw/` no se editan a mano: si hace falta cambiarlos, se cambia su generador en `data/generators/` y se regenera.

## Entorno

- Windows, Python gestionado con `requirements.txt` en la raíz (versiones fijadas).
- Todo notebook debe ejecutarse de principio a fin sin errores con las dependencias fijadas en `requirements.txt`.
- Antes de commitear, los notebooks de ejercicios deben tener los outputs limpios (`nbstripout` está configurado vía `.gitattributes`).

## Validación antes de dar por bueno un cambio

- Ejecutar el notebook afectado de principio a fin en un kernel limpio.
- Si toca código en `data/generators/` o en paquetes de ejemplo, ejecutar los tests con `pytest` si existen.
- Revisar que no se han introducido rutas absolutas ni dependencias de archivos fuera del repo.
