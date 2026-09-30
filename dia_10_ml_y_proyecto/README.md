# Día 10 — ML aplicado y actuarial-financiero cuantitativo

**Unidades del programa:** Unidad 11 (ML aplicado) y Unidad 12 (actuarial-financiero cuantitativo). Último día del curso.

## Objetivos del día

- Ajustar y evaluar modelos de regresión y clasificación con scikit-learn: `LinearRegression`, `PolynomialFeatures`, `Pipeline`, `ColumnTransformer`, `LogisticRegression`, `RandomForestClassifier`.
- Interpretar métricas de clasificación (accuracy, precision, recall, matriz de confusión) en términos de negocio, no solo estadísticos.
- Reconocer y evitar los riesgos principales del ML aplicado: sobreajuste, fuga de datos (*data leakage*), variables mal definidas y sesgos.
- Implementar en Python (NumPy/SciPy/pandas, sin librerías adicionales) los cuatro bloques de cálculo actuarial-financiero cuantitativo del programa: rentas, valoración estocástica de opciones, cópulas y provisiones (Chain Ladder).
- Validar siempre un resultado numérico con un caso de control conocido (fórmula cerrada, caso límite, patrón sintético) antes de darlo por bueno — el mismo criterio tanto si el código lo has escrito tú como si te ha ayudado una IA.
- Conocer el proyecto final opcional del curso y cómo usar Claude Code a lo largo de sus distintas fases.

## Orden de los notebooks

1. `01_teoria_regresion_lineal.ipynb` — regresión simple/múltiple/polinómica, $R^2$, overfitting/underfitting.
2. `02_teoria_pipelines_riesgos_ml.ipynb` — `ColumnTransformer`/`Pipeline`, clasificación de anulación de pólizas (`data/raw/polizas_auto_anulacion.csv`), métricas de negocio, `RandomizedSearchCV`, y la sección central del día: riesgos del ML aplicado (sobreajuste, leakage, variables mal definidas, sesgos), con el bloque de IA de la Unidad 11 (explicar un pipeline, revisar código con leakage a propósito).
3. `03_ejemplo_aplicado_prudential.ipynb` — segundo caso aplicado de clasificación en seguros: riesgo de suscripción de vida, dataset público de Kaggle (Prudential Life Insurance Assessment). Incluye nota explícita de que no es un dato real de ninguna aseguradora del curso.
4. `04_teoria_rentas.ipynb` — valor actual de una renta constante, temporal, creciente y perpetua, con NumPy.
5. `05_teoria_opciones_montecarlo.ipynb` — simulación Monte Carlo (browniano geométrico) de una opción europea, validada contra la fórmula cerrada de Black-Scholes.
6. `06_teoria_copulas.ipynb` — cópula gaussiana implementada a mano (`numpy.random.multivariate_normal` + `scipy.stats.norm.cdf`), aplicada a severidades correlacionadas de dos ramos de negocio.
7. `07_teoria_provisiones_chain_ladder.ipynb` — método Chain Ladder sobre un triángulo de siniestralidad construido a mano.
8. `08_ejercicios.ipynb` — dos ejercicios de ML aplicado (Unidad 11) y dos de actuarial-financiero (renta y Chain Ladder, Unidad 12).
9. `09_soluciones.ipynb` — soluciones comentadas (no la abras antes de intentar los ejercicios).

Los notebooks `01`-`03` usan datasets de `../data/raw/` (rutas relativas: ejecuta cada notebook con el directorio de trabajo situado en `dia_10_ml_y_proyecto/`). `03_ejemplo_aplicado_prudential.ipynb` usa además `data/shortset/train.csv`, incluido dentro de este mismo directorio (subconjunto ya reducido del dataset público de Kaggle).

## Temporización orientativa

