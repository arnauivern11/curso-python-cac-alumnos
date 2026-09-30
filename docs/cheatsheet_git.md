# Cheatsheet Git — comandos mínimos de supervivencia

Pensado para quien viene de "guardar versiones" de un Excel a mano (`modelo_v2_final_bueno.xlsx`) y necesita lo justo para trabajar con Git en el curso y después. No es una referencia completa de Git: es lo que necesitáis usar de verdad.

## El vocabulario mínimo

| Término | En tu cabeza de Excel, es... |
|---|---|
| Repositorio (`repo`) | La carpeta del proyecto entera, con memoria de todos sus cambios |
| Commit | Un "guardar versión" con nombre y fecha, para siempre |
| Rama (`branch`) | Una copia paralela del proyecto para probar algo sin tocar la buena |
| `main` | La rama "oficial", la que funciona |
| Remoto (`origin`) | La copia del repo que vive en GitHub |
| `push` / `pull` | Subir tus commits a GitHub / bajar los commits de otros |
| Merge | Juntar los cambios de una rama con otra |

## Flujo de trabajo del día a día

```bash
git status                     # qué ha cambiado desde el último commit
git add archivo.py             # marcar un archivo para el próximo commit
git add .                      # marcar todos los cambios (con cuidado)
git commit -m "mensaje claro"  # guardar versión con esos cambios
git push                       # subir tus commits a GitHub
git pull                       # bajar los commits nuevos de GitHub
```

**Regla de oro del mensaje de commit**: describe el *porqué*, no el *qué* ("arregla el cálculo de la prima cuando la edad es nula", no "cambios en funciones.py").

## Ramas

```bash
git branch                       # ver en qué rama estás y cuáles existen
git checkout -b nombre-rama      # crear una rama nueva y moverte a ella
git checkout nombre-rama         # moverte a una rama existente
git checkout main                # volver a main
git merge nombre-rama            # traer los cambios de nombre-rama a la rama actual
```

## Ver el histórico

```bash
git log --oneline                # lista compacta de commits
git log --oneline --graph --all  # con ramas visualizadas
git diff                         # qué ha cambiado y aún no está en un commit
git diff --staged                # qué ha cambiado y ya está marcado con add
```

## Deshacer cosas (lo que de verdad se pregunta en clase)

| Quiero... | Comando |
|---|---|
| Deshacer cambios de un archivo aún no guardados | `git checkout -- archivo.py` |
| Quitar un archivo del "marcado" sin perder el cambio | `git restore --staged archivo.py` |
| Deshacer el último commit pero mantener los cambios | `git reset --soft HEAD~1` |
| Crear un commit nuevo que deshace uno anterior (seguro, sin reescribir historia) | `git revert <hash-del-commit>` |
| Ver una versión antigua de un archivo | `git show <hash>:ruta/archivo.py` |

`git revert` es el equivalente a "deshacer con seguimiento": crea un commit nuevo, no borra historia. Es lo que usaréis casi siempre. `git reset --hard` y `git push --force` **sí borran trabajo**: no se usan salvo que sepáis exactamente por qué, y nunca sobre una rama compartida.

## GitHub — lo mínimo

```bash
git clone <url>                  # bajar un repo por primera vez
```

- **Pull Request (PR)**: propuesta de juntar tu rama con `main`, para que otra persona la revise antes de fusionarla.
- **Issue**: una incidencia o tarea pendiente, documentada en el propio repo.
- Flujo típico: crear rama → commits → `git push` → abrir PR en GitHub → revisión → merge.

## Errores típicos al empezar

> ⚠️ **"fatal: not a git repository"** — no estás dentro de una carpeta inicializada con `git init` o clonada con `git clone`. Comprueba con `git status` en qué carpeta estás.

> ⚠️ **"Please tell me who you are"** — falta configurar tu identidad la primera vez: `git config --global user.name "Tu Nombre"` y `git config --global user.email "tu@email.com"`.

> ⚠️ **Conflicto de merge** — dos ramas cambiaron la misma línea. Git marca el archivo con `<<<<<<<`, `=======`, `>>>>>>>`; hay que editar a mano, decidir qué versión queda, borrar esas marcas y hacer `git add` + `git commit`.
