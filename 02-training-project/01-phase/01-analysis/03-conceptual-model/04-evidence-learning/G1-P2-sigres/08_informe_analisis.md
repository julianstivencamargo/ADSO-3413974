# G1-P2 · Informe de análisis (SIGRES)

**Caso de estudio:** SIGRES — Sistema Integral de Gestión para Restaurantes (ficha 3413974)  
**Autor del análisis individual:** `julianstivencamargo`  
**Insumo base:** SRS de SIGRES del equipo (26/10/2026) y `MockUp SIGRES.pptx` (semana 14).  
**Enfoque individual:** auditoría integral del SRS y modelado detallado del flujo crítico operativo **mesa → cocina → caja**.

---

## 1. Requisitos interpretados

El SRS del equipo define **17 requisitos funcionales** organizados en 8 módulos y **31 requisitos no funcionales** estructurados bajo IEEE 830 e ISO/IEC 25010:

- **Requisitos funcionales (RF01–RF17):**
  - *Seguridad y acceso (RF01–RF03):* registro de empleados, autenticación y control por 5 perfiles operativos (`Administrador`, `Mesero`, `Cocina`, `Cajero`, `Gerente`).
  - *Núcleo operativo en tiempo real (RF04–RF07, RF14):* administración de mesas (`Disponible` / `Ocupada`), toma de pedidos en mesa con observaciones especiales, despacho inmediato de comandas a cocina, seguimiento de estados y notificación de plato listo.
  - *Catálogo e inventario (RF08–RF11):* gestión de categorías y platos con disponibilidad inmediata, control de existencias de insumos con descuento automático por receta y alertas de stock mínimo.
  - *Cierre financiero y analítica (RF12–RF13, RF15):* facturación consecutiva, procesamiento de pagos (único, mixto y división de cuenta, cálculo de cambio en efectivo y propina voluntaria) y reportes de ventas.
  - *Autoservicio de consulta (RF16–RF17):* menú digital y consulta del consumo actual por código QR de la mesa sin registro ni facultad de ordenar directamente.
- **Requisitos no funcionales (31 RNF) e interfaces (`IU`, `IH`, `IS`, `IC`):**
  - *Seguridad (RNF-01–RNF-06):* contraseñas cifradas, control RBAC, comunicaciones HTTPS, consultas parametrizadas, expiración de sesiones (30 min web / 60 min móvil) y cumplimiento de la Ley 1581 de 2012 (sin almacenar datos sensibles de comensales).
  - *Usabilidad y rendimiento (RNF-07–RNF-17):* registro completo de pedido en menos de 3 minutos, interfaz responsive y áreas táctiles mínimas de 48×48 dp, respuestas de servicio ≤2 s (≤1 s en operaciones frecuentes), soporte para 20 usuarios concurrentes y actualización de cocina en ≤5 s.
  - *Fiabilidad, mantenibilidad y tecnología (RNF-18–RNF-31):* disponibilidad ≥95 % (07:00–23:00), transacciones atómicas ACID, respaldos diarios, arquitectura modular en capas, variables de entorno fuera del repositorio y despliegue con tecnologías libres (backend libre, motor relacional y app móvil compatible con Android 8.0+).

---

## 2. Inventario y enlaces a los modelos de análisis