| Bloque | Duración |
|---|---|
| `01_teoria_regresion_lineal.ipynb` | 60-75 min |
| `02_teoria_pipelines_riesgos_ml.ipynb` | 120-150 min (bloque central del día) |
| `03_ejemplo_aplicado_prudential.ipynb` | 60-75 min |
| `04_teoria_rentas.ipynb` | 45-60 min |
| `05_teoria_opciones_montecarlo.ipynb` | 45-60 min |
| `06_teoria_copulas.ipynb` | 45-60 min |
| `07_teoria_provisiones_chain_ladder.ipynb` | 45-60 min |
| `08_ejercicios.ipynb` + puesta en común | 90-120 min |

Total orientativo: una jornada completa y densa — es el día que cierra el curso y el que tiene más contenido nuevo (toda la Unidad 12 se ha escrito desde cero). Si el grupo va justo de tiempo, el primer candidato a recortar es `03_ejemplo_aplicado_prudential.ipynb` (es un segundo ejemplo aplicado, no contenido nuevo de la Unidad 11) — nunca la sección de riesgos de `02_teoria_pipelines_riesgos_ml.ipynb` ni ningún bloque de la Unidad 12.

## Requisitos previos

Día 7-8 (pandas, NumPy, visualización) y Día 9 (estadística, correlación). No hace falta haber usado scikit-learn ni haber programado ningún cálculo actuarial-financiero antes — es la primera vez que aparece cada uno en el curso.

## El proyecto final opcional

El día se cierra con el **proyecto final opcional** del curso: un modelo de anulación de pólizas de auto, usando el mismo dataset (`data/raw/polizas_auto_anulacion.csv`) y el mismo problema de negocio que `02_teoria_pipelines_riesgos_ml.ipynb`, pero abierto — sin solución dada — para que cada alumno o grupo lo desarrolle a su ritmo tras el curso.

Todo el contenido del proyecto final (enunciado, estructura de partida, criterios de evaluación, guion de uso de Claude Code) vive en `proyecto_final/`, **en la raíz del repositorio**, no en esta carpeta — así queda claro que es un entregable aparte del programa de los 10 días, no un notebook más del Día 10.

## Cierre del curso: cómo seguir aprendiendo Python de forma autónoma

El programa oficial cierra con tres bloques: cómo seguir aprendiendo Python por cuenta propia, cómo usar IA de forma rigurosa y segura, y los límites de los LLM en programación/análisis de datos/modelización actuarial. Los dos últimos están desarrollados en detalle en `docs/uso_ia_en_el_curso.md` — repásalo como cierre. El primero, para este grupo concreto:

- **El proyecto final es el mejor "siguiente paso"**: aplicar de principio a fin, sin red de seguridad, lo aprendido en los 10 días. Si solo hay tiempo para una cosa después del curso, es esa.
- **Lee código de otros antes que tutoriales nuevos.** Con el nivel alcanzado (pandas, POO, tests, Git), la fuente de aprendizaje más rentable a partir de aquí es código real: los propios notebooks de este curso, paquetes de Python que ya usáis en Excel-a-Python (`pandas`, `scikit-learn`) tienen documentación oficial muy trabajada — es mejor referencia que un tutorial genérico.
- **La documentación oficial de una librería es casi siempre mejor que un blog de terceros** para resolver una duda concreta (empezad ahí antes que en un buscador), y es un buen sitio para pedirle a Claude Code que os la resuma o la contraste, aplicando lo visto en el Día 1.
- **PEP 8 y `pytest` no se dejan de usar después del curso**: son el estándar mínimo esperado en cualquier código Python profesional a partir de ahora, no una formalidad del Día 6.
- **Practicad con vuestros propios datos de trabajo** (siempre sintéticos o anonimizados si no es información vuestra) en cuanto podáis — la distancia entre "lo entiendo en el ejercicio del curso" y "lo aplico a mi problema real" solo se cierra haciéndolo.
- Los `README.md` de cada día de este repositorio están pensados para servir de referencia rápida después del curso: si no os acordáis de cómo se hacía algo, es más rápido volver aquí que buscar desde cero.
