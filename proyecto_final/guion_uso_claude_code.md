# Guion de uso de Claude Code a lo largo del proyecto final

Este documento es el bloque de IA de la Unidad 12, en su forma extendida: en vez de un prompt puntual dentro de un notebook, aquí se recorre el proyecto completo fase a fase, con ejemplos de prompt concretos para cada una. Sigue la misma política que el resto del curso — ver `docs/uso_ia_en_el_curso.md` — y el mismo formato de siempre: **prompt sugerido, qué esperar, qué verificar**. Esa tercera parte no es opcional en ninguna fase: es la que convierte "le pedí a la IA que lo hiciera" en un ejercicio de criterio profesional.

## 0. Antes de empezar: qué NO delegar

Ninguna fase de abajo sustituye entender el dataset ni el problema de negocio. Si en algún punto te encuentras aceptando una celda de código o una conclusión sin poder explicarla con tus propias palabras, para y vuelve atrás — es exactamente la señal de alarma de la que avisa `docs/uso_ia_en_el_curso.md`.

También recuerda: aunque `data/raw/polizas_auto_anulacion.csv` es sintético, practica aquí como si no lo fuera — nunca seríais los primeros en pegar en un prompt una cartera real sin anonimizar. Es el mismo hábito que os tiene que quedar para vuestro trabajo real fuera del curso.

## 1. Explorar el dataset

Al principio, antes de escribir código, es más rápido pedirle a Claude Code que explore el dataset y te oriente que empezar a escribir celdas a ciegas.

**Prompt sugerido:**
> "Lee `data/generators/README.md` y describe el esquema de `polizas_auto_anulacion.csv`: qué columnas hay, cuáles tienen incidencias de calidad de datos a propósito, y cuál es la variable objetivo. No generes código todavía, solo un resumen."

**Qué esperar:** un resumen fiel del propio `README.md` — columnas, tipos, y la nota de que `potencia_cv` tiene nulos y `prima_anual` tiene un outlier, ambos a propósito.

**Qué verificar:** abre tú mismo `data/generators/README.md` y compáralo con el resumen. Es una comprobación rápida (dos minutos) que evita arrastrar un malentendido sobre el dataset durante el resto del proyecto — por ejemplo, si la IA se inventa una columna que no existe o describe mal el significado de `forma_pago`.

## 2. Generar hipótesis de EDA

Una vez cargado el dataset en un DataFrame, pedir hipótesis de qué mirar es más productivo que pedir "haz un EDA completo" — porque las hipótesis las puedes contrastar tú, mientras que un EDA genérico tiende a producir gráficos sin conexión entre sí.

**Prompt sugerido:**
> "Contexto: tengo el DataFrame `polizas` cargado desde `polizas_auto_anulacion.csv`, con variable objetivo `anulada`. Según `data/generators/README.md`, sé que el pago mensual, el impago previo, la siniestralidad alta y la antigüedad baja aumentan la probabilidad de anulación. Dame 4-5 hipótesis concretas y contrastables sobre relaciones entre variables y `anulada` que debería comprobar con un gráfico o una tabla antes de modelar, priorizando las que no son obvias solo con leer el README."

**Qué esperar:** una lista de hipótesis, cada una ligada a una comprobación concreta (p. ej. "compara la tasa de anulación por `forma_pago`, tabla de contingencia" en vez de "explora `forma_pago`").

**Qué verificar:** que cada hipótesis sea efectivamente contrastable con el dataset que tienes (no con columnas que no existen), y que las que tengan una respuesta "obvia" desde el propio README no ocupen las 4-5 hipótesis — pide que profundice si el listado se queda en lo evidente. La conclusión de cada contraste (si la variable importa o no, y cuánto) es tuya, no de la IA: ella puede sugerir qué mirar, no interpretar el resultado por ti.

## 3. Depurar errores

Cuando algo falle (una excepción, o un resultado que "se ejecuta pero no cuadra"), pega el error completo o el síntoma exacto, no un resumen tuyo — ya lo practicasteis en el Día 1 (`dia_01_entorno_e_ia/02_teoria_introduccion_ia_claude_code.ipynb`).

**Prompt sugerido (excepción):**
> "Al ejecutar `preprocesador.fit_transform(X_train)` me sale este error: `ValueError: Input contains NaN`. Aquí está mi `ColumnTransformer` [pega el código]. Ayúdame a encontrar qué columna sigue teniendo nulos que no estoy imputando, antes de darme la solución ya corregida."

**Prompt sugerido (resultado que no cuadra, sin excepción):**
> "Mi matriz de confusión da 0 verdaderos positivos para la clase `anulada`, aunque el dataset tiene ~11% de pólizas anuladas. El código no lanza ningún error. ¿Qué comprobaciones debería hacer primero (balance de clases tras el split, `class_weight`, umbral de decisión) antes de asumir que el modelo simplemente "no aprende nada"?"

**Qué esperar:** en el primer caso, un diagnóstico de qué columna falta por imputar (verificable con `X_train.isna().sum()`); en el segundo, una lista de causas plausibles a comprobar, no una afirmación categórica de cuál es "la" causa sin haber visto tus datos.

**Qué verificar:** siempre reproduce el diagnóstico con tu propio código antes de aplicar el "arreglo" (p. ej. `X_train[columna].isna().sum()` para confirmar que esa columna concreta es la culpable). Un LLM puede sonar seguro sobre una causa incorrecta — la única forma de saberlo es comprobar, no releer la explicación.

