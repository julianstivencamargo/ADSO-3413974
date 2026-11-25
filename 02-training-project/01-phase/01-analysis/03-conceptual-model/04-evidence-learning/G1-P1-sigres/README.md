# README de entrega · Guía 1 · Producto 1: Plan de análisis y casos de uso

Ruta de entrega en mi fork:
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-sigres/`

Fecha límite: **sábado 28 de noviembre de 2026 a las 6:00 a. m.**
Criterios y mínimos: [Rubricas_G1.md](../../03-support-material/Rubricas_G1.md)

---

## 1. Datos de la entrega

- **Producto:** P1 plan de análisis y casos de uso
- **Usuario de GitHub del autor:** `julianstivencamargo`
- **Caso de estudio:** SIGRES — Sistema Integral de Gestión para Restaurantes
- **Trabajo en equipo del año:** Sí (`Equipo SIGRES`, 4 integrantes, ficha 3413974; sin datos personales en este repositorio público). El ajuste individual, la caracterización de la solución, la selección de metodología, el diagrama integral de casos de uso y la matriz RF → CU son trabajo propio de `julianstivencamargo`.

## 2. Qué reutilicé

| Artefacto | Ruta original en mi fork (semana) | ¿Lo hice solo o en equipo? |
|---|---|---|
| SRS de SIGRES (versión 26/10/2026: 17 RF, 31 RNF, 9 CU en 8 módulos) | Repositorio del proyecto formativo del equipo (no estaba publicado en este fork individual; se declara y resume en [03_matriz_requisito_caso_uso.md](./03_matriz_requisito_caso_uso.md) y [08_informe_analisis.md](../G1-P2-sigres/08_informe_analisis.md)) | En equipo (`Equipo SIGRES`) |
| Instrumentos de recolección y experiencia de levantamiento SRS previo (proyecto inicial antes de pasar a SIGRES) | [08-week](../../../../../../03-execute/08-week/02-optional-activity/) y [SRS_MercaGO_Supermercado.pdf](../../../../../../03-execute/09-week/02-optional-activity/SRS_MercaGO_Supermercado.pdf) | En equipo (proyecto inicial) |
| Prototipo visual base de SIGRES (diapositivas de toma de pedidos y gestión de mesas) | [MockUp SIGRES.pptx](../../../../../../03-execute/14-week/02-optional-activity/MockUp%20SIGRES.pptx) | En equipo (`Equipo SIGRES`) |

## 3. Qué ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
|---|---|---|---|
| 1 | Diagrama integral de casos de uso (`diagrama_casos_uso.drawio` / `.svg` y `02_casos_de_uso.md`) | Unifiqué los 8 diagramas modulares separados del SRS (figuras 1 a 8) en una sola frontera de sistema, eliminando casos duplicados (*Ver disponibilidad de mesas*, *Consultar estado del pedido*), incorporando la generalización abstracta `Empleado` y justificando 3 `«include»` y 3 `«extend»` con punto de extensión (criterio C4; hallazgo H5). | Commit 1 · 25/11/2026 *(se enlazará el hash definitivo en el Commit 2 del 27/11/2026)* |
| 2 | Catálogo de roles y casos de uso (`02_casos_de_uso.md`) | Agregué el actor y rol operativo `Cocina` en el catálogo y reglas de acceso (estaba omitido en RF01, RF03 y Alcance del SRS, aunque existía en RNF-01/02 y en la Figura 2), y agrupé las operaciones CRUD de usuarios/roles, menú/categorías y mesas conforme a la regla de arbitraje §7.1 (criterio C4; hallazgo H1). | Commit 1 · 25/11/2026 *(se enlazará el hash definitivo en el Commit 2 del 27/11/2026)* |
| 3 | Matriz requisito → caso de uso (`03_matriz_requisito_caso_uso.md`) | Corregí 8 referencias cruzadas desplazadas entre fichas del SRS (RF05, RF07, RF10, RF11, RF14, RF15, RF16 y RF17), unifiqué el manejo de pago mixto/división de cuenta y tracé los 17 RF al 100 % distinguiendo los 31 RNF e IU/IH/IS/IC como restricciones (criterio C3; hallazgos H2, H3, H4, H7, H8). | Commit 1 · 25/11/2026 *(se enlazará el hash definitivo en el Commit 2 del 27/11/2026)* |
| 4 | Caracterización, selección metodológica y plan (`01_caracterizacion_metodologia_plan.md`) | Construí la caracterización en 4 aspectos tomada del SRS, comparé RUP, Scrum, XP y RAD con 4 criterios propios del proyecto, justifiqué **Scrum** como metodología única (no híbrida) y organicé el cronograma de 8 actividades con enfoque en el flujo crítico mesa → cocina → caja (criterios C1 y C2). | Commit 1 · 25/11/2026 *(se enlazará el hash definitivo en el Commit 2 del 27/11/2026)* |

## 4. Qué construí nuevo

- Caracterización formal de la solución en 4 dimensiones y matriz de comparación de metodologías (RUP, Scrum, XP, RAD) con justificación de **Scrum** y plan de análisis de 8 actividades en sprints ([01_caracterizacion_metodologia_plan.md](./01_caracterizacion_metodologia_plan.md)).
- Diagrama UML integral de 17 casos de uso en formato editable XML y vectorial SVG, junto con su catálogo y justificación de relaciones ([diagrama_casos_uso.drawio](./diagrama_casos_uso.drawio), [diagrama_casos_uso.svg](./diagrama_casos_uso.svg), [02_casos_de_uso.md](./02_casos_de_uso.md)).
- Matriz completa requisito funcional → caso de uso (17/17 = 100 % de cobertura) y cruce de restricciones RNF clave ([03_matriz_requisito_caso_uso.md](./03_matriz_requisito_caso_uso.md)).

## 5. Artefactos entregados

**Producto 1**

- [x] Caracterización de la solución: [01_caracterizacion_metodologia_plan.md §1](./01_caracterizacion_metodologia_plan.md#1-caracterización-de-la-solución)
- [x] Comparación de metodologías y selección justificada: [01_caracterizacion_metodologia_plan.md §2](./01_caracterizacion_metodologia_plan.md#2-comparación-de-metodologías)
- [x] Plan de actividades, cronograma y entregables: [01_caracterizacion_metodologia_plan.md §3](./01_caracterizacion_metodologia_plan.md#3-plan-de-actividades-de-análisis-alineado-con-scrum)
- [x] Diagrama de casos de uso (fuente editable): [diagrama_casos_uso.drawio](./diagrama_casos_uso.drawio)
- [x] Diagrama de casos de uso (imagen): [diagrama_casos_uso.svg](./diagrama_casos_uso.svg)
- [x] Catálogo y justificación de casos de uso y relaciones: [02_casos_de_uso.md](./02_casos_de_uso.md)
- [ ] Matriz requisito → caso de uso: [03_matriz_requisito_caso_uso.md](./03_matriz_requisito_caso_uso.md) *(Entrega de cierre y cobertura final · 27/11/2026)*

## 6. Declaración de autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

Firma (usuario de GitHub y fecha): `julianstivencamargo` · 2026-11-25

## 7. Uso de inteligencia artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Asistente de IA (Antigravity) | Estructurar los documentos markdown según `Rubricas_G1.md`, generar la geometría XML/SVG de `diagrama_casos_uso.drawio` / `.svg` y contrastar el SRS del equipo contra las reglas de arbitraje §7. | Auditado contra el SRS real de SIGRES (26/10/2026); validé el foco individual en el flujo mesero → cocina → caja, confirmé los 8 hallazgos H1–H8, verifiqué la dirección exacta de las flechas `«include»` y `«extend»` y comprobé que no hubiera datos personales ni duplicados de casos. |

## 8. Autocontrol antes del push

- [ ] Hice commits propios en al menos 2 días distintos entre la publicación de la guía (sábado 21 de noviembre de 2026) y la entrega *(Commit 1 hecho el 25/11/2026; pendiente Commit 2 el viernes 27/11/2026)*.
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [ ] Hice `push` y comprobé en GitHub que la carpeta está publicada *(se completará tras el push final antes del sábado 28 a las 6:00 a. m.)*.
