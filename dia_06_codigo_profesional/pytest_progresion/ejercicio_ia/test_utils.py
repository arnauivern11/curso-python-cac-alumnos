import pytest
from utils import calcular_prima_total


def test_calcular_prima_total_caso_normal():
    assert calcular_prima_total(prima_neta=1000.0, recargo=0.15) == 1150.0


def test_calcular_prima_total_sin_recargo():
    assert calcular_prima_total(prima_neta=500.0, recargo=0.0) == 500.0


def test_calcular_prima_total_prima_negativa():
    with pytest.raises(ValueError):
        calcular_prima_total(prima_neta=-100.0, recargo=0.1)


def test_calcular_prima_total_recargo_negativo():
    with pytest.raises(ValueError):
        calcular_prima_total(prima_neta=100.0, recargo=-0.1)
