# Estado del dominio

Este borrador distingue entre el diseño descrito y el comportamiento comprobado.

| Capacidad | Estado | Evidencia |
|---|---|---|
| Login de instructor | Implementado | `public/login.php` |
| Crear sesión | Implementado | `public/api/crear_sesion.php` |
| Registrar NFC | Implementado | `public/api/registrar_asistencia.php` |
| Evitar duplicados | Implementado | índice único en `db/schema.sql` y validación PHP |
| Cerrar sesión | Implementado | `public/api/terminar_sesion.php` |
| Retardos | Pendiente | el endpoint fija `PRESENTE` |
| Ausentes automáticos | Pendiente | cierre no inserta ausentes |
| Registro manual | Pendiente | tabla preparada, endpoint no disponible |
| Reportes | Pendiente | no hay endpoint implementado |
