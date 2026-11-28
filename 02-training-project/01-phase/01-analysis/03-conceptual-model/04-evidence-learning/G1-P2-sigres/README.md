# README de entrega · Guía 1 · Producto 2: Modelo de análisis y verificación

Ruta de entrega en mi fork:
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-sigres/`

Fecha límite: **sábado 28 de noviembre de 2026 a las 6:00 a. m.**
Criterios y mínimos: [Rubricas_G1.md](../../03-support-material/Rubricas_G1.md)

---

## 1. Datos de la entrega

- **Producto:** P2 modelo de análisis y verificación
- **Usuario de GitHub del autor:** `julianstivencamargo`
- **Caso de estudio:** SIGRES — Sistema Integral de Gestión para Restaurantes
- **Trabajo en equipo del año:** Sí (`Equipo SIGRES`, 4 integrantes, ficha 3413974; sin datos personales en este repositorio público). Las plantillas extendidas ajustadas sin detalles técnicos, los diagramas de actividades, el modelo de dominio, el MER, la lista de chequeo, el registro de ajustes, el informe de análisis y la matriz de trazabilidad son trabajo individual de `julianstivencamargo`.

## 2. Qué reutilicé

| Artefacto | Ruta original en mi fork (semana) | ¿Lo hice solo o en equipo? |
|---|---|---|
| SRS de SIGRES (versión 26/10/2026: fichas RF01–RF17, RNF-01–RNF-31 y tablas iniciales CU-01–CU-09) | Repositorio del proyecto formativo del equipo (resumido en [08_informe_analisis.md](./08_informe_analisis.md) y contrastado en [07_registro_ajustes.md](./07_registro_ajustes.md)) | En equipo (`Equipo SIGRES`) |
| Prototipo visual base (diapositivas 1 y 2: toma de pedidos y mapa de mesas) | [MockUp SIGRES.pptx](../../../../../../03-execute/14-week/02-optional-activity/MockUp%20SIGRES.pptx) | En equipo (`Equipo SIGRES`) |
| Experiencia previa de lista de chequeo y levantamiento de requisitos (proyecto inicial antes de pasar a SIGRES) | [08-week](../../../../../../03-execute/08-week/02-optional-activity/) y [SRS_MercaGO_Supermercado.pdf](../../../../../../03-execute/09-week/02-optional-activity/SRS_MercaGO_Supermercado.pdf) | En equipo (proyecto inicial) |

## 3. Qué ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
|---|---|---|---|
| 1 | Plantillas extendidas de casos de uso (`02_plantillas_extendidas.md`) | Tomé como base las tablas de `CU-04`, `CU-05` y `CU-07` del SRS del equipo, eliminé todos los términos de implementación técnica (*base de datos*, *JWT*, *WebSocket*, *bcrypt*) y reescribí los flujos de `CU-06`, `CU-08` y `CU-12` como intención de negocio con ciclo de estados unificado y regla de propina voluntaria (criterio C2; hallazgos H2, H6, H7). | [`c85a3e9`](https://github.com/julianstivencamargo/ADSO-3413974/commit/c85a3e9) (25/11) |
| 2 | Prototipo inicial (`05_prototipo_inicial.md` y `prototipo/*.svg`) | Rotulé y actualicé la pantalla reutilizada de `MockUp SIGRES.pptx` con el caso `CU-06` (agregando observaciones por plato, estado agotado y adicionales) y construí desde cero las pantallas faltantes de **Cocina (`CU-08`)** y **Caja/Facturación (`CU-12`)** (criterio C5; hallazgo H8). | [`c85a3e9`](https://github.com/julianstivencamargo/ADSO-3413974/commit/c85a3e9) (25/11) |
| 3 | Modelo de dominio, MER y trazabilidad (`03_modelo_dominio.md`, `04_modelo_entidad_relacion.md`, `01_diagramas_actividades.md`) | Incorporé la clase y entidad asociativa `RecetaInsumo` / `RECETA_INSUMO` (ausente en el SRS), separé `FACTURA` de `PAGO` en relación `1 : 1..*` y ajusté la trazabilidad de actividades con las plantillas `2a` y `7b` (criterios C1, C3, C4; hallazgos H4 y H7). | [`c85a3e9`](https://github.com/julianstivencamargo/ADSO-3413974/commit/c85a3e9) (25/11) + Commit 2 (27/11) |

## 4. Qué construí nuevo

- 2 diagramas de actividades con calles por actor, todas las decisiones con guardas entre corchetes y bifurcación/unión para procesos concurrentes ([01_diagramas_actividades.md](./01_diagramas_actividades.md)).
- Modelo de dominio conceptual puro de 13 clases sin métodos ni claves técnicas, con 2 clases de asociación ([03_modelo_dominio.md](./03_modelo_dominio.md)).
- Modelo Entidad-Relación en notación Pata de Gallo con 13 entidades, 2 relaciones N:M resueltas con entidad asociativa y 2 entidades débiles ([04_modelo_entidad_relacion.md](./04_modelo_entidad_relacion.md)).
- Lista de chequeo de 18 criterios verificables con doble pasada de verificación y registro de 8 hallazgos H1–H8 ([06_lista_chequeo.md](./06_lista_chequeo.md), [07_registro_ajustes.md](./07_registro_ajustes.md)).
- Informe de análisis ejecutivo y matriz de trazabilidad integral con 17/17 requisitos funcionales cubiertos ([08_informe_analisis.md](./08_informe_analisis.md), [09_matriz_trazabilidad.md](./09_matriz_trazabilidad.md)).

## 5. Artefactos entregados

**Producto 2**

- [x] Diagramas de actividades (2 diagramas del flujo crítico): [01_diagramas_actividades.md](./01_diagramas_actividades.md)
- [x] Plantillas extendidas de casos de uso (3 plantillas `CU-06`, `CU-08`, `CU-12`): [02_plantillas_extendidas.md](./02_plantillas_extendidas.md)
- [x] Modelo de dominio (13 clases conceptuales sin métodos): [03_modelo_dominio.md](./03_modelo_dominio.md)
- [x] Modelo entidad-relación (Pata de Gallo, 13 entidades): [04_modelo_entidad_relacion.md](./04_modelo_entidad_relacion.md)
- [x] Prototipo inicial (3 pantallas SVG rotuladas): [05_prototipo_inicial.md](./05_prototipo_inicial.md) · [Pantalla 01](./prototipo/pantalla_01_CU06_registrar_pedido.svg) · [Pantalla 02](./prototipo/pantalla_02_CU08_panel_cocina.svg) · [Pantalla 03](./prototipo/pantalla_03_CU12_facturacion_caja.svg)
- [x] Lista de chequeo diligenciada (18 criterios verificables, 5 de cobertura/trazabilidad): [06_lista_chequeo.md](./06_lista_chequeo.md)
- [x] Registro de ajustes y segunda verificación (8 hallazgos H1–H8): [07_registro_ajustes.md](./07_registro_ajustes.md)
- [x] Informe de análisis: [08_informe_analisis.md](./08_informe_analisis.md)
- [x] Matriz de trazabilidad (Anexo C, 17/17 = 100 %): [09_matriz_trazabilidad.md](./09_matriz_trazabilidad.md)

## 6. Declaración de autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

Firma (usuario de GitHub y fecha): `julianstivencamargo` · 2026-11-27

## 7. Uso de inteligencia artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Asistente de IA (Antigravity) | Estructurar los archivos markdown según los Anexos A–D, redactar diagramas Mermaid (actividades, clases de dominio y MER) y generar los prototipos SVG a partir de `MockUp SIGRES.pptx`. | Auditado contra el SRS real de SIGRES (26/10/2026); comprobé que cada guarda de los diagramas de actividades existiera en las plantillas extendidas, verifiqué la eliminación total de términos técnicos en plantillas y dominio, validé la cardinalidad de `RECETA_INSUMO` y `PAGO`, y confirmé que no existiera fuga de datos personales. |

## 8. Autocontrol antes del push

- [x] Hice commits propios en al menos 2 días distintos entre la publicación de la guía (sábado 21 de noviembre de 2026) y la entrega (`25/11/2026` y `27/11/2026`).
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Hice `push` y comprobé en GitHub que la carpeta está publicada.
