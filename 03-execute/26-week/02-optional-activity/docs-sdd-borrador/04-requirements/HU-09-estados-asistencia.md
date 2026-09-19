# HU-09 - Estados de asistencia

Como instructor, quiero que el sistema clasifique la asistencia según el momento de registro.

## Criterios de aceptación

- Dentro de la tolerancia: `PRESENTE`.
- Después de la tolerancia y antes del cierre: `RETARDO`.
- Al cerrar la sesión, aprendices sin registro: `AUSENTE`.
- El cálculo usa `fecha_inicio`, `tolerancia_minutos` y la hora del servidor.

Estado: Parcial. El esquema contempla los tres valores, pero el endpoint actual siempre inserta `PRESENTE` y el cierre no crea ausentes.
