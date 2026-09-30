# Uso de IA en el curso

Este documento fija la política de uso de asistentes de código (Claude Code y similares) durante el curso, y los límites que como colegiados debéis tener presentes cuando uséis estas herramientas en vuestro trabajo profesional real, no solo en clase.

## Principio de fondo

La IA generativa se enseña como **herramienta de trabajo sujeta a criterio profesional**, nunca como un atajo para no entender el código. En cada unidad, el bloque de IA existe para reforzar lo que se acaba de aprender —explicarlo con otras palabras, encontrarle el fallo, acelerar una parte mecánica— no para saltárselo. Si en algún ejercicio la tentación es "pedirle a la IA que lo haga y copiar la respuesta sin leerla", ese ejercicio se ha hecho mal, sea cual sea el resultado.

Para un colectivo colegiado, con responsabilidad profesional sobre los modelos y cálculos que firma, esto no es una cuestión de estilo pedagógico: es el mismo estándar de diligencia debida que ya aplicáis a una hoja de cálculo o a un modelo actuarial de un proveedor externo. No firmaríais una valoración porque "el Excel lo ha calculado así" sin entender la fórmula; el mismo criterio aplica a código escrito con ayuda de un LLM.

## Qué está permitido en los ejercicios del curso

- Usar Claude Code (o el asistente que prefiráis) para explicar conceptos, interpretar mensajes de error, sugerir refactorizaciones, generar tests o documentación, y como apoyo puntual en los bloques de IA marcados en cada notebook.
- Pedir ayuda para desatascar un ejercicio cuando llevéis un rato razonable intentándolo solos. El objetivo es aprender Python, no demostrar que podéis hacerlo sin ayuda de nada.
- Usar la IA para acelerar partes mecánicas ya dominadas (boilerplate, nombres de argumentos de una función que ya sabéis usar) mientras dedicáis el esfuerzo propio a la parte nueva del ejercicio.

## Qué no está permitido

- Copiar y pegar la solución generada por la IA en un ejercicio de evaluación sin haberla leído, entendido y sido capaz de explicarla.
- Usar la IA para generar el ejercicio de "revisión crítica de código" (unidad 5) antes de haber intentado encontrar el fallo por cuenta propia: ese ejercicio pierde su sentido si se resuelve preguntándole a otra IA.
- Introducir datos sensibles o confidenciales —pólizas reales, datos de asegurados, información de clientes o de la aseguradora— en un prompt, dentro o fuera del curso. Todos los datos del curso son sintéticos precisamente para poder practicar esto sin ese riesgo; en vuestro trabajo real, tratad cualquier asistente de IA en la nube como un tercero externo al que no le enviaríais esa información sin las garantías contractuales y de protección de datos correspondientes.

## Confidencialidad y protección de datos

- Nunca peguéis en un prompt datos personales, información de clientes o de pólizas reales, ni credenciales (contraseñas, tokens de API, claves de conexión a bases de datos).
- Las credenciales y variables sensibles se gestionan siempre mediante variables de entorno (unidad 9), nunca escritas directamente en el código ni en un prompt.
- Antes de pegar un fragmento de código real de vuestra empresa en cualquier asistente de IA externo, comprobad la política de vuestra organización al respecto. Lo que vale para el entorno controlado del curso no vale automáticamente para el entorno de producción.

## Límites de los LLM que debéis tener presentes

- **Alucinaciones**: un LLM puede generar código sintácticamente correcto que llama a una función que no existe, usa un argumento con un nombre inventado, o afirma un resultado numérico que no ha calculado realmente. Se pide siempre validar la salida, no solo leerla.
- **En programación**: el código generado puede ejecutarse sin error y aun así no calcular lo que le habéis pedido (el fallo sutil de la unidad 5 es exactamente esto). Nunca deis por bueno un resultado solo porque "compila" o "no da error".
- **En análisis de datos**: una transformación de pandas puede aplicarse a una columna equivocada, silenciar nulos sin avisar, o cambiar el tipo de dato sin que lo notéis. Validad siempre con datos de control conocidos (cuadrar totales, comprobar tamaños de muestra, revisar tipos).
- **En modelización actuarial y financiera**: un LLM no tiene criterio actuarial. Puede describir correctamente qué es una cópula o cómo se plantea una provisión, pero no sabe si el supuesto que estáis usando es razonable para vuestra cartera, ni sustituye el juicio profesional exigido por la normativa que os aplica. Usadlo para acelerar la parte de código (implementar el cálculo una vez decidido el método), nunca para que decida el método o valide el resultado en vuestro lugar.

## Cómo se aplica esto en el curso

Cada bloque de IA en un notebook incluye tres cosas: el **prompt sugerido** (para copiar y adaptar), **qué se espera obtener**, y **qué debéis verificar antes de darlo por bueno**. Ese tercer punto no es opcional: es la parte que realmente se evalúa. Un prompt sin criterio de validación no es un ejercicio completo.
