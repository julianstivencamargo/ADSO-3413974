# G1-P1 · Caracterización, selección de metodología y plan de análisis

**Caso de estudio:** SIGRES — Sistema Integral de Gestión para Restaurantes (proyecto formativo del equipo, ficha 3413974)
**Insumo base:** SRS de SIGRES del equipo (versión del 26 de octubre de 2026): 17 requisitos funcionales (RF01–RF17), 31 no funcionales (RNF-01–RNF-31) y 9 casos de uso caracterizados (CU-01–CU-09).
**Enfoque de mi ajuste individual:** el **flujo operativo del servicio a la mesa**: mesero → cocina → caja. Es el ciclo que recorre cada pedido y el que más inconsistencias tenía en el SRS base (ver [registro de ajustes del P2](../G1-P2-sigres/07_registro_ajustes.md)).

---

## 1. Caracterización de la solución

| Aspecto | Cómo es SIGRES | Evidencia en el SRS | Consecuencia para el método de trabajo |
|---|---|---|---|
| **Tipo de proyecto** | Sistema de información transaccional **multiplataforma** (web administrativa + app móvil para meseros + menú QR público) con sincronización en tiempo real entre áreas. Proyecto **nuevo** (no reemplaza un software existente; reemplaza comandas en papel). | Perspectiva del producto; RF04–RF07; RNF-17 (comanda en cocina en 5 s o menos) | Hay módulos que se pueden entregar por separado (usuarios, menú, pedidos, caja). Conviene construir y mostrar por incrementos y validar pronto el flujo crítico del pedido. |
| **Tamaño del equipo** | **4 aprendices**, todos con responsabilidad *full stack*, que rotan los roles de Product Owner, backend, frontend, UX/UI y QA (Tabla 5 del SRS). | Personal involucrado, tablas 1 a 5 | Equipo pequeño y en el mismo sitio: la comunicación cara a cara reemplaza la documentación pesada. No hay personal para sostener un proceso con muchos artefactos formales por fase. |
| **Estabilidad de los requisitos** | **Media.** El núcleo (pedido, cocina, factura) es estable, pero hay funciones en duda (división de cuenta, pago mixto, cancelación de pedidos) y una lista explícita de ampliaciones futuras (pasarelas de pago, domicilios, notificaciones por WhatsApp). Al revisar el SRS encontré estados del pedido contradictorios y roles incompletos, señal de que los requisitos todavía se están afinando. | Alcance («no incluye inicialmente»); Integración futura; RF06 frente a RF07 | Se necesita un método que **acepte cambios entre iteraciones** sin rehacer todo el análisis, con un backlog que se pueda volver a priorizar. |
| **Disponibilidad del cliente** | **Media.** No hay un restaurante contratante; el negocio lo representan el **Product Owner del equipo** y el **instructor**, que revisan avances en las sesiones semanales de formación. | Restricciones operativas (cronograma del proyecto SENA) | La retroalimentación llega **por ciclos semanales**, no a diario. Las revisiones deben coincidir con esas sesiones. |

---

## 2. Comparación de metodologías

Criterios de comparación tomados de la caracterización: (C-a) tolerancia al cambio de requisitos, (C-b) carga documental frente a un equipo de 4, (C-c) cómo usa la disponibilidad del cliente, (C-d) capacidad de entregar módulos por incrementos.

| Criterio | RUP | Scrum | XP | RAD |
|---|---|---|---|---|
| **C-a Cambio de requisitos (estabilidad media)** | Iterativo, pero la arquitectura y los requisitos se estabilizan en Inicio y Elaboración; un cambio tardío obliga a revisar artefactos de varias disciplinas. | Absorbe cambios **entre sprints** volviendo a priorizar el Product Backlog; el sprint en curso se protege. | Muy alta: acepta cambios casi diarios. | Alta durante los talleres de prototipado; baja después de la construcción. |
| **C-b Carga documental (4 personas)** | Alta: muchos roles y artefactos por disciplina. Para 4 personas es sobrecosto. | Baja y suficiente: backlog, sprint backlog, incremento, Definición de Hecho. | Mínima: código, pruebas e historias. Exige prácticas técnicas (pareja, TDD) que el equipo aún no domina. | Baja, centrada en prototipos. |
| **C-c Disponibilidad del cliente (media, semanal)** | Revisión en hitos de fase: encaja, pero la realimentación llega tarde. | Sprint Review al final de cada sprint: **encaja con la sesión semanal** de formación. | Requiere **cliente en sitio a diario**: SIGRES no lo tiene. | Requiere talleres JAD intensivos con usuarios reales. |
| **C-d Entrega por módulos** | Sí, por iteraciones dentro de cada fase. | Sí: cada sprint produce un incremento usable (por ejemplo, «pedido llega a cocina»). | Sí, entregas muy pequeñas. | Sí, pero orientado a prototipos y herramientas de generación que no se usarán. |

