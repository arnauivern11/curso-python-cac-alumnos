"""Funcion de apoyo para el ejercicio de pytest de la Unidad 6.

El alumno debe escribir test_utils.py en esta misma carpeta -- no se
proporciona ningun test hecho, a diferencia del resto de pytest_progresion/.
"""


def calcular_recargo_por_siniestralidad(numero_siniestros: int, prima_base: float) -> float:
    """Calcula el recargo a aplicar sobre la prima base segun el numero de siniestros.

    Regla de negocio (simplificada, solo para el ejercicio):
        - 0 o 1 siniestros: sin recargo, se devuelve la prima base tal cual.
        - 2 o 3 siniestros: recargo del 20% sobre la prima base.
        - 4 o mas siniestros: recargo del 50% sobre la prima base.

    Args:
        numero_siniestros: siniestros declarados en el periodo (debe ser >= 0).
        prima_base: prima base antes de aplicar el recargo (debe ser >= 0).

    Returns:
        La prima con el recargo por siniestralidad ya aplicado.

    Raises:
        ValueError: si `numero_siniestros` o `prima_base` son negativos.
    """
    if numero_siniestros < 0:
        raise ValueError("El numero de siniestros no puede ser negativo")
    if prima_base < 0:
        raise ValueError("La prima base no puede ser negativa")

    if numero_siniestros <= 1:
        return prima_base
    if numero_siniestros <= 3:
        return prima_base * 1.20
    return prima_base * 1.50
