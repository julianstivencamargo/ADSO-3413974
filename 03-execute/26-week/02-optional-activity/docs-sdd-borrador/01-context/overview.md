# Descripción general

Asistencia NFC permite al instructor iniciar sesión, seleccionar una ficha y una competencia, crear una sesión activa y registrar aprendices mediante su serial NFC. La aplicación guarda sesiones y asistencias en MariaDB/MySQL.

| Actor | Uso |
|---|---|
| Instructor | Inicia sesión, crea y termina sesiones |
| Aprendiz | Se identifica mediante su tarjeta NFC |
| Sistema | Valida sesión, aprendiz y duplicados |

El MVP resuelve el registro rápido de asistencia. La estructura actual separa `public/`, `api/`, `src/`, `config/` y `db/`, pero dashboard, aprendices, historial y reportes todavía no tienen el mismo nivel de funcionalidad.

Restricciones: PHP 8.2, MariaDB 10.4, XAMPP, navegador compatible, HTTPS para APIs NFC del navegador y tarjetas previamente asociadas.