## 4. Refactorizar

Una vez el análisis funciona, es habitual tener código repetido (la misma limpieza copiada en varias celdas, el mismo `ColumnTransformer` reescrito dos veces). Es el momento de pedir refactorización — con un caso de prueba fijado antes, igual que en `dia_04_funciones/01_teoria_funciones_basicas.ipynb`.

**Prompt sugerido:**
> "Contexto: tengo estas tres celdas con lógica de limpieza casi idéntica [pega las celdas]. Objetivo: extráelas a una única función `limpiar_polizas(df)` con docstring estilo Google y type hints, que pueda mover a `src/limpieza.py` y reutilizar. Restricciones: el resultado de aplicar la función debe ser idéntico al de las tres celdas originales para mi DataFrame actual. Formato de salida: la función, más una línea de código para verificar que el resultado no cambia (comparando con `.equals()` o similar)."

**Qué esperar:** una función bien documentada, más el código de verificación pedido explícitamente en el prompt.

**Qué verificar:** ejecuta la verificación tú mismo antes de borrar las celdas originales — no la des por buena solo porque "tiene buena pinta". Si vas a mover la función a `src/`, comprueba también que el `import` funciona desde el notebook (rutas relativas, `sys.path`) antes de depender de ella en el resto del proyecto.

## 5. Documentar

Para el resumen ejecutivo o las conclusiones de negocio, la IA puede ayudar a estructurar y redactar — nunca a decidir la conclusión.

**Prompt sugerido:**
> "Contexto: he entrenado un `RandomForestClassifier` con `class_weight='balanced'` sobre `polizas_auto_anulacion.csv`. En test obtengo precision=0.18, recall=0.55, f1=0.27. Las variables más importantes son `recibo_impagado_alguna_vez`, `num_siniestros_3_anios` y `forma_pago`. Objetivo: redáctame un borrador de 3-4 párrafos de conclusiones de negocio para alguien que no ha visto el notebook (un responsable comercial), explicando qué hace el modelo, qué tan fiable es (en términos de negocio, no solo la métrica), y qué limitaciones tiene. Restricciones: no inventes ninguna cifra que no te haya dado yo."

**Qué esperar:** un borrador razonable, en lenguaje de negocio, sin jerga de ML innecesaria.

**Qué verificar:** que ninguna cifra del borrador sea distinta de las que diste en el prompt (la restricción explícita ayuda, pero no lo garantiza — compruébalo tú), y que las limitaciones mencionadas sean las reales de tu modelo concreto, no una lista genérica de "limitaciones típicas del ML" que no aplican a tu caso.

## 6. Generar tests (si tu proyecto usa `src/`)

Si has extraído funciones a `src/` (fase 4), tiene sentido darles un test mínimo con `pytest`, como en el Día 6.

**Prompt sugerido:**
> "Contexto: tengo esta función en `src/limpieza.py` [pega la función `limpiar_polizas`]. Objetivo: escríbeme 2-3 tests con pytest que comprueben el comportamiento importante (que se imputan los nulos de `potencia_cv`, que no se pierden filas, que el outlier de `prima_anual` se trata como se espera). Formato de salida: un archivo `test_limpieza.py` con las funciones de test, sin fixtures complejas."

**Qué esperar:** tests concretos sobre el comportamiento real de tu función, no tests genéricos que pasarían con cualquier implementación.

**Qué verificar:** ejecuta los tests (`pytest src/`) y comprueba que efectivamente fallan si rompes la función a propósito (comenta una línea de la imputación y confirma que el test correspondiente falla) — un test que nunca puede fallar no está verificando nada.

## 7. Revisar el modelo final

Antes de dar el proyecto por cerrado, pide una revisión crítica dirigida específicamente a los cuatro riesgos de `dia_10_ml_y_proyecto/02_teoria_pipelines_riesgos_ml.ipynb`.

**Prompt sugerido:**
> "Contexto: este es mi pipeline final de principio a fin [pega el notebook o las celdas clave: carga, preprocesado, split, modelo, evaluación]. Objetivo: revísalo buscando específicamente estos cuatro riesgos: (1) fuga de datos — cualquier `fit()` ejecutado con información del test; (2) sobreajuste — compara si calculo métricas en train y test; (3) variables mal definidas — alguna columna que no estaría disponible en el momento real de predecir; (4) sesgos — alguna variable que pueda actuar de proxy de algo sensible. Restricciones: para cada riesgo, dime si lo encuentras o no, y por qué — no des una respuesta genérica de "todo estos riesgos existen siempre en ML"."

**Qué esperar:** un veredicto punto por punto sobre tu código concreto, no una lista genérica copiada de la teoría.

**Qué verificar:** exactamente como en `02_teoria_pipelines_riesgos_ml.ipynb` — si la IA señala una fuga, confírmala tú reproduciendo el problema (o demostrando que no existe); si no señala ninguna, revisa tú mismo la lista de los cuatro riesgos igualmente, porque no encontrar un problema no es lo mismo que confirmar que no lo hay. Esta última revisión, hecha con calma y por ti mismo, es la parte del proyecto que más se parece a la responsabilidad profesional real que tendréis firmando un modelo fuera del curso.