### Metodología seleccionada: **Scrum** (una sola, no híbrida)

Justificación con las características del proyecto:

1. **Estabilidad media (C-a):** las inconsistencias detectadas (estados del pedido, roles, pago mixto) se registran como elementos del backlog y se resuelven en el siguiente sprint sin detener el resto del análisis.
2. **Equipo de 4 con roles rotativos (C-b):** Scrum define solo tres responsabilidades (Product Owner, Scrum Master, Developers). Encaja con la tabla de roles del SRS sin crear documentación que nadie mantendría.
3. **Cliente disponible por ciclos semanales (C-c):** la Sprint Review coincide con la sesión de formación en la que el instructor y el Product Owner validan. XP queda descartada porque exige cliente diario; RAD, porque exige talleres intensivos con usuarios reales.
4. **Módulos independientes (C-d):** el backlog se ordena por valor. Primero el ciclo pedido → cocina → factura (RF04, RF05, RF07, RF12, RF13), que es la razón de ser del sistema; después inventario, reportes y menú QR.

---

## 3. Plan de actividades de análisis (alineado con Scrum)

Sprints de análisis de **1 semana**, que terminan en la sesión de formación (Sprint Review). Los responsables se nombran por rol para no publicar datos personales del equipo.

| # | Actividad de análisis | Sprint / fecha | Responsable | Entregable verificable |
|---|---|---|---|---|
| A1 | Levantar el problema y el alcance con instrumentos de recolección (entrevista, encuesta, lista de chequeo), reutilizando la experiencia del proyecto anterior | Sprint 0 · 28/09/2026 – 04/10/2026 | Product Owner + equipo | Planteamiento del problema y alcance (sección 1 del SRS) |
| A2 | Caracterizar la solución y seleccionar la metodología | Sprint 0 · 05/10/2026 – 11/10/2026 | julianstivencamargo (analista) | Este documento, secciones 1 y 2 |
| A3 | Especificar requisitos funcionales en fichas y priorizarlos en el Product Backlog | Sprint 1 · 12/10/2026 – 18/10/2026 | Equipo (cada integrante, 4 a 5 fichas) | Fichas RF01–RF17 con prioridad |
| A4 | Especificar requisitos no funcionales medibles según ISO/IEC 25010 | Sprint 1 · 19/10/2026 – 25/10/2026 | QA del equipo | Tablas RNF-01–RNF-31 · SRS versión del 26/10/2026 |
| A5 | Construir el diagrama integral de casos de uso y la matriz requisito → caso de uso | Sprint 2 · 21/11/2026 – 25/11/2026 | julianstivencamargo (analista) | [diagrama_casos_uso.drawio](./diagrama_casos_uso.drawio), [02_casos_de_uso.md](./02_casos_de_uso.md), [03_matriz_requisito_caso_uso.md](./03_matriz_requisito_caso_uso.md) |
| A6 | Modelar el flujo crítico: diagramas de actividades, plantillas extendidas, modelo de dominio y MER | Sprint 2 · 23/11/2026 – 25/11/2026 | julianstivencamargo (analista) | Carpeta [G1-P2-sigres](../G1-P2-sigres/) |
| A7 | Verificar los modelos con la lista de chequeo, corregir y volver a verificar | Sprint 2 · 25/11/2026 – 27/11/2026 | julianstivencamargo (analista, en rol QA) | [Lista de chequeo](../G1-P2-sigres/06_lista_chequeo.md) y [registro de ajustes](../G1-P2-sigres/07_registro_ajustes.md) |
| A8 | Sprint Review: presentar el análisis y llevar los hallazgos sobre el SRS al Product Owner para la siguiente versión | 28/11/2026 (sesión presencial) | julianstivencamargo → Product Owner | [Informe de análisis](../G1-P2-sigres/08_informe_analisis.md) y hallazgos H1–H8 |

Prioridad: A5–A7 cubren el flujo de mayor valor (mesa → cocina → caja) y se ejecutan primero dentro del sprint 2. Inventario, reportes y menú QR se modelan solo hasta el nivel de casos de uso y matriz en este sprint.
