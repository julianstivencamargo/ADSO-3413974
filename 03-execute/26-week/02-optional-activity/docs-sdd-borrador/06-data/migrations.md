# Migraciones

## Estado actual

El esquema inicial se provisiona desde `db/schema.sql` mediante phpMyAdmin o MariaDB. No existe todavía un sistema formal de migraciones.

## Regla para cambios futuros

Cada cambio de estructura debe guardarse en `db/migrations/` con orden numérico y descripción:

```text
db/migrations/
├── 001_initial_schema.sql
├── 002_add_manual_attendance.sql
└── 003_add_reports_indexes.sql
```

Cada migración debe indicar:

- tablas y columnas afectadas;
- motivo del cambio;
- datos existentes que deben conservarse;
- procedimiento de aplicación;
- procedimiento de reversión o justificación si no es reversible;
- prueba en una copia del esquema.

No se debe editar silenciosamente `schema.sql` para representar cambios ya aplicados. `schema.sql` se mantiene como instalación reproducible y las migraciones como historia de evolución.
