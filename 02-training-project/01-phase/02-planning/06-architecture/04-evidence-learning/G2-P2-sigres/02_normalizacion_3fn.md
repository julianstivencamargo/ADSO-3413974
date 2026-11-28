# B3 · Evidencia de normalización paso a paso (0FN → 3FN)

**Proyecto:** SIGRES  
**Alcance:** Normalización completa de 2 tablas propias de SIGRES (una con **llave compuesta** para demostrar 2FN y una con **dependencia transitiva** para demostrar 3FN), con dependencias funcionales (DF) explícitas y estado antes/después.

---

## 1. Tabla 1: `pedido_detalle_sin_norm` (Llave compuesta: 0FN → 1FN → 2FN → 3FN)

### Estado inicial (0FN)
`pedido_detalle_sin_norm(id_pedido, id_plato, fecha_hora, id_mesa, numero_mesa, capacidad_mesa, id_mesero, nombre_mesero, telefonos_mesero, nombre_plato, precio_plato, id_categoria, nombre_categoria, cantidad, observaciones)`  
* **Llave primaria compuesta:** `(id_pedido, id_plato)`  
* **Anomalía inicial:** `telefonos_mesero` almacena varios números separados por coma en una sola celda (ej. `"3001112233, 3104445566"`).

### Paso a paso hacia 3FN

| Forma Normal | Violación detectada | Dependencias funcionales (DF) escritas | Estado resultante (después) |
|---|---|---|---|
| **1FN** (Atomicidad) | `telefonos_mesero` no es atómico (valores múltiples en una celda). | `id_mesero →→ telefonos_mesero` | Se extrae `telefono_usuario(id_telefono PK, id_usuario FK, numero)`. La tabla principal queda sin grupos repetitivos. |
| **2FN** (Dependencia parcial sobre llave compuesta) | `nombre_plato`, `precio_plato`, `id_categoria` y `nombre_categoria` dependen solo de `id_plato`. `fecha_hora`, `id_mesa`, `numero_mesa`, `id_mesero`, `nombre_mesero` dependen solo de `id_pedido`. | • `id_plato → nombre_plato, precio_plato, id_categoria, nombre_categoria`<br>• `id_pedido → fecha_hora, id_mesa, numero_mesa, capacidad_mesa, id_mesero, nombre_mesero`<br>• `(id_pedido, id_plato) → cantidad, observaciones` | Se separa en:<br>1. `plato(id_plato PK, id_categoria, nombre_categoria, nombre, precio)`<br>2. `pedido(id_pedido PK, fecha_hora, id_mesa, numero_mesa, capacidad_mesa, id_mesero, nombre_mesero)`<br>3. `detalle_pedido(id_detalle_pedido PK, id_pedido FK, id_plato FK, cantidad, precio_unitario, observaciones)` |
| **3FN** (Dependencia transitiva) | En `pedido`, `numero_mesa` y `capacidad_mesa` dependen de `id_mesa`, y `nombre_mesero` depende de `id_mesero`. En `plato`, `nombre_categoria` depende de `id_categoria`. | • `id_pedido → id_mesa → numero_mesa, capacidad_mesa`<br>• `id_pedido → id_mesero → nombre_mesero`<br>• `id_plato → id_categoria → nombre_categoria` | El esquema queda libre de dependencias transitivas:<br>• `mesa(id_mesa PK, numero, capacidad, estado)`<br>• `usuario(id_usuario PK, id_rol FK, nombre_completo, ...)`<br>• `categoria(id_categoria PK, nombre, orden_visual)`<br>• `plato(id_plato PK, id_categoria FK, nombre, precio)`<br>• `pedido(id_pedido PK, id_mesa FK, id_mesero FK, fecha_hora, estado)`<br>• `detalle_pedido(id_detalle_pedido PK, id_pedido FK, id_plato FK, cantidad, precio_unitario, observaciones)` |

---

## 2. Tabla 2: `factura_pago_sin_norm` (Dependencia transitiva: 0FN → 1FN → 2FN → 3FN)

### Estado inicial (0FN)
`factura_pago_sin_norm(id_factura, numero_factura, fecha_emision, id_pedido, id_mesa, id_cajero, nombre_cajero, id_rol_cajero, nombre_rol_cajero, subtotal, impuesto, propina, descuento, total, metodos_y_montos_pago)`  
* **Llave primaria:** `id_factura`  
* **Anomalía inicial:** `metodos_y_montos_pago` agrupa múltiples pagos en una sola cadena cuando el cliente realiza pago mixto (`"Efectivo: 30000; Tarjeta: 25000"`).

### Paso a paso hacia 3FN

| Forma Normal | Violación detectada | Dependencias funcionales (DF) escritas | Estado resultante (después) |
|---|---|---|---|
| **1FN** (Atomicidad) | `metodos_y_montos_pago` contiene varios pagos en una misma celda. | `id_factura →→ (metodo, monto, referencia)` | Se separa cada pago en filas individuales, creando la relación `1:N` hacia `pago(id_pago PK, id_factura FK, metodo, monto, referencia, fecha_pago)`. |
| **2FN** (Dependencia parcial) | Con `id_factura` como llave simple en `factura` e `id_pago` en `pago`, ningún atributo no primo depende parcialmente de la PK. | • `id_factura → numero_factura, fecha_emision, id_pedido, id_cajero, subtotal, impuesto, propina, total`<br>• `id_pago → id_factura, metodo, monto, referencia, fecha_pago` | Ambas tablas (`factura` y `pago`) cumplen 2FN. |
| **3FN** (Dependencia transitiva) | En `factura`, `nombre_cajero` depende de `id_cajero`, y `nombre_rol_cajero` depende transitivamente de `id_rol_cajero` (vía `id_cajero`). Además `id_mesa` depende transitivamente de `id_pedido`. | • `id_factura → id_cajero → nombre_cajero, id_rol_cajero`<br>• `id_cajero → id_rol_cajero → nombre_rol_cajero`<br>• `id_factura → id_pedido → id_mesa` | Se eliminan atributos redundantes de `factura`, quedando:<br>• `rol(id_rol PK, nombre, descripcion)`<br>• `usuario(id_usuario PK, id_rol FK, nombre_completo, ...)`<br>• `factura(id_factura PK, id_pedido FK UNIQUE, id_cajero FK, numero_factura, fecha_emision, subtotal, impuesto, propina, descuento, total)`<br>• `pago(id_pago PK, id_factura FK, metodo, monto, referencia, fecha_pago)` |

> **Nota sobre totales en `factura`:** Los campos `subtotal`, `impuesto` y `total` se persisten en `factura` como respaldo contable histórico de la emisión (para que un cambio futuro en el precio de un `plato` no altere facturas ya emitidas).
