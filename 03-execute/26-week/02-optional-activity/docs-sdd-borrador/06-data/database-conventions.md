# Convenciones de base de datos

- Motor: InnoDB.
- Codificación: `utf8mb4`.
- Tablas y columnas: `snake_case`.
- Identificadores: enteros autoincrementales con prefijo `id_`.
- Fechas de sesión y asistencia: `DATETIME`.
- Estados controlados por `ENUM`.
- `usuario`, `correo`, números de identidad y `serial_nfc` tienen unicidad según el esquema.
- `asistencia` tiene unicidad compuesta por sesión y aprendiz.
- Las contraseñas se almacenan en una columna de longitud suficiente para hashes.
- Las consultas que reciben datos externos usan sentencias preparadas.
- No se agregan cambios manuales al entorno productivo sin registrarlos en SQL versionado.

Observación: el esquema actual usa claves foráneas entre módulos conceptuales. Se conserva por compatibilidad del MVP; cualquier cambio requiere ADR y migración revisada.
