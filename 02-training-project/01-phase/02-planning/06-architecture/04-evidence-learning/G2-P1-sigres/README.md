# README de entrega · Guía 2: Diseño de la solución

## 1. Datos de la entrega

| Campo | Valor |
|---|---|
| Producto | P1 (artefactos de diseño) |
| Usuario de GitHub del autor | `julianstivencamargo` |
| Ficha | 3413974 |
| Caso elegido (nombre del proyecto) | SIGRES — Sistema Integral de Gestión para Restaurantes |
| Enlace al informe de análisis o SRS del caso (ruta en tu fork) | [08_informe_analisis.md](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-sigres/08_informe_analisis.md) |
| Cuenta de GitHub con la que haces los commits | `julianstivencamargo` |

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
|---|---|
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | Sí, el SRS base de SIGRES fue elaborado por el equipo formativo (`Equipo SIGRES`, 4 integrantes). El ajuste e informe de análisis individual se entregó en G1. |
| ¿Qué parte del SRS es tuya? | Participé en el levantamiento de requisitos de salón/pedidos, revisión de casos de uso y validación de flujo crítico mesa → cocina → caja. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | Sí. Todos los artefactos de diseño de software de esta carpeta (clases, patrones, arquitectura, componentes, despliegue y matriz A7) son de autoría individual. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No. |

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
|---|---|---|---|
| A1 Ficha de interpretación y plataforma | [01_ficha_interpretacion_plataforma.md](./01_ficha_interpretacion_plataforma.md) | [08_informe_analisis.md](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-sigres/08_informe_analisis.md) | Seleccioné 14 RF y 6 RNF medibles y justifiqué la plataforma TypeScript (NestJS) + PostgreSQL con condiciones concretas del restaurante. |
| A2 y A3 Diagrama de clases y patrones | [02_diagrama_clases_y_patrones.md](./02_diagrama_clases_y_patrones.md) · [diagrama_clases.svg](./diagrama_clases.svg) | [03_modelo_dominio.md](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-sigres/03_modelo_dominio.md) | Transformé las clases conceptuales a diseño OO con visibilidad, tipos, métodos, herencia (`Empleado`), composición, agregación y 2 patrones GoF (`Strategy` y `Facade`). |
| A4 Arquitectura y tabla RNF | [03_arquitectura_software.md](./03_arquitectura_software.md) · [diagrama_arquitectura.svg](./diagrama_arquitectura.svg) | Nuevo | Definí el estilo en 3 capas estrictas (sin saltar capas), comunicación HTTP/REST y WebSockets KDS, y tabla de decisiones para 4 RNF. |
| A5 Vista de componentes | [04_vista_componentes.md](./04_vista_componentes.md) · [diagrama_componentes.svg](./diagrama_componentes.svg) | Nuevo | Modelé 6 componentes de negocio/UI más la base de datos con interfaces provistas, requeridas y mapeo de clases. |
| A6 Vista de despliegue | [05_vista_despliegue.md](./05_vista_despliegue.md) · [diagrama_despliegue.svg](./diagrama_despliegue.svg) | Nuevo | Diseñé la topología de 4 nodos (Cliente, Proxy Nginx TLS 1.3, API NestJS y PostgreSQL en red privada) con puertos y protocolos. |
| A7 Matriz de trazabilidad | [06_matriz_trazabilidad.md](./06_matriz_trazabilidad.md) | [09_matriz_trazabilidad.md](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-sigres/09_matriz_trazabilidad.md) | Extendí la trazabilidad hacia clases de diseño, tablas lógicas, componentes y decisiones de patrones (17/17 RF = 100 %). |

**Qué reutilicé (resumen en 3 a 5 líneas):**
Partí del informe de análisis, matriz RF → CU y modelo de dominio conceptual de SIGRES construidos en la Guía 1 (`G1-P1-sigres` y `G1-P2-sigres`), manteniendo exactamente los mismos identificadores de requisitos (`RF01`–`RF17` y `RNF-02`–`RNF-19`) y el mismo modelo de negocio mesa → cocina → caja.

**Qué ajusté para llevarlo al estándar de la rúbrica (resumen en 3 a 5 líneas):**
Convertí el modelo de dominio conceptual (que no tenía métodos ni tipos) en un diagrama de clases orientado a objetos completo con visibilidad, tipos de retorno, composición (`Pedido *-- DetallePedido`, `Factura *-- Pago`), herencia (`Empleado`) y polimorfismo (`EstrategiaPago`), garantizando separación estricta de responsabilidades.

**Qué hice completamente nuevo (resumen en 3 a 5 líneas):**
Construí desde cero la justificación de plataforma tecnológica (TypeScript/NestJS y PostgreSQL), los patrones GoF `Strategy` y `Facade`, la arquitectura de 3 capas estrictas con soporte WebSocket para KDS, la vista de 6 componentes con interfaces y la vista de despliegue de 4 nodos con terminación TLS 1.3.

## 4. Autoverificación de mínimos

- [x] A1 Ficha de interpretación: ≥ 8 RF y ≥ 3 RNF con ID; plataforma justificada
- [x] A2 Diagrama de clases: ≥ 8 clases, tipos, métodos, multiplicidades, ≥ 1 composición/agregación y ≥ 1 herencia o interfaz (con ≥ 2 implementaciones)
- [x] A3 ≥ 2 patrones GoF distintos aplicados en el diagrama (al menos uno distinto de singleton)
- [x] A4 Arquitectura con diagrama y tabla de ≥ 3 RNF → decisión
- [x] A5 Vista de componentes: ≥ 5 componentes con interfaces
- [x] A6 Vista de despliegue: ≥ 3 nodos con artefactos y protocolos
- [x] A7 Matriz de trazabilidad análisis → diseño
- [x] Fuente editable e imagen exportada de cada diagrama

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
|---|---|
| Jueves 26/11/2026 | [`09128d3`](https://github.com/julianstivencamargo/ADSO-3413974/commit/09128d3) · `feat(G2-P1): ficha de plataforma, diagrama de clases, patrones y arquitectura SIGRES` |
| Viernes 27/11/2026 | `docs(G2-P1): vistas de componentes, despliegue, matriz de trazabilidad, ajustes UML y cierre README` |

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
|---|---|---|
| Antigravity (asistente IA) | Estructurar las plantillas de arquitectura, redactar diagramas Mermaid y generar las exportaciones vectoriales SVG de clases, arquitectura, componentes y despliegue. | Verifiqué manualmente que cada clase cumpliera la regla de separación de responsabilidades, ajusté las interfaces de `EstrategiaPago` para pagos mixtos (`RF13`) y comprobé que los 17 RF coincidan con el análisis de G1. |

## 7. Enlaces

- Informe de análisis / SRS del caso: [08_informe_analisis.md](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-sigres/08_informe_analisis.md)
- Carpeta de esta entrega en GitHub: `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-sigres/`
- Otros enlaces de apoyo: [diagrama_clases.svg](./diagrama_clases.svg) · [diagrama_arquitectura.svg](./diagrama_arquitectura.svg) · [diagrama_componentes.svg](./diagrama_componentes.svg) · [diagrama_despliegue.svg](./diagrama_despliegue.svg)

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.
