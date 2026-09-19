# Historias de usuario

| ID | Historia | Módulo | Estado | Prioridad |
|---|---|---|---|---|
| HU-01 | Iniciar sesión como instructor | `identity` | Implementado | Alta |
| HU-02 | Cargar fichas y competencias | `academic` | Implementado | Alta |
| HU-03 | Crear una sesión con tolerancia | `attendance` | Implementado | Alta |
| HU-04 | Consultar aprendices de la sesión activa | `academic` | Implementado | Alta |
| HU-05 | Registrar asistencia mediante NFC | `attendance` | Implementado | Alta |
| HU-06 | Rechazar una asistencia duplicada | `attendance` | Implementado | Alta |
| HU-07 | Finalizar una sesión | `attendance` | Implementado | Alta |
| HU-08 | Registrar asistencia manual | `attendance` | Pendiente | Media |
| HU-09 | Clasificar presente, retardo y ausente | `attendance` | Parcial | Alta |
| HU-10 | Gestionar aprendices | `academic` | Pendiente | Alta |
| HU-11 | Consultar historial de asistencia | `attendance` | Pendiente | Media |
| HU-12 | Generar reportes | `attendance` | Pendiente | Media |

## HU-05 - Registrar asistencia NFC

Como instructor, quiero registrar un aprendiz identificado por su tarjeta NFC para controlar su asistencia en la sesión activa.

Criterios:

- Dada una sesión activa y un aprendiz válido, se crea una asistencia con método `NFC`.
- Si la sesión está cerrada, se rechaza el registro.
- Si el aprendiz ya registró asistencia en esa sesión, se devuelve un resultado de duplicado.
- Si el aprendiz no existe, se informa que la tarjeta no está registrada.

## HU-07 - Finalizar sesión

Como instructor, quiero cerrar la sesión para impedir nuevas marcaciones.

Criterios:

- Una sesión activa pasa a estado `CERRADA`.
- Se registra `fecha_fin`.
- Una segunda finalización se rechaza.
- La creación automática de ausentes queda como requisito pendiente.
