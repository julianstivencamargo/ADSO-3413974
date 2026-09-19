# Entidades y reglas

| Entidad | Persistencia | Estado |
|---|---|---|
| Instructor | `instructor` | Implementada |
| Ficha | `ficha` | Implementada |
| Competencia | `competencia` | Implementada |
| Aprendiz | `aprendiz` | Implementada |
| Sesión | `sesion_asistencia` | Implementada |
| Asistencia | `asistencia` | Implementada |

## Reglas

- **BR-01:** usuario, correo y número de identidad del instructor son únicos.
- **BR-02:** número de identidad y serial NFC del aprendiz son únicos.
- **BR-03:** una sesión pertenece a una ficha y una competencia.
- **BR-04:** solo una sesión `ACTIVA` acepta nuevas asistencias.
- **BR-05:** un aprendiz no puede tener dos asistencias en la misma sesión.
- **BR-06:** una asistencia pertenece a una sesión y un aprendiz existentes.
- **BR-07:** una asistencia identifica el método `NFC` o `MANUAL`.
- **BR-08:** la creación y el cierre de sesión registran fecha y estado.
- **BR-09:** retardos y ausencias son reglas previstas, pero aún no están implementadas en el endpoint revisado.
- **BR-10:** el registro manual y su motivo están modelados en la tabla, pero el flujo aún está pendiente.
