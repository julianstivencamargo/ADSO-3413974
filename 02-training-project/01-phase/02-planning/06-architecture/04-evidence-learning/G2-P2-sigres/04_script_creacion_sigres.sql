-- B5 · Script SQL de creación del modelo lógico SIGRES (13 tablas en 3FN)
-- Compatible con SQLite 3.x / PostgreSQL (estándar ANSI SQL)

PRAGMA foreign_keys = ON;

CREATE TABLE rol (
  id_rol      INTEGER PRIMARY KEY,
  nombre      VARCHAR(40)  NOT NULL UNIQUE,
  descripcion VARCHAR(150) NOT NULL,
  CONSTRAINT ck_rol_nombre CHECK (nombre IN ('Administrador', 'Mesero', 'Cocinero', 'Cajero', 'Gerente'))
);

CREATE TABLE usuario (
  id_usuario      INTEGER PRIMARY KEY,
  id_rol          INTEGER      NOT NULL,
  nombre_usuario  VARCHAR(40)  NOT NULL UNIQUE,
  nombre_completo VARCHAR(100) NOT NULL,
  hash_contrasena VARCHAR(255) NOT NULL,
  activo          BOOLEAN      NOT NULL DEFAULT 1,
  fecha_creacion  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_usuario_rol FOREIGN KEY (id_rol)
    REFERENCES rol (id_rol) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE telefono_usuario (
  id_telefono INTEGER PRIMARY KEY,
  id_usuario  INTEGER     NOT NULL,
  numero      VARCHAR(20) NOT NULL,
  tipo        VARCHAR(20) NOT NULL,
  CONSTRAINT fk_tel_usuario FOREIGN KEY (id_usuario)
    REFERENCES usuario (id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT ck_tel_tipo CHECK (tipo IN ('Móvil', 'Fijo', 'Emergencia'))
);

CREATE TABLE mesa (
  id_mesa   INTEGER PRIMARY KEY,
  numero    INTEGER     NOT NULL UNIQUE,
  capacidad INTEGER     NOT NULL,
  estado    VARCHAR(20) NOT NULL DEFAULT 'Libre',
  CONSTRAINT ck_mesa_numero    CHECK (numero > 0),
  CONSTRAINT ck_mesa_capacidad CHECK (capacidad > 0),
  CONSTRAINT ck_mesa_estado    CHECK (estado IN ('Libre', 'Ocupada', 'Reservada'))
);

CREATE TABLE categoria (
  id_categoria INTEGER PRIMARY KEY,
  nombre       VARCHAR(60) NOT NULL UNIQUE,
  orden_visual INTEGER     NOT NULL DEFAULT 0,
  CONSTRAINT ck_cat_orden CHECK (orden_visual >= 0)
);

CREATE TABLE plato (
  id_plato     INTEGER PRIMARY KEY,
  id_categoria INTEGER       NOT NULL,
  nombre       VARCHAR(100)  NOT NULL UNIQUE,
  descripcion  VARCHAR(250),
  precio       DECIMAL(10,2) NOT NULL,
  disponible   BOOLEAN       NOT NULL DEFAULT 1,
  CONSTRAINT fk_plato_categoria FOREIGN KEY (id_categoria)
    REFERENCES categoria (id_categoria) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT ck_plato_precio CHECK (precio > 0)
);

CREATE TABLE insumo (
  id_insumo     INTEGER PRIMARY KEY,
  nombre        VARCHAR(80)   NOT NULL UNIQUE,
  unidad_medida VARCHAR(20)   NOT NULL,
  stock_actual  DECIMAL(10,3) NOT NULL DEFAULT 0,
  stock_minimo  DECIMAL(10,3) NOT NULL DEFAULT 0,
  CONSTRAINT ck_insumo_stock_actual CHECK (stock_actual >= 0),
  CONSTRAINT ck_insumo_stock_minimo CHECK (stock_minimo >= 0)
);

CREATE TABLE receta_insumo (
  id_plato         INTEGER       NOT NULL,
  id_insumo        INTEGER       NOT NULL,
  cantidad_porcion DECIMAL(10,3) NOT NULL,
  PRIMARY KEY (id_plato, id_insumo),
  CONSTRAINT fk_receta_plato FOREIGN KEY (id_plato)
    REFERENCES plato (id_plato) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_receta_insumo FOREIGN KEY (id_insumo)
    REFERENCES insumo (id_insumo) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT ck_receta_cantidad CHECK (cantidad_porcion > 0)
);

CREATE TABLE pedido (
  id_pedido           INTEGER PRIMARY KEY,
  id_mesa             INTEGER     NOT NULL,
  id_mesero           INTEGER     NOT NULL,
  fecha_hora          DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  estado              VARCHAR(25) NOT NULL DEFAULT 'Pendiente',
  observacion_general VARCHAR(250),
  CONSTRAINT fk_pedido_mesa FOREIGN KEY (id_mesa)
    REFERENCES mesa (id_mesa) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_pedido_mesero FOREIGN KEY (id_mesero)
    REFERENCES usuario (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT ck_pedido_estado CHECK (
    estado IN ('Pendiente', 'En preparacion', 'Listo', 'Entregado', 'Pagado', 'Cancelado')
  )
);

CREATE TABLE detalle_pedido (
  id_detalle_pedido INTEGER PRIMARY KEY,
  id_pedido         INTEGER       NOT NULL,
  id_plato          INTEGER       NOT NULL,
  cantidad          INTEGER       NOT NULL,
  precio_unitario   DECIMAL(10,2) NOT NULL,
  observaciones     VARCHAR(200),
  CONSTRAINT fk_detalle_pedido FOREIGN KEY (id_pedido)
    REFERENCES pedido (id_pedido) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT fk_detalle_plato FOREIGN KEY (id_plato)
    REFERENCES plato (id_plato) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT ck_detalle_cantidad CHECK (cantidad > 0),
  CONSTRAINT ck_detalle_precio   CHECK (precio_unitario > 0)
);

CREATE TABLE comanda_cocina (
  id_comanda    INTEGER PRIMARY KEY,
  id_pedido     INTEGER     NOT NULL UNIQUE,
  id_cocinero   INTEGER,
  estado_cocina VARCHAR(25) NOT NULL DEFAULT 'Pendiente',
  hora_envio    DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  hora_inicio   DATETIME,
  hora_listo    DATETIME,
  CONSTRAINT fk_comanda_pedido FOREIGN KEY (id_pedido)
    REFERENCES pedido (id_pedido) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_comanda_cocinero FOREIGN KEY (id_cocinero)
    REFERENCES usuario (id_usuario) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT ck_comanda_estado CHECK (estado_cocina IN ('Pendiente', 'En preparacion', 'Listo'))
);

CREATE TABLE factura (
  id_factura     INTEGER PRIMARY KEY,
  id_pedido      INTEGER       NOT NULL UNIQUE,
  id_cajero      INTEGER       NOT NULL,
  numero_factura VARCHAR(30)   NOT NULL UNIQUE,
  fecha_emision  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  subtotal       DECIMAL(10,2) NOT NULL,
  impuesto       DECIMAL(10,2) NOT NULL,
  propina        DECIMAL(10,2) NOT NULL DEFAULT 0,
  descuento      DECIMAL(10,2) NOT NULL DEFAULT 0,
  total          DECIMAL(10,2) NOT NULL,
  CONSTRAINT fk_factura_pedido FOREIGN KEY (id_pedido)
    REFERENCES pedido (id_pedido) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_factura_cajero FOREIGN KEY (id_cajero)
    REFERENCES usuario (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT ck_factura_montos CHECK (
    subtotal >= 0 AND impuesto >= 0 AND propina >= 0 AND descuento >= 0 AND total >= 0
  )
);

CREATE TABLE pago (
  id_pago    INTEGER PRIMARY KEY,
  id_factura INTEGER       NOT NULL,
  metodo     VARCHAR(25)   NOT NULL,
  monto      DECIMAL(10,2) NOT NULL,
  referencia VARCHAR(80),
  fecha_pago DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_pago_factura FOREIGN KEY (id_factura)
    REFERENCES factura (id_factura) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT ck_pago_metodo CHECK (metodo IN ('Efectivo', 'Tarjeta', 'Transferencia')),
  CONSTRAINT ck_pago_monto  CHECK (monto > 0)
);
