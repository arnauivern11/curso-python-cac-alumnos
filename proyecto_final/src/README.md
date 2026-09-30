# `src/`

Espacio opcional para código Python reutilizable del proyecto (funciones de limpieza, del `ColumnTransformer`, de evaluación...) que prefieras extraer del notebook en vez de mantener repetido entre celdas.

No es obligatorio usar esta carpeta: si el análisis cabe cómodamente en `notebooks/00_proyecto_anulacion_polizas.ipynb`, no hace falta crear nada aquí. Extrae una función a un módulo (por ejemplo, `src/limpieza.py`) solo cuando te encuentres copiándola y pegándola más de una vez — es la señal habitual de que toca refactorizar (ver la fase 4 de `../guion_uso_claude_code.md`).

Para importar desde un módulo de `src/` en un notebook de `notebooks/`, añade la carpeta al `sys.path` al principio del notebook:

```python
import sys
sys.path.insert(0, "../src")

from limpieza import limpiar_polizas
```

Si añades tests para algún módulo de esta carpeta (fase 6 de `../guion_uso_claude_code.md`), sigue la misma convención de `pytest` que `dia_06_codigo_profesional/`: un archivo `test_<modulo>.py` junto al módulo que testea.
