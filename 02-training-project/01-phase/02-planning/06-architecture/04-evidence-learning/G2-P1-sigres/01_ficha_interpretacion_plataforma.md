# A1 · Ficha de interpretación del análisis y plataforma tecnológica

**Proyecto:** SIGRES — Sistema Integral de Gestión para Restaurantes  
**Insumo de análisis:** [Informe de análisis SIGRES (G1-P2)](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-sigres/08_informe_analisis.md) y [Matriz RF → CU (G1-P1)](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-sigres/03_matriz_requisito_caso_uso.md)

---

## 1. Requisitos funcionales y no funcionales seleccionados

### 1.1 Requisitos funcionales (12 seleccionados de los 17 RF del SRS)

| ID | Nombre en el SRS | Prioridad | Módulo / Flujo |
|---|---|---|---|
| `RF01` | Registro de usuarios (con rol asignado) | Alta | Seguridad y Administración |
| `RF02` | Inicio de sesión y bloqueo por intentos fallidos | Alta | Seguridad y Administración |
| `RF03` | Gestión de roles y permisos (incluye rol Cocina) | Alta | Seguridad y Administración |
| `RF04` | Registrar pedido (comanda de mesa) | Crítica | Operación de Salón |
| `RF05` | Enviar pedido a cocina | Crítica | Operación de Cocina (KDS) |
| `RF06` | Consultar estado del pedido | Alta | Salón / Cliente QR |
| `RF07` | Actualizar estado del pedido (cocina) | Crítica | Operación de Cocina (KDS) |
| `RF08` | Administrar productos del menú | Media | Catálogo y Menú |
| `RF10` | Registrar y actualizar inventario (recetas e insumos) | Alta | Inventario |
| `RF11` | Alertas de existencias mínimas | Media | Inventario |
| `RF12` | Generar factura | Crítica | Caja y Facturación |
| `RF13` | Procesar pago (único, mixto y división de cuenta) | Crítica | Caja y Facturación |
| `RF14` | Gestionar mesas (estado Libre/Ocupada) | Alta | Operación de Salón |
| `RF15` | Generar reportes de ventas | Media | Administración |

*(Además se trazan `RF09`, `RF16` y `RF17` en la matriz A7 para cobertura del 100 % del SRS).*

### 1.2 Requisitos no funcionales (6 seleccionados con métrica verificable)

| ID | Categoría | Restricción y métrica del SRS |
|---|---|---|
| `RNF-02` | Seguridad (Control de acceso) | Cada rol (`Administrador`, `Mesero`, `Cocinero`, `Cajero`) solo ejecuta operaciones autorizadas sobre sus recursos; cero acceso a rutas sin token válido. |
| `RNF-06` | Privacidad | No almacenar datos personales sensibles innecesarios del cliente final en consultas QR; contraseñas de empleados almacenadas únicamente con hash y sal. |
| `RNF-07` | Usabilidad / Rendimiento | El registro completo de un pedido en mesa debe completarse en $\le 3\text{ min}$ con respuesta de API $\le 500\text{ ms}$ p95. |
| `RNF-11` | Integridad operativa | Confirmación explícita obligatoria antes de acciones irreversibles (cancelar pedido en preparación o anular factura). |
| `RNF-17` | Tiempo real (Latencia) | La comanda confirmada por el mesero debe aparecer en la pantalla de cocina (KDS) en $\le 5\text{ segundos}$. |
| `RNF-19` | Confiabilidad (ACID) | Un pedido, descuento de inventario o pago confirmado no debe perderse ni quedar a medias ante un fallo concurrente. |

### 1.3 Actores y restricciones del entorno

* **Actores:** `Administrador`, `Mesero`, `Cocinero`, `Cajero` (empleados autenticados) y `Cliente` (consulta pública sin autenticación vía código QR en mesa).
* **Restricciones:** Equipo de 4 desarrolladores (ficha 3413974), presupuesto limitado de pyme gastronómica (despliegue inicial en un servidor VPS único con contenedores aislados), conectividad Wi-Fi local en restaurante para tabletas de meseros y pantalla de cocina.

---

## 2. Selección y justificación de la plataforma tecnológica

| Elemento | Decisión elegida | Justificación con base en condiciones concretas de SIGRES |
|---|---|---|
| **Lenguaje Orientado a Objetos** | **TypeScript** (sobre Node.js con arquitectura NestJS) | 1. **Unificación del equipo:** los 4 integrantes manejan JavaScript/TypeScript tanto en backend como en frontend web, reduciendo la curva de aprendizaje en sprints cortos.<br>2. **Soporte nativo en tiempo real (`RNF-17`):** el modelo asíncrono orientado a eventos facilita canales WebSocket estables para enviar comandas a la pantalla KDS en menos de 5 segundos.<br>3. **Tipado estático y POO formal:** interfaces, clases abstractas, inyección de dependencias y decoradores permiten aplicar limpiamente patrones GoF (Estrategia, Fachada) y separar capas.<br>4. **Bajo consumo en VPS único:** menor huella de memoria RAM que JVM para correr junto a la base de datos en un servidor pyme. |
| **Tipo de Base de Datos** | **Relacional (PostgreSQL)** | 1. **Transaccionalidad ACID (`RNF-19`):** el registro de factura con múltiples pagos (`FACTURA` $\to$ `PAGO`) y el descuento automático de insumos por receta requieren atomicidad estricta.<br>2. **Integridad referencial fuerte:** las relaciones `MESA` $\to$ `PEDIDO` $\to$ `DETALLE_PEDIDO` $\to$ `PLATO` $\to$ `RECETA_INSUMO` tienen esquema estable y dependen de llaves foráneas (`ON DELETE RESTRICT`).<br>3. **Consultas analíticas (`RF15`):** las agregaciones de ventas diarias, platos más vendidos y alertas de stock mínimo se resuelven de forma nativa con SQL estándar. |

---

## 3. Lista de entregables de diseño (Guía 2)

* **Producto 1 (`G2-P1-sigres`):** Ficha A1, Diagrama de Clases y Patrones (A2–A3), Arquitectura y tabla RNF (A4), Vista de Componentes (A5), Vista de Despliegue (A6) y Matriz de Trazabilidad análisis $\to$ diseño (A7).
* **Producto 2 (`G2-P2-sigres`):** Modelo Conceptual y Lógico con cuadro de transformación (B1–B2), Normalización 0FN $\to$ 3FN (B3), Diccionario de Datos (B4), Script SQL DDL con log de ejecución (B5), Políticas de Seguridad y matriz de roles (B6) y Lista de Chequeo con registro de hallazgos (B7).
