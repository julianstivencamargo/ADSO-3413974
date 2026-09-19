# Mapa de dominio

```mermaid
graph TD
    Identity["Identity<br/>instructor"]
    Academic["Academic<br/>ficha, competencia, aprendiz, serial NFC"]
    Attendance["Attendance<br/>sesion_asistencia, asistencia"]

    Academic -->|asigna fichas a| Identity
    Attendance -->|usa ficha y competencia| Academic
    Attendance -->|registra instructor de operación| Identity
```

| Relación | Significado |
|---|---|
| Academic -> Identity | Una ficha puede tener instructor asignado |
| Attendance -> Academic | La sesión pertenece a una ficha y competencia; el aprendiz pertenece a la ficha |
| Attendance -> Identity | Una asistencia puede registrar el instructor que la opera |

Cada contexto se convierte en un módulo interno del mismo monolito, no en un servicio desplegable separado.
