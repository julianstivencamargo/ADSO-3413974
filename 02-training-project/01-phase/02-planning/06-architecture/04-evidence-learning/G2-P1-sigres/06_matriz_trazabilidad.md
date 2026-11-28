# A7 · Matriz de trazabilidad (análisis → diseño)

**Proyecto:** SIGRES  
**Cobertura:** 17 / 17 requisitos funcionales del SRS (`RF01`–`RF17` = 100 %) y 6 requisitos no funcionales críticos trazados bidireccionalmente.

---

## 1. Trazabilidad de requisitos funcionales (`RF01`–`RF17`)

| Requisito | Nombre en SRS | Clase(s) en A2 | Tabla(s) en B2 | Componente(s) en A5 | Decisión / Patrón |
|---|---|---|---|---|---|
| `RF01` | Registro de usuarios | `Empleado`, `Administrador` | `usuario`, `telefono_usuario`, `rol` | Servicio Auth & RBAC | Hash + Sal (Argon2id/bcrypt) |
| `RF02` | Inicio de sesión | `Empleado` | `usuario` | Servicio Auth & RBAC | Token JWT + bloqueo 5 intentos |
| `RF03` | Gestión de roles y permisos | `Empleado`, `Administrador`, `Mesero`, `Cocinero`, `Cajero` | `rol`, `usuario` | Servicio Auth & RBAC | Middleware RBAC (5 roles) |
| `RF04` | Registrar pedido (comanda) | `Mesero`, `Pedido`, `DetallePedido`, `FachadaPedidoCocina` | `pedido`, `detalle_pedido` | Servicio Pedidos & Mesas | Patrón **Fachada** + Transacción ACID |
| `RF05` | Enviar pedido a cocina | `FachadaPedidoCocina`, `ComandaCocina` | `comanda_cocina` | Servicio Cocina (KDS) | Canal WebSocket (`WSS`) $\le 5\text{ s}$ |
| `RF06` | Consultar estado del pedido | `Pedido`, `ComandaCocina` | `pedido`, `comanda_cocina` | Servicio Pedidos & Mesas | Estados unificados |
| `RF07` | Actualizar estado del pedido (cocina) | `Cocinero`, `ComandaCocina` | `comanda_cocina`, `pedido` | Servicio Cocina (KDS) | Sincronización de estado KDS |
| `RF08` | Administrar productos del menú | `Administrador`, `Plato` | `plato` | Servicio Inventario & Menú | Caché de menú en memoria |
| `RF09` | Gestionar categorías del menú | `Administrador`, `Categoria`, `Plato` | `categoria`, `plato` | Servicio Inventario & Menú | Índice por `id_categoria` |
| `RF10` | Registrar y actualizar inventario | `Administrador`, `Insumo`, `RecetaInsumo`, `FachadaPedidoCocina` | `insumo`, `receta_insumo` | Servicio Inventario & Menú | Descuento atómico por receta |
| `RF11` | Alertas de existencias mínimas | `Insumo` | `insumo` | Servicio Inventario & Menú | Verificación de `stock_actual <= stock_minimo` |
| `RF12` | Generar factura | `Cajero`, `Factura`, `Pedido` | `factura`, `pedido` | Servicio Facturación & Caja | Composición `Factura *-- Pago` |
| `RF13` | Procesar pago | `Factura`, `Pago`, `EstrategiaPago` + 3 impl. | `pago`, `factura` | Servicio Facturación & Caja | Patrón **Estrategia** (pago mixto/dividido) |
| `RF14` | Gestionar mesas | `Mesa`, `Pedido` | `mesa`, `pedido` | Servicio Pedidos & Mesas | Agregación `Mesa o-- Pedido` |
| `RF15` | Generar reportes de ventas | `Gerente`, `ReporteVentas`, `Factura`, `DetallePedido` | `factura`, `pago`, `detalle_pedido` | Servicio Facturación & Caja | Agregaciones SQL con índices |
| `RF16` | Ver menú digital (QR) | `Plato` | `plato`, `categoria` | Servicio Inventario & Menú | Endpoint público solo lectura |
| `RF17` | Consultar consumo actual (QR) | `Pedido`, `DetallePedido` | `pedido`, `detalle_pedido` | Servicio Pedidos & Mesas | Consulta anónima por token de mesa |

---

## 2. Trazabilidad de requisitos no funcionales clave

| RNF | Descripción | Componente(s) en A5 / Nodo en A6 | Decisión de diseño |
|---|---|---|---|
| `RNF-02` | Control de acceso por rol | Servicio Auth & RBAC / Nodo Aplicación | Middleware JWT + RBAC antes de cualquier servicio |
| `RNF-06` | Privacidad y protección de datos | Proxy Nginx + Servicio Auth / Nodo Datos | TLS 1.3 en puerto 443; contraseñas con hash + sal |
| `RNF-07` | Pedido completo $\le 3\text{ min}$ | Servicio Pedidos & Mesas / Nodo Aplicación | Caché de menú + índices FK en PostgreSQL |
| `RNF-11` | Confirmación antes de anular/cancelar | UI Web SPA + Servicio Facturación | Diálogo de confirmación + registro de motivo |
| `RNF-17` | Latencia KDS $\le 5\text{ s}$ | Servicio Cocina (KDS) / Nodo Aplicación | WebSocket persistente (`WSS`) |
| `RNF-19` | No pérdida de pedidos ni pagos | Capa de Datos / Nodo Datos | Transacciones ACID y `ON DELETE RESTRICT` |

---

## 3. Verificación en sentido inverso (clases y tablas $\to$ requisitos)

Todas las clases del diagrama A2 (`Empleado`, `Administrador`, `Mesero`, `Cocinero`, `Cajero`, `Gerente`, `ReporteVentas`, `Mesa`, `Pedido`, `DetallePedido`, `Categoria`, `Plato`, `Insumo`, `RecetaInsumo`, `ComandaCocina`, `Factura`, `Pago`, `EstrategiaPago`, `PagoEfectivo`, `PagoTarjeta`, `PagoTransferencia`, `FachadaPedidoCocina`) y las 13 tablas del modelo B2 responden directamente a uno o más requisitos de la tabla anterior; no existen clases ni tablas huérfanas.
