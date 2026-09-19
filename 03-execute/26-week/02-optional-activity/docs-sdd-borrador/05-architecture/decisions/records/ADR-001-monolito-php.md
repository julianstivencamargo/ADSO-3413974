# ADR-001 - Monolito PHP modular

- Estado: Aceptada para el MVP
- Fecha: 2026-09-17

## Contexto

El proyecto se ejecuta como una aplicación PHP en XAMPP, usa MariaDB y sirve una interfaz web con HTML, CSS, JavaScript y Bootstrap. El MVP necesita consistencia inmediata entre sesiones, aprendices y asistencias.

## Decisión

Mantener un solo despliegue PHP y una sola base de datos. Organizar el dominio en `identity`, `academic` y `attendance`, manteniendo `public/`, `src/`, `config/` y `db/` como límites operativos.

## Alternativas descartadas

- Microservicios: añadirían complejidad sin una necesidad actual.
- Reescritura a un framework: no es requisito del MVP.
- Organización solo por pantallas: no expresa propiedad de reglas y datos.

## Consecuencias

Se simplifica el despliegue y la transacción con MySQL. El equipo debe controlar las dependencias entre módulos y evitar que los endpoints acumulen reglas de negocio.
