# Control de límites

El proyecto no tiene todavía un linter arquitectónico automático. En esta fase los límites se controlan mediante revisión y estructura de carpetas.

Reglas objetivo:

- `attendance` puede usar contratos públicos de `academic` e `identity`.
- Un módulo no debe importar carpetas internas de otro.
- Las vistas no deben ejecutar consultas SQL directamente.
- `src/core/conexion.php` es infraestructura compartida, no dominio.
- `config/` no se sirve directamente desde Apache.
- Los endpoints deben validar sesión, entrada y pertenencia de los datos.

Implementación gradual:

1. Separar casos de uso por módulo.
2. Crear una prueba de arquitectura o script que detecte imports prohibidos.
3. Ejecutar la comprobación en cada pull request.
4. Migrar consultas desde endpoints hacia repositorios del módulo sin cambiar el contrato HTTP.

Estado: pendiente automatizar la comprobación.
