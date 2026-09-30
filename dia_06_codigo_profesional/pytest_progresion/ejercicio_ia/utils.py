"""Función de dominio actuarial usada en el bloque de IA de la Unidad 6.

Se mantiene deliberadamente simple: sirve para pedirle a un asistente de IA
que genere un test de pytest para una función que ya existe, y comprobar
que el test generado detecta un fallo real cuando se introduce a propósito.
"""


def calcular_prima_total(prima_neta: float, recargo: float) -> float:
    """Calcula la prima total a pagar por el asegurado.

    Args:
        prima_neta: prima pura, sin recargos (debe ser >= 0).
        recargo: recargo de gestión expresado como proporción (p.ej. 0.15 = 15%).

    Returns:
        La prima total: la prima neta más el recargo aplicado sobre ella.

    Raises:
        ValueError: si `prima_neta` o `recargo` son negativos.
    """
    if prima_neta < 0:
        raise ValueError("La prima neta no puede ser negativa")
    if recargo < 0:
        raise ValueError("El recargo no puede ser negativo")
    return prima_neta * (1 + recargo)
