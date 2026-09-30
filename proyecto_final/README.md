# Proyecto final (opcional) — Modelo de anulación de pólizas de auto

> **Este proyecto es opcional.** No forma parte de los 10 días del programa ni de su evaluación — el programa marca explícitamente esta pieza como ampliación para quien quiera cerrar el curso con un ejercicio de principio a fin, a su propio ritmo, después (o en paralelo, si sobra tiempo) del Día 10. `dia_10_ml_y_proyecto/02_teoria_pipelines_riesgos_ml.ipynb` ya construye, paso a paso y con solución, un modelo sobre el mismo dataset y el mismo problema — repásalo antes de empezar si quieres un punto de partida guiado.

## Contexto de negocio

Una aseguradora de líneas personales quiere anticipar qué pólizas de auto tienen mayor riesgo de anularse, para poder actuar **antes** de que eso ocurra: contactar al cliente, revisar condiciones, ofrecer una alternativa comercial. Hoy esa decisión se toma de forma reactiva (se actúa cuando ya ha llegado el aviso de baja) o con reglas de negocio simples y poco precisas. El objetivo es construir un modelo que priorice, dentro de la cartera activa, qué pólizas conviene revisar primero.

Es el mismo problema de negocio que se trabaja, con solución guiada, en `dia_10_ml_y_proyecto/02_teoria_pipelines_riesgos_ml.ipynb` — la diferencia es que aquí no hay una solución de referencia: el proyecto es abierto, y las decisiones (qué variables usar, qué modelo, cómo tratar el desbalanceo, qué umbral de decisión aplicar) son tuyas, con tu criterio.

## Objetivo del modelo

Construir un modelo de clasificación que, a partir de las características de una póliza de auto, estime la probabilidad de que se anule (`anulada`), y que ese modelo sea **defendible**: que sus decisiones de preprocesado y modelización estén justificadas, que sus métricas se interpreten en términos de negocio (no solo como un número), y que sus limitaciones estén documentadas explícitamente, no escondidas.

No se pide (necesariamente) el modelo con mejor métrica posible. Se pide un trabajo completo, bien razonado y bien comunicado — ver `criterios_evaluacion.md` para el detalle de qué se evalúa.

## El dataset

`data/raw/polizas_auto_anulacion.csv` — 5.000 pólizas de auto, con variable objetivo `anulada`. El esquema completo de columnas (tipos, significado de cada una, y qué incidencias de calidad de datos tiene el dataset **a propósito**: nulos en `potencia_cv`, un outlier en `prima_anual`) está documentado en detalle en [`data/generators/README.md`](../data/generators/README.md) — no se duplica aquí; consúltalo antes de empezar el EDA.

El dataset es sintético (generado con semilla fija, reproducible desde `data/generators/generar_proyecto_final.py`), pero está construido con señal real de negocio: el pago mensual (frente a anual), el impago previo, la siniestralidad alta y la antigüedad baja de la póliza aumentan la probabilidad de anulación, con ruido añadido encima. No es un dato real de ninguna aseguradora ni de ningún asegurado.

## Entregables esperados

1. **Un notebook (o varios) con el análisis completo**, desde la carga de datos hasta las conclusiones. Usa `notebooks/00_proyecto_anulacion_polizas.ipynb` como punto de partida: tiene la estructura típica de un proyecto de ML (secciones en markdown, sin código resuelto) para que no partas de una página en blanco, pero puedes reorganizarla, dividirla en varios notebooks, o cambiarla si tiene sentido para tu enfoque.
2. **EDA documentado**: qué has encontrado en los datos (incluidos los nulos y el outlier a propósito), cómo los has tratado y por qué.
3. **Al menos un modelo entrenado con `Pipeline`/`ColumnTransformer`**, evaluado con métricas de clasificación apropiadas para un problema desbalanceado (no solo accuracy), y su matriz de confusión interpretada en términos de negocio (coste de un falso positivo frente a un falso negativo, en este contexto concreto).
4. **Una sección de limitaciones y riesgos**: qué le pedirías revisar a alguien antes de llevar este modelo a producción (sobreajuste, leakage, variables mal definidas, sesgos — los mismos cuatro riesgos de `dia_10_ml_y_proyecto/02_teoria_pipelines_riesgos_ml.ipynb`, aplicados a tu propio modelo).
5. **Documentación de cómo has usado la IA** a lo largo del proyecto: qué le has pedido, en qué fases, y cómo has verificado lo que te ha devuelto. Ver `guion_uso_claude_code.md` para ejemplos concretos por fase, y `docs/uso_ia_en_el_curso.md` para la política general del curso.

No hay una plantilla obligatoria para el entregable final: puede ser el propio notebook bien documentado, o un notebook más un resumen ejecutivo aparte (markdown o Word) si lo prefieres para la parte de conclusiones de negocio.

## Estructura de partida

```
proyecto_final/
  README.md                        Este archivo — enunciado completo
  criterios_evaluacion.md          Qué se evalúa y cómo
  guion_uso_claude_code.md         Cómo usar Claude Code en cada fase del proyecto
  notebooks/
    00_proyecto_anulacion_polizas.ipynb   Esqueleto sin resolver: EDA, limpieza,
                                            features, modelo, evaluación, conclusiones
  src/
    README.md                      Espacio opcional para funciones reutilizables
```

No hace falta usar `src/` — si tu análisis cabe cómodamente en el notebook, déjalo ahí. Úsalo solo si te encuentras copiando y pegando la misma función (p. ej. una de limpieza, o el `ColumnTransformer`) entre varias celdas o varios notebooks: en ese caso, extraerla a un módulo en `src/` e importarla es más limpio, y es exactamente el tipo de refactor que un asistente de IA hace bien (ver `guion_uso_claude_code.md`, fase de refactorización).

## Por dónde empezar

1. Lee `data/generators/README.md` (esquema del dataset) y `dia_10_ml_y_proyecto/02_teoria_pipelines_riesgos_ml.ipynb` (el mismo problema, resuelto de forma guiada) antes de escribir una sola celda.
2. Abre `notebooks/00_proyecto_anulacion_polizas.ipynb` y sigue sus secciones como guion, o reorganízalas si prefieres otro orden.
3. Lee `criterios_evaluacion.md` para saber qué se va a valorar, y `guion_uso_claude_code.md` si quieres ejemplos concretos de cómo apoyarte en Claude Code en cada fase.
