# Curso de Python — Colegio de Actuarios de Cataluña

Material del curso de Python para profesionales del ámbito actuarial: 10 días, 12 unidades, con
Claude Code como herramienta de trabajo a lo largo de todo el curso. Todos los datos son
**sintéticos**: no hay ningún dato real de pólizas, siniestros ni clientes.

## Antes del primer día

1. Sigue `docs/guia_instalacion.pdf` (o `docs/guia_alumno_setup.md`) para instalar Python, el entorno virtual, el editor, Jupyter,
   Git y Claude Code, y comprueba el checklist final.
2. Lee `docs/uso_ia_en_el_curso.md`: explica cómo se usa la IA en el curso y qué no debe hacerse.
3. Si lo tienes, echa un vistazo a `docs/manual_alumno.pdf`.

Opción rápida: en Windows, doble clic en `instalar_entorno.bat`; en Mac, `bash instalar_entorno.sh` desde
Terminal. Instalan lo que falte (Python, Git, VS Code, Claude Code y las librerías) y terminan con el checklist.

Si no llegas a terminar la instalación antes de la primera sesión, la veremos paso a paso en ella.
Resumen de los comandos manuales, desde esta carpeta:

```powershell
python -m venv .venv
.venv\Scripts\activate
pip install -r requirements.txt
```

## Estructura

| Día | Carpeta | Unidades | Contenido |
|---|---|---|---|
| 1 | [`dia_01_entorno_e_ia/`](dia_01_entorno_e_ia/) | 1 | Entorno de trabajo en Windows y primera sesión con Claude Code |
| 2 | [`dia_02_fundamentos/`](dia_02_fundamentos/) | 2 | Variables, tipos, strings, listas, diccionarios, tuplas, archivos |
| 3 | [`dia_03_control_de_flujo/`](dia_03_control_de_flujo/) | 3 | Condicionales, bucles, comprehensions, lectura de errores |
| 4 | [`dia_04_funciones/`](dia_04_funciones/) | 4 | Funciones, *args/**kwargs, scope, lambda, typing |
| 5 | [`dia_05_poo/`](dia_05_poo/) | 5 | Clases, herencia, properties, dataclasses, revisión crítica de código |
| 6 | [`dia_06_codigo_profesional/`](dia_06_codigo_profesional/) | 6 | Módulos, PEP 8, excepciones, logging, pytest, Git y GitHub |
| 7 | [`dia_07_pandas_numpy/`](dia_07_pandas_numpy/) | 7 | NumPy, Series y DataFrames, filtrado, nulos y duplicados |
| 8 | [`dia_08_pandas_avanzado_visualizacion/`](dia_08_pandas_avanzado_visualizacion/) | 7, 8 | groupby, merge, pivot_table, Matplotlib y seaborn |
| 9 | [`dia_09_datos_y_estadistica/`](dia_09_datos_y_estadistica/) | 9, 10 | Bases de datos, APIs REST, estadística con SciPy |
| 10 | [`dia_10_ml_y_proyecto/`](dia_10_ml_y_proyecto/) | 11, 12 | scikit-learn, rentas, opciones, cópulas, Chain Ladder |

Cada día tiene su `README.md` con los objetivos y el orden de los notebooks. La teoría, los
ejercicios y las soluciones están siempre en notebooks separados.

- `data/raw/` — datasets sintéticos que usan los notebooks (no los edites a mano).
- `data/generators/` — scripts que generan esos datasets.
- `proyecto_final/` — proyecto final opcional: modelo de anulación de pólizas de auto.
- `docs/` — guía de instalación, política de uso de IA y chuletas (Git, Excel → pandas).
- `docs/manual_alumno.pdf` — manual del alumno: todo el temario unidad por unidad, con código, problemas típicos y autoevaluación.

> El ejemplo `dia_10_ml_y_proyecto/03_ejemplo_aplicado_prudential.ipynb` usa un dataset público de Kaggle que no se distribuye con el repositorio. Consulta `dia_10_ml_y_proyecto/data/shortset/LEEME.md`.

## Soluciones

Las soluciones de cada día se publican **al terminar ese día**. Para recibirlas, ejecuta `git pull` dentro de la carpeta del curso.

Antes de hacer `git pull`, guarda tu trabajo con un commit (`git add .` y `git commit -m "Mi trabajo"`)
para que no se mezcle con las actualizaciones.

## Cómo trabajar cada día

Antes de cada sesión, abre VS Code en esta carpeta, guarda tu trabajo con un commit, ejecuta `git pull`
y comprueba que el kernel es `.venv`. Si algo falla durante una sesión, pega el mensaje de error
completo **como texto** en el chat.

Para abrir los notebooks: doble clic en `abrir_jupyter.bat` (en Mac, `bash abrir_jupyter.sh` en Terminal).
Se abre Jupyter en el navegador, ya con el entorno del curso. VS Code lo usaremos sobre todo a partir del Día 6.

1. Abre los notebooks de teoría en orden y ejecuta cada celda. En los bloques «Error típico»,
   intenta predecir qué va a pasar antes de ejecutar.
2. Haz los ejercicios sin mirar las soluciones.
3. Cuando algo no cuadre, usa **Kernel → Restart Kernel and Run All Cells**.
