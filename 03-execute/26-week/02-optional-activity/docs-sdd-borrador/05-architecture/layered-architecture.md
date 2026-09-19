# Capas actuales

La aplicación actual combina estas responsabilidades:

| Capa | Ubicación | Responsabilidad |
|---|---|---|
| Presentación | `public/`, `public/assets/` | HTML, CSS, Bootstrap y navegación |
| Entrada web | `public/*.php`, `public/api/` | Formularios, JSON y respuestas HTTP |
| Persistencia | `src/core/conexion.php` y consultas PHP | Conexión y acceso a MariaDB |
| Configuración | `config/` | Credenciales y configuración fuera de `public/` |
| Datos | `db/schema.sql` | Definición inicial del esquema |

La migración futura puede separar dominio, aplicación y persistencia dentro de cada módulo, pero no se debe mover código sin una prueba equivalente.
