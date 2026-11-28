# B4 · Diccionario de datos

**Proyecto:** SIGRES  
**Estándar de nombrado declarado:** Tablas en singular, identificadores y columnas en `snake_case`, llaves primarias con prefijo `id_<tabla>`. Todos los nombres, tipos, tamaños y restricciones coinciden 1:1 con [04_script_creacion_sigres.sql](./04_script_creacion_sigres.sql).

---

| Tabla | Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
|---|---|---|---|---|---|
| `rol` | `id_rol` | INTEGER | n/a | PK | Entero positivo identificador del rol |
| `rol` | `nombre` | VARCHAR | 40 | NOT NULL, UNIQUE, CHECK | `'Administrador'`, `'Mesero'`, `'Cocinero'`, `'Cajero'`, `'Gerente'` |
| `rol` | `descripcion` | VARCHAR | 150 | NOT NULL | Descripción de permisos del rol |
| `usuario` | `id_usuario` | INTEGER | n/a | PK | Entero positivo identificador del empleado |
| `usuario` | `id_rol` | INTEGER | n/a | FK → `rol.id_rol`, NOT NULL, ON DELETE RESTRICT | Rol operativo asignado |
| `usuario` | `nombre_usuario` | VARCHAR | 40 | NOT NULL, UNIQUE | Identificador único de inicio de sesión (`H8`) |
| `usuario` | `nombre_completo` | VARCHAR | 100 | NOT NULL | Nombre del empleado |
| `usuario` | `hash_contrasena` | VARCHAR | 255 | NOT NULL | Hash Argon2id/bcrypt con sal (nunca texto plano) |
| `usuario` | `activo` | BOOLEAN | n/a | NOT NULL, DEFAULT TRUE | Estado lógico de la cuenta |
| `usuario` | `fecha_creacion` | DATETIME | n/a | NOT NULL | Fecha y hora de registro |
| `telefono_usuario` | `id_telefono` | INTEGER | n/a | PK | Entero positivo identificador de teléfono |
| `telefono_usuario` | `id_usuario` | INTEGER | n/a | FK → `usuario.id_usuario`, NOT NULL, ON DELETE CASCADE | Usuario dueño del número |
| `telefono_usuario` | `numero` | VARCHAR | 20 | NOT NULL | Dígitos telefónicos de contacto |
| `telefono_usuario` | `tipo` | VARCHAR | 20 | NOT NULL, CHECK | `'Móvil'`, `'Fijo'`, `'Emergencia'` |
| `mesa` | `id_mesa` | INTEGER | n/a | PK | Entero positivo identificador de mesa |
| `mesa` | `numero` | INTEGER | n/a | NOT NULL, UNIQUE, CHECK (`> 0`) | Número físico de mesa en salón |
| `mesa` | `capacidad` | INTEGER | n/a | NOT NULL, CHECK (`> 0`) | Puestos disponibles |
| `mesa` | `estado` | VARCHAR | 20 | NOT NULL, CHECK | `'Libre'`, `'Ocupada'`, `'Reservada'` |
| `categoria` | `id_categoria` | INTEGER | n/a | PK | Entero positivo identificador de categoría |
| `categoria` | `nombre` | VARCHAR | 60 | NOT NULL, UNIQUE | Nombre de categoría del menú |
| `categoria` | `orden_visual` | INTEGER | n/a | NOT NULL, CHECK (`>= 0`) | Orden de presentación en menú QR |
| `plato` | `id_plato` | INTEGER | n/a | PK | Entero positivo identificador de plato |
| `plato` | `id_categoria` | INTEGER | n/a | FK → `categoria.id_categoria`, NOT NULL, ON DELETE RESTRICT | Categoría a la que pertenece |
| `plato` | `nombre` | VARCHAR | 100 | NOT NULL, UNIQUE | Nombre comercial del plato |
| `plato` | `descripcion` | VARCHAR | 250 | NULL | Descripción de ingredientes para cliente |
| `plato` | `precio` | DECIMAL | 10,2 | NOT NULL, CHECK (`> 0`) | Precio unitario en moneda local (COP) |
| `plato` | `disponible` | BOOLEAN | n/a | NOT NULL, DEFAULT TRUE | Disponibilidad inmediata en carta |
| `insumo` | `id_insumo` | INTEGER | n/a | PK | Entero positivo identificador de insumo |
| `insumo` | `nombre` | VARCHAR | 80 | NOT NULL, UNIQUE | Nombre del ingrediente o materia prima |
| `insumo` | `unidad_medida` | VARCHAR | 20 | NOT NULL | `'kg'`, `'g'`, `'L'`, `'ml'`, `'unidad'` |
| `insumo` | `stock_actual` | DECIMAL | 10,3 | NOT NULL, CHECK (`>= 0`) | Existencia real en bodega/cocina |
| `insumo` | `stock_minimo` | DECIMAL | 10,3 | NOT NULL, CHECK (`>= 0`) | Umbral de alerta (`RF11`) |
| `receta_insumo` | `id_plato` | INTEGER | n/a | PK, FK → `plato.id_plato`, ON DELETE CASCADE | Plato asociado |
| `receta_insumo` | `id_insumo` | INTEGER | n/a | PK, FK → `insumo.id_insumo`, ON DELETE RESTRICT | Insumo requerido |
| `receta_insumo` | `cantidad_porcion` | DECIMAL | 10,3 | NOT NULL, CHECK (`> 0`) | Cantidad descontada por cada unidad vendida |
| `pedido` | `id_pedido` | INTEGER | n/a | PK | Entero positivo identificador de pedido |
| `pedido` | `id_mesa` | INTEGER | n/a | FK → `mesa.id_mesa`, NOT NULL, ON DELETE RESTRICT | Mesa atendida |
| `pedido` | `id_mesero` | INTEGER | n/a | FK → `usuario.id_usuario`, NOT NULL, ON DELETE RESTRICT | Mesero que registra el pedido |
| `pedido` | `fecha_hora` | DATETIME | n/a | NOT NULL | Marca de tiempo de apertura |
| `pedido` | `estado` | VARCHAR | 25 | NOT NULL, CHECK | `'Pendiente'`, `'En preparacion'`, `'Listo'`, `'Entregado'`, `'Pagado'`, `'Cancelado'` |
| `pedido` | `observacion_general` | VARCHAR | 250 | NULL | Notas generales del pedido |
| `detalle_pedido` | `id_detalle_pedido` | INTEGER | n/a | PK | Entero positivo identificador de ítem |
| `detalle_pedido` | `id_pedido` | INTEGER | n/a | FK → `pedido.id_pedido`, NOT NULL, ON DELETE CASCADE | Pedido padre |
| `detalle_pedido` | `id_plato` | INTEGER | n/a | FK → `plato.id_plato`, NOT NULL, ON DELETE RESTRICT | Plato solicitado |
| `detalle_pedido` | `cantidad` | INTEGER | n/a | NOT NULL, CHECK (`> 0`) | Unidades pedidas |
| `detalle_pedido` | `precio_unitario` | DECIMAL | 10,2 | NOT NULL, CHECK (`> 0`) | Precio congelado al momento del pedido |
| `detalle_pedido` | `observaciones` | VARCHAR | 200 | NULL | Preferencias o notas para cocina |
| `comanda_cocina` | `id_comanda` | INTEGER | n/a | PK | Entero positivo identificador de comanda |
| `comanda_cocina` | `id_pedido` | INTEGER | n/a | FK → `pedido.id_pedido`, NOT NULL, UNIQUE, ON DELETE RESTRICT | Relación 1:1 con pedido |
| `comanda_cocina` | `id_cocinero` | INTEGER | n/a | FK → `usuario.id_usuario`, NULL, ON DELETE SET NULL | Cocinero que toma la comanda |
| `comanda_cocina` | `estado_cocina` | VARCHAR | 25 | NOT NULL, CHECK | `'Pendiente'`, `'En preparacion'`, `'Listo'` |
| `comanda_cocina` | `hora_envio` | DATETIME | n/a | NOT NULL | Hora de llegada al KDS |
| `comanda_cocina` | `hora_inicio` | DATETIME | n/a | NULL | Hora en que cocina inicia preparación |
| `comanda_cocina` | `hora_listo` | DATETIME | n/a | NULL | Hora en que cocina marca listo |
| `factura` | `id_factura` | INTEGER | n/a | PK | Entero positivo identificador de factura |
| `factura` | `id_pedido` | INTEGER | n/a | FK → `pedido.id_pedido`, NOT NULL, UNIQUE, ON DELETE RESTRICT | Pedido facturado (1:1) |
| `factura` | `id_cajero` | INTEGER | n/a | FK → `usuario.id_usuario`, NOT NULL, ON DELETE RESTRICT | Cajero emisor |
| `factura` | `numero_factura` | VARCHAR | 30 | NOT NULL, UNIQUE | Consecutivo fiscal único |
| `factura` | `fecha_emision` | DATETIME | n/a | NOT NULL | Fecha y hora de emisión |
| `factura` | `subtotal` | DECIMAL | 10,2 | NOT NULL, CHECK (`>= 0`) | Base gravable antes de impuestos |
| `factura` | `impuesto` | DECIMAL | 10,2 | NOT NULL, CHECK (`>= 0`) | Impoconsumo / IVA |
| `factura` | `propina` | DECIMAL | 10,2 | NOT NULL, CHECK (`>= 0`) | Propina voluntaria |
| `factura` | `descuento` | DECIMAL | 10,2 | NOT NULL, CHECK (`>= 0`) | Descuento comercial aplicado |
| `factura` | `total` | DECIMAL | 10,2 | NOT NULL, CHECK (`>= 0`) | Total neto a pagar |
| `pago` | `id_pago` | INTEGER | n/a | PK | Entero positivo identificador de pago |
| `pago` | `id_factura` | INTEGER | n/a | FK → `factura.id_factura`, NOT NULL, ON DELETE RESTRICT | Factura que cubre |
| `pago` | `metodo` | VARCHAR | 25 | NOT NULL, CHECK | `'Efectivo'`, `'Tarjeta'`, `'Transferencia'` |
| `pago` | `monto` | DECIMAL | 10,2 | NOT NULL, CHECK (`> 0`) | Valor abonado con ese medio |
| `pago` | `referencia` | VARCHAR | 80 | NULL | Número de aprobación o comprobante |
| `pago` | `fecha_pago` | DATETIME | n/a | NOT NULL | Marca de tiempo del pago |
