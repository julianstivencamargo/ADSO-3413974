# HU-08 - Registro manual

Como instructor, quiero registrar manualmente la asistencia de un aprendiz cuando falle la tarjeta, el lector o el aprendiz no la tenga.

## Criterios de aceptación

- El instructor debe estar autenticado.
- La sesión debe estar activa.
- El aprendiz debe pertenecer a la ficha de la sesión.
- El registro debe usar método `MANUAL` y `es_manual = 1`.
- El motivo debe ser obligatorio.
- Deben almacenarse instructor, fecha y hora.
- No se permite repetir la asistencia de la misma sesión.

Estado: Pendiente. La tabla ya contiene `metodo_registro`, `es_manual`, `motivo_manual` e `id_instructor_registro`.