| Entregable | Artefacto | Enlace |
|---|---|---|
| **P1** | Caracterización, comparación metodológica (Scrum seleccionada) y plan de 8 actividades | [01_caracterizacion_metodologia_plan.md](../G1-P1-sigres/01_caracterizacion_metodologia_plan.md) |
| **P1** | Diagrama integral UML de 17 casos de uso (fuente editable e imagen) y catálogo | [diagrama_casos_uso.drawio](../G1-P1-sigres/diagrama_casos_uso.drawio) · [diagrama_casos_uso.svg](../G1-P1-sigres/diagrama_casos_uso.svg) · [02_casos_de_uso.md](../G1-P1-sigres/02_casos_de_uso.md) |
| **P1** | Matriz requisito funcional → caso de uso (17 / 17 = 100 %) | [03_matriz_requisito_caso_uso.md](../G1-P1-sigres/03_matriz_requisito_caso_uso.md) |
| **P2** | 2 diagramas de actividades con calles, guardas y bifurcación/unión (`CU-06/07/08` y `CU-12/13/14`) | [01_diagramas_actividades.md](./01_diagramas_actividades.md) |
| **P2** | 3 plantillas extendidas de casos de uso críticos (`CU-06`, `CU-08`, `CU-12`) | [02_plantillas_extendidas.md](./02_plantillas_extendidas.md) |
| **P2** | Modelo de dominio conceptual (13 clases puras, 2 clases de asociación) | [03_modelo_dominio.md](./03_modelo_dominio.md) |
| **P2** | Modelo Entidad-Relación en Pata de Gallo (13 entidades, 2 N:M, 2 entidades débiles) | [04_modelo_entidad_relacion.md](./04_modelo_entidad_relacion.md) |
| **P2** | Prototipo inicial de 3 pantallas SVG rotuladas por caso de uso | [05_prototipo_inicial.md](./05_prototipo_inicial.md) |
| **P2** | Matriz de trazabilidad integral (Anexo C, 17 / 17 RF trazados al 100 %) | [09_matriz_trazabilidad.md](./09_matriz_trazabilidad.md) |

---

## 3. Resultado de la verificación

La validación se ejecutó con la lista de chequeo de **18 criterios verificables** ([06_lista_chequeo.md](./06_lista_chequeo.md)), incluyendo 5 criterios específicos de cobertura y trazabilidad:

- **Primera verificación (sobre el SRS base del equipo y mockup de la semana 14):** **10 criterios cumplidos (Sí) y 8 incumplidos (No)**. Se evidenciaron inconsistencias internas de redacción, referencias cruzadas rotas entre requisitos, estados del pedido incompatibles entre RF06 y RF07, omisión del rol Cocina en los requisitos de usuarios, mezcla de términos técnicos dentro de las plantillas y ausencia de una entidad puente que explicara el descuento de inventario por plato.
- **Segunda verificación (tras los ajustes individuales en G1-P1 y G1-P2):** **18 de 18 criterios cumplidos (100 %)** con evidencia enlazada a cada modelo y coherencia verificada entre flujos alternos de diagramas de actividades, plantillas extendidas, clases de dominio, entidades del MER y pantallas del prototipo.

---

## 4. Ajustes realizados y puntos para la Sprint Review

En [07_registro_ajustes.md](./07_registro_ajustes.md) quedaron documentados los **8 hallazgos corregidos (H1–H8)**:
1. Incorporación del rol **Cocina** en el catálogo de actores, reglas RBAC y generalización `Empleado` (**H1**).
2. Unificación del ciclo de estados de pedido en 5 valores consistentes (`Pendiente → En preparación → Listo → Entregado / Cancelado`) (**H2**).
3. Corrección de las 8 referencias cruzadas desplazadas entre fichas RF del SRS (**H3**).
4. Creación del concepto y tabla puente `RecetaInsumo` / `RECETA_INSUMO` para hacer viable el descuento automático de inventario al confirmar pedidos (**H4**).
5. Integración de los 8 diagramas modulares en una frontera única sin duplicados y con agrupación CRUD (**H5**).
6. Eliminación de términos técnicos de implementación dentro de las plantillas extendidas y del modelo de dominio (**H6**).
7. Separación `FACTURA 1 : 1..* PAGO` para soportar pago único, pago mixto y división de cuenta (`CU-14`), junto con la regla legal de propina voluntaria según Ley 1935 de 2018 (**H7**).
8. Unificación de la credencial de acceso (`nombreUsuario`) y creación de las pantallas faltantes de Cocina (`CU-08`) y Caja (`CU-12`) a partir de `MockUp SIGRES.pptx` (**H8**).

**Para llevar a la Sprint Review del 28/11 y a la Guía 2 (Diseño):** entregar formalmente al Product Owner los hallazgos **H1, H2, H3 y H8** para actualizar la versión 2.0 del SRS del equipo y partir de este MER validado en el diseño relacional y de arquitectura de la siguiente fase.
