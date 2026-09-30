# Día 6 — Código profesional

**Unidad del programa:** Unidad 6. Es la unidad con más contenido distinto de todo el curso (módulos y paquetes, PEP 8, excepciones, logging, testing con pytest, y Git/GitHub) — por eso este día tiene cinco notebooks de teoría en vez de los dos o tres habituales, y una duración orientativa notablemente mayor que el resto de días.

## Objetivos del día

- Organizar código en módulos y paquetes (`import`, `sys.path`, `__init__.py`, `__all__`) en vez de notebooks sueltos, y aplicar las convenciones de estilo PEP 8.
- Gestionar errores de forma robusta con `try`/`except`/`else`/`finally`, `raise`, `assert`, y excepciones propias.
- Registrar lo que ocurre durante la ejecución con el módulo estándar `logging` (niveles, formato, handlers, guardar en archivo).
- Escribir tests con `pytest`: fixtures, `conftest.py`, marks, parametrización — y usar IA para generar un test, verificando que detecta fallos de verdad.
- Usar Git con soltura: `init`/`add`/`commit`/`status`, staging, `.gitignore`, SHA, ramas (`merge`/`rebase`/`cherry-pick`), revertir cambios, y sincronizar con un remoto (`clone`/`fetch`/`pull`/`push`, Pull Requests).
- Aplicar un checklist propio antes de hacer cualquier commit.

## Orden de los notebooks

1. `01_teoria_modulos_paquetes.ipynb` — módulos, paquetes, `sys.path`, `__name__ == "__main__"`, `__init__.py`/`__all__`, y PEP 8 (nombrado, espaciado, longitud de línea).
2. `02_teoria_excepciones.ipynb` — errores de sintaxis vs. excepciones, `raise`, `assert`, `try`/`except`/`else`/`finally`, excepciones propias.
3. `03_teoria_logging.ipynb` — módulo estándar `logging` (niveles, `basicConfig`, `getLogger`, handlers, guardar en archivo); nota final opcional sobre Loguru.
4. `04_teoria_pytest.ipynb` — progresión completa de pytest (`version_1` a `version_7`: de verificación manual a parametrización), y el bloque de IA de generación de tests.
5. `05_teoria_git_github.ipynb` — Git y GitHub, con una demo real ejecutada en un repositorio temporal desechable; el bloque de IA de este notebook es el checklist antes de hacer commit.
6. `06_ejercicios.ipynb` — ejercicios de los cinco bloques anteriores, incluido un ejercicio de escribir tests de pytest para una función dada.
7. `07_soluciones.ipynb` — soluciones comentadas (no lo abras antes de intentar los ejercicios).

## Material de apoyo en esta carpeta

- `modulo_test.py`, `script_test.py`, `script_test_2.py`, `paquete_test/`, `paquete_test_2/` — soporte de `01_teoria_modulos_paquetes.ipynb`.
- `ejemplo.txt` — soporte de `02_teoria_excepciones.ipynb`.
- `pytest_progresion/` — soporte de `04_teoria_pytest.ipynb`, con una subcarpeta por versión (`version_1_manual` a `version_7`, más `ejercicio_ia`), cada una ejecutable de forma independiente con `pytest`.

`05_teoria_git_github.ipynb` no necesita ningún archivo de apoyo: crea su propio repositorio de demostración en un directorio temporal del sistema (`tempfile`) al principio del notebook y lo borra al final, así que se puede ejecutar tantas veces como haga falta sin dejar rastro ni depender de Poetry ni de una cuenta de GitHub real.

## Temporización orientativa

| Bloque | Duración |
|---|---|
| `01_teoria_modulos_paquetes.ipynb` | 90-105 min |
| `02_teoria_excepciones.ipynb` | 75-90 min |
| `03_teoria_logging.ipynb` | 60-75 min |
| `04_teoria_pytest.ipynb` | 100-120 min |
| `05_teoria_git_github.ipynb` | 120-150 min |
| `06_ejercicios.ipynb` + puesta en común | 90-120 min |

Total orientativo: **dos jornadas completas**, no una — es el día más cargado del curso y el propio programa lo trata como tal. Si el calendario del curso solo asigna un día a la Unidad 6, la partición natural es: día 6a = notebooks 1-3 (módulos, PEP 8, excepciones, logging); día 6b = notebooks 4-7 (pytest, Git/GitHub, ejercicios, soluciones).

## Requisitos previos

Día 4 (funciones) y Día 5 (clases). Necesitas tener `git` instalado y accesible desde la terminal (comprobado en el Día 1, `docs/guia_alumno_setup.md`) para `05_teoria_git_github.ipynb`. El resto de notebooks solo requieren el entorno virtual del curso (`requirements.txt`, que ya incluye `pytest`).
