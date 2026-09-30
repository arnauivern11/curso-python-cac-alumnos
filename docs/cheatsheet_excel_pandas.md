# Cheatsheet Excel → pandas

Equivalencias directas entre lo que ya sabes hacer en Excel y su versión en pandas. Úsalo como referencia rápida en las unidades 7 y 8, no como tutorial: cada notebook explica el porqué la primera vez que aparece cada operación.

## Referencias básicas

| Excel | pandas |
|---|---|
| Una hoja | Un `DataFrame` |
| Una columna | `df["columna"]` (una `Series`) |
| Una fila (por número) | `df.iloc[5]` |
| Una celda (fila, columna) | `df.loc[5, "columna"]` |
| `A1:D10` | `df.iloc[0:10, 0:4]` |
| Congelar/mirar cabeceras | `df.columns`, `df.head()` |

## Fórmulas de búsqueda

| Excel | pandas |
|---|---|
| `BUSCARV` / `VLOOKUP` | `df.merge(otra_tabla, on="clave", how="left")` |
| `BUSCARX` / `XLOOKUP` | `df.merge(...)` (más flexible, no depende del orden de columnas) |
| `ÍNDICE` + `COINCIDIR` | `df.set_index("clave").loc[valor, "columna"]` |

## Filtros y condiciones

| Excel | pandas |
|---|---|
| Filtro automático | `df[df["columna"] > 100]` |
| `SI` / `IF` | `np.where(condicion, valor_si, valor_no)` o `df["col"].apply(...)` |
| `Y` / `O` (`AND`/`OR`) en un filtro | `df[(cond1) & (cond2)]` / `df[(cond1) \| (cond2)]` |
| Quitar duplicados | `df.drop_duplicates()` |
| Buscar celdas vacías | `df[df["columna"].isna()]` |

⚠️ En pandas, `&` y `|` sustituyen a `and`/`or` cuando filtras un DataFrame, y cada condición va entre paréntesis. Es el error de sintaxis más común al empezar con filtros.

## Funciones de agregación condicional

| Excel | pandas |
|---|---|
| `SUMAR.SI` / `SUMIF` | `df[df["categoria"] == "X"]["importe"].sum()` |
| `SUMAR.SI.CONJUNTO` | `df[(cond1) & (cond2)]["importe"].sum()` |
| `CONTAR.SI` | `df[df["columna"] == valor].shape[0]` o `(df["columna"] == valor).sum()` |
| `PROMEDIO.SI` | `df[df["categoria"] == "X"]["importe"].mean()` |

## Tablas dinámicas

| Excel | pandas |
|---|---|
| Tabla dinámica: agrupar por una columna y sumar otra | `df.groupby("categoria")["importe"].sum()` |
| Tabla dinámica con varias agregaciones | `df.groupby("categoria").agg({"importe": "sum", "poliza_id": "count"})` |
| Tabla dinámica con filas y columnas cruzadas | `df.pivot_table(index="producto", columns="anio", values="prima", aggfunc="sum")` |
| Tabla dinámica de conteo simple | `pd.crosstab(df["producto"], df["region"])` |

## Combinar tablas (relaciones entre hojas)

| Excel | pandas |
|---|---|
| `BUSCARV` para traer una columna de otra hoja | `df.merge(otra, on="clave", how="left")` |
| Cruzar dos tablas y quedarte solo con lo que coincide en ambas | `df.merge(otra, on="clave", how="inner")` |
| Apilar dos tablas iguales (una debajo de otra) | `pd.concat([df1, df2])` |

`how="left"` mantiene todas las filas de tu tabla principal (como el `BUSCARV` clásico, que no elimina filas aunque no encuentre coincidencia). `how="inner"` solo mantiene lo que coincide en ambas, `how="outer"` mantiene todo aunque falte en una de las dos.

## Ordenar y transformar

| Excel | pandas |
|---|---|
| Ordenar de mayor a menor | `df.sort_values("columna", ascending=False)` |
| Crear una columna calculada | `df["nueva"] = df["a"] + df["b"]` |
| Renombrar una columna | `df.rename(columns={"antiguo": "nuevo"})` |
| Convertir texto a número | `pd.to_numeric(df["columna"], errors="coerce")` |
| Convertir texto a fecha | `pd.to_datetime(df["columna"])` |

## Importar y exportar

| Excel | pandas |
|---|---|
| Abrir un `.xlsx` | `pd.read_excel("archivo.xlsx")` |
| Abrir un `.csv` | `pd.read_csv("archivo.csv")` |
| Guardar como `.xlsx` | `df.to_excel("archivo.xlsx", index=False)` |
| Guardar como `.csv` | `df.to_csv("archivo.csv", index=False)` |

> 📊 **En Excel esto sería...** cada vez que veas este aviso en un notebook de teoría, es la equivalencia puntual de la operación que se acaba de explicar — esta tabla es el resumen de todas ellas juntas para consulta rápida durante los ejercicios.
