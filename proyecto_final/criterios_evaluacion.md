# Criterios de evaluación

El proyecto final es **opcional** (ver `README.md`) y no tiene una nota oficial del curso. Estos criterios sirven para autoevaluarse, para que un compañero o el profesorado lo revise si se comparte, y sobre todo como guía de qué mirar antes de dar el trabajo por terminado — el mismo tipo de checklist que aplicaríais antes de presentar un modelo real ante un comité de riesgos.

Deliberadamente, **la métrica del modelo es solo uno de seis bloques**, y no el más importante. Un modelo con una métrica mediocre pero bien razonado, bien documentado y con sus limitaciones claras es mejor trabajo que un modelo con la mejor métrica posible y ninguna justificación de por qué se ha llegado a él.

## 1. Calidad del EDA

- ¿Se ha explorado la distribución de las variables clave (`anulada`, y al menos las que `data/generators/README.md` señala como relevantes: forma de pago, impago previo, siniestralidad, antigüedad de la póliza) antes de modelar, o se ha ido directo al modelo?
- ¿Se han detectado y comentado explícitamente el desbalanceo de clases, los nulos de `potencia_cv` y el outlier de `prima_anual` — o han pasado desapercibidos?
- ¿El EDA informa decisiones posteriores (qué variables incluir, cómo tratar el outlier), o es una serie de gráficos sin conexión con el resto del proyecto?

## 2. Tratamiento de nulos y outliers

- ¿La estrategia de imputación (media, mediana, u otra) está justificada, no solo aplicada por defecto?
- ¿El outlier de `prima_anual` se ha tratado de alguna forma explícita (winsorización, escalador robusto, exclusión justificada...) en vez de ignorarlo o dejar que distorsione silenciosamente un modelo sensible a la escala?
- ¿La imputación y cualquier otro paso que "aprenda" de los datos está dentro de un `Pipeline`/`ColumnTransformer` ajustado solo con el conjunto de entrenamiento (sin fuga de datos), como se trabaja en `dia_10_ml_y_proyecto/02_teoria_pipelines_riesgos_ml.ipynb`?

## 3. Justificación de decisiones de modelización

- ¿Por qué ese modelo (o esos modelos) y no otro? No hace falta justificar matemáticamente cada elección, pero sí razonarla mínimamente.
- ¿Cómo se ha tratado el desbalanceo de clases (`class_weight`, umbral de decisión, u otra estrategia dentro del alcance de scikit-learn puro; el curso no usa `imblearn`/SMOTE)?
- Si se ha hecho búsqueda de hiperparámetros, ¿está hecha sobre el `Pipeline` completo (evitando fuga de datos en la validación cruzada), como en la teoría del Día 10?

## 4. Métricas y su interpretación de negocio

- ¿Se reportan métricas apropiadas para un problema desbalanceado (precision, recall, f1, matriz de confusión), no solo accuracy?
- ¿La matriz de confusión se interpreta en términos de negocio — qué significa un falso positivo (contactar a quien no iba a anular) y un falso negativo (no actuar sobre quien sí se va) en este contexto concreto, y qué balance entre ambos tiene más sentido para la aseguradora?
- ¿Se ha comparado el rendimiento en entrenamiento y en test (o validación cruzada), como señal de sobreajuste?

## 5. Interpretación de negocio y limitaciones

- ¿Qué variables pesan más en el modelo, y tiene sentido de negocio ese resultado (coincide, a grandes rasgos, con la señal documentada en `data/generators/README.md`: impago previo, siniestralidad, forma de pago, antigüedad)?
- ¿Se documentan explícitamente los riesgos del modelo — sobreajuste, leakage, variables mal definidas, sesgos — aplicados a las decisiones concretas tomadas en el proyecto (no solo repetidos en abstracto desde la teoría)?
- ¿Se dice claramente qué **no** puede afirmar este modelo (p. ej. "predice riesgo de anulación, no la causa", o "entrenado sobre datos sintéticos, no transferible sin más a una cartera real")?

## 6. Uso criterioso de la IA, documentado

- ¿Queda constancia de en qué fases se ha usado un asistente de IA (ver `guion_uso_claude_code.md`) y con qué prompts, al menos a grandes rasgos?
- ¿Se explica, para al menos una interacción relevante, qué se ha verificado antes de aceptar el resultado — no solo que "se ha usado IA", sino cómo se ha comprobado que lo que ha devuelto era correcto?
- ¿Hay algún ejemplo (aunque sea menor) de algo que la IA haya propuesto y que se haya corregido o descartado con criterio propio? Es una señal más fuerte de uso crítico que "todo lo que sugirió funcionó a la primera".

## Lo que no se evalúa

- La métrica final del modelo, aislada de todo lo anterior. Un `f1` de 0.25 bien razonado y bien documentado vale más, para este ejercicio, que un `f1` de 0.40 sin ninguna explicación de cómo se ha llegado a él.
- La cantidad de código o de gráficos. Un EDA de cuatro gráficos bien elegidos y bien interpretados es mejor que veinte gráficos sin comentario.
- Usar exactamente la misma estructura que `notebooks/00_proyecto_anulacion_polizas.ipynb` — es un punto de partida, no una plantilla obligatoria.
