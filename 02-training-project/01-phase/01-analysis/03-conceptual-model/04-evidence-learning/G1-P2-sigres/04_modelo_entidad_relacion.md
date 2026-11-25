# G1-P2 · Modelo Entidad-Relación (MER)

**Caso de estudio:** SIGRES — Sistema Integral de Gestión para Restaurantes  
**Notación declarada:** **Pata de Gallo (Crow's Foot)** — Ingeniería de la Información.  

### Leyenda de notación (cardinalidad y participación)
- `||` : exactamente uno — **participación total (obligatoria)**, mínimo 1, máximo 1.
- `|o` / `o|` : cero o uno — **participación parcial (opcional)**, mínimo 0, máximo 1.
- `|{` / `}|` : uno o muchos — **participación total (obligatoria)**, mínimo 1, máximo N.
- `o{` / `}o` : cero o muchos — **participación parcial (opcional)**, mínimo 0, máximo N.

---

## 1. Diagrama Entidad-Relación (Pata de Gallo)

```mermaid
erDiagram
    ROL ||--o{ USUARIO : "asigna permisos a"
    USUARIO ||--o{ PEDIDO : "registra como mesero"
    MESA ||--o{ PEDIDO : "recibe"
    CATEGORIA ||--o{ PRODUCTO : "clasifica"

    %% Relación N:M #1 resuelta con entidad asociativa DETALLE_PEDIDO
    PEDIDO ||--|{ DETALLE_PEDIDO : "se desglosa en"
    PRODUCTO ||--o{ DETALLE_PEDIDO : "figura en"

    %% Entidad débil #1: dependencia de existencia de PEDIDO
    PEDIDO ||--|{ HISTORIAL_ESTADO_PEDIDO : "acumula trazas en"
    USUARIO ||--o{ HISTORIAL_ESTADO_PEDIDO : "ejecuta cambio en"

    %% Relación N:M #2 resuelta con entidad asociativa RECETA_INSUMO
    PRODUCTO ||--o{ RECETA_INSUMO : "consume segun"
    INSUMO ||--o{ RECETA_INSUMO : "participa en"

    INSUMO ||--o{ MOVIMIENTO_INVENTARIO : "registra kardex en"
    USUARIO ||--o{ MOVIMIENTO_INVENTARIO : "origina o autoriza"

    %% Facturación y entidad débil #2: PAGO depende de FACTURA
    USUARIO ||--o{ FACTURA : "emite como cajero"
    FACTURA |o--|{ PEDIDO : "consolida"
    FACTURA ||--|{ PAGO : "se recauda mediante"

    ROL {
        int id_rol PK
        string nombre UK
        string descripcion
    }

    USUARIO {
        int id_usuario PK
        int id_rol FK
        string nombre_completo
        string nombre_usuario UK
        string password_hash
        string telefono
        string estado
        datetime creado_en
    }

    MESA {
        int id_mesa PK
        string numero_mesa UK
        int capacidad
        string zona
        string estado
        string token_qr UK
    }

    CATEGORIA {
        int id_categoria PK
        string nombre UK
        string descripcion
        int orden_visualizacion
        boolean activa
    }

    PRODUCTO {
        int id_producto PK
        int id_categoria FK
        string nombre UK
        string descripcion
        decimal precio
        int tiempo_preparacion_min
        string estado_disponibilidad
    }

    PEDIDO {
        int id_pedido PK
        int id_mesa FK
        int id_mesero FK
        int id_factura FK "NULL hasta facturar"
        int numero_comensales
        string estado_actual
        datetime fecha_creacion
    }

    DETALLE_PEDIDO {
        int id_detalle PK
        int id_pedido FK
        int id_producto FK
        int cantidad
        decimal precio_unitario
        string observacion
        boolean es_adicional
    }

    HISTORIAL_ESTADO_PEDIDO {
        int id_historial PK
        int id_pedido FK
        int id_usuario_cambio FK
        string estado_anterior
        string estado_nuevo
        datetime fecha_hora
        string motivo
    }

    INSUMO {
        int id_insumo PK
        string nombre UK
        string categoria_insumo
        decimal stock_actual
        string unidad_medida
        decimal stock_minimo
        decimal costo_unitario
    }

    RECETA_INSUMO {
        int id_receta PK
        int id_producto FK
        int id_insumo FK
        decimal cantidad_requerida
        string unidad_medida
    }

    MOVIMIENTO_INVENTARIO {
        int id_movimiento PK
        int id_insumo FK
        int id_usuario FK
        int id_pedido FK "NULL si es ingreso manual"
        string tipo_movimiento
        decimal cantidad
        datetime fecha_hora
        string observacion
    }

    FACTURA {
        int id_factura PK
        int id_cajero FK
        string numero_consecutivo UK
        datetime fecha_emision
        decimal subtotal
        decimal impuestos
        decimal propina_voluntaria
        decimal total
        string estado_factura
    }

    PAGO {
        int id_pago PK
        int id_factura FK
        string metodo_pago
        decimal monto_pagado
        decimal monto_recibido
        decimal cambio_entregado
        datetime fecha_hora_pago
    }
```

---

## 2. Relaciones, cardinalidad, participación y justificación

| Relación | Entidad A (participación) | Entidad B (participación) | Cardinalidad | Clasificación y justificación |
|---|---|---|---|---|
| `ROL — USUARIO` | `ROL` (**parcial**, un rol recién creado puede no tener usuarios aún) | `USUARIO` (**total**, todo usuario tiene un rol activo; RN-03) | `1 : N` | Control de acceso RBAC (5 roles: Administrador, Mesero, Cocina, Cajero, Gerente). |
| `USUARIO — PEDIDO` | `USUARIO` (**parcial**, un cajero o gerente no toma pedidos) | `PEDIDO` (**total**, todo pedido tiene mesero responsable) | `1 : N` | Trazabilidad de quién tomó la orden. |
| `MESA — PEDIDO` | `MESA` (**parcial**, una mesa nueva o libre puede tener 0 pedidos) | `PEDIDO` (**total**, todo pedido pertenece a una mesa) | `1 : N` | Control de ocupación y consumo por mesa. |
| `CATEGORIA — PRODUCTO` | `CATEGORIA` (**parcial**, una categoría nueva puede no tener platos) | `PRODUCTO` (**total**, todo producto se ubica en una categoría) | `1 : N` | Organización del menú digital y de la app del mesero. |
| `PEDIDO — PRODUCTO` → **`DETALLE_PEDIDO`** | `PEDIDO` (**total**: mínimo 1 ítem; RN-02 de CU-04) | `PRODUCTO` (**parcial**: un plato nuevo puede no haberse pedido) | `N : M` resuelta | **Entidad asociativa con atributos propios:** `cantidad`, `precio_unitario` (congelado al pedir), `observacion` y `es_adicional`. |
| `PRODUCTO — INSUMO` → **`RECETA_INSUMO`** | `PRODUCTO` (**parcial**: bebidas empacadas pueden no desglosarse) | `INSUMO` (**parcial**: insumos recién creados sin asignar a plato) | `N : M` resuelta | **Entidad asociativa con atributos propios:** `cantidad_requerida` y `unidad_medida`. Resuelve el hallazgo H4 (hace posible el descuento automático de RF10). |
| `PEDIDO — HISTORIAL_ESTADO_PEDIDO` | `PEDIDO` (**total**: nace con registro `Pendiente`) | `HISTORIAL_ESTADO_PEDIDO` (**total**: no existe traza sin pedido) | `1 : N` | **Entidad débil por existencia:** conserva los tiempos entre `Pendiente`, `En preparación`, `Listo`, `Entregado` o `Cancelado` para RF07 y métricas. |
| `INSUMO — MOVIMIENTO_INVENTARIO` | `INSUMO` (**parcial**) | `MOVIMIENTO_INVENTARIO` (**total**) | `1 : N` | Bitácora de entradas por compra y salidas automáticas por pedido. |
| `FACTURA — PEDIDO` | `FACTURA` (**total**: toda factura liquida ≥1 pedido) | `PEDIDO` (**parcial**: un pedido en curso tiene `id_factura` nulo hasta cobrarse) | `1 : N` | Agrupa pedido inicial y adicionales de la mesa en una sola cuenta. |
| `FACTURA — PAGO` | `FACTURA` (**total**: en este flujo toda factura emitida se cobra con ≥1 pago) | `PAGO` (**total**: no existe pago sin factura que lo respalde) | `1 : N` | **Entidad débil por existencia:** soporta pagos únicos, pagos mixtos con varios métodos y liquidación de cuentas divididas (resuelve H7). |

---

## 3. Verificación contra los requisitos de datos del SRS
- **Seguridad e integridad (RNF-01, RNF-04, RNF-06):** `USUARIO` guarda `password_hash` (nunca texto plano) y no existe ninguna entidad que almacene datos personales sensibles de clientes comensales.
- **Trazabilidad financiera (RF12, RF13):** `FACTURA` garantiza `numero_consecutivo` único (`UK`), discrimina `propina_voluntaria` y delega el recaudo a `PAGO`.
- **Soporte a tiempo real y alertas (RF07, RF10, RF11):** `HISTORIAL_ESTADO_PEDIDO` registra cada timestamp de preparación y `INSUMO.stock_minimo` junto con `RECETA_INSUMO` soportan la alerta de existencias bajas.
