# A2 y A3 · Diagrama de clases UML y patrones de diseño

**Proyecto:** SIGRES  
**Imagen vectorial exportada:** [diagrama_clases.svg](./diagrama_clases.svg)  
**Fuente editable Mermaid:** incluida abajo en sincronía 1:1 con `diagrama_clases.svg`

---

## 1. Diagrama de clases (A2)

```mermaid
classDiagram
  class Empleado {
    <<abstract>>
    -idEmpleado: int
    -usuario: string
    -hashContrasena: string
    -activo: boolean
    +autenticar(clave: string) boolean
  }
  class Administrador {
    -nivelAcceso: string
    +gestionarMenu(plato: Plato) void
    +ajustarInsumo(insumo: Insumo, delta: number) void
  }
  class Mesero {
    -zonaAsignada: string
    +abrirPedido(mesa: Mesa) Pedido
  }
  class Cocinero {
    -estacionCocina: string
    +avanzarComanda(comanda: ComandaCocina, estado: string) void
  }
  class Cajero {
    -idCaja: int
    +emitirFactura(pedido: Pedido, propina: number) Factura
  }
  class Gerente {
    -sucursal: string
    +consultarReporteVentas(inicio: Date, fin: Date) ReporteVentas
  }
  class ReporteVentas {
    -fechaInicio: Date
    -fechaFin: Date
    -totalVentas: number
    -totalPropinas: number
    +calcularTotales(facturas: Factura[]) void
  }
  class Mesa {
    -idMesa: int
    -numero: int
    -capacidad: int
    -estado: string
    +cambiarEstado(nuevoEstado: string) void
  }
  class Pedido {
    -idPedido: int
    -fechaHora: Date
    -estado: string
    +agregarDetalle(plato: Plato, cantidad: int, obs: string) DetallePedido
    +calcularSubtotal() number
  }
  class DetallePedido {
    -idDetalle: int
    -cantidad: int
    -precioUnitario: number
    -observaciones: string
    +calcularImporte() number
  }
  class Categoria {
    -idCategoria: int
    -nombre: string
    -ordenVisual: int
  }
  class Plato {
    -idPlato: int
    -nombre: string
    -precio: number
    -disponible: boolean
    +actualizarDisponibilidad(estado: boolean) void
  }
  class Insumo {
    -idInsumo: int
    -nombre: string
    -unidadMedida: string
    -stockActual: number
    -stockMinimo: number
    +descontar(cantidad: number) void
    +estaEnMinimo() boolean
  }
  class RecetaInsumo {
    -cantidadPorcion: number
    +calcularConsumo(unidades: int) number
  }
  class ComandaCocina {
    -idComanda: int
    -estadoCocina: string
    -horaEnvio: Date
    -horaListo: Date
    +marcarEnPreparacion() void
    +marcarListo() void
  }
  class Factura {
    -idFactura: int
    -numeroFactura: string
    -subtotal: number
    -impuesto: number
    -propina: number
    -total: number
    +aplicarPago(estrategia: EstrategiaPago, monto: number) Pago
    +verificarSaldoPendiente() number
  }
  class Pago {
    -idPago: int
    -metodo: string
    -monto: number
    -referencia: string
    -fechaPago: Date
  }
  class EstrategiaPago {
    <<interface>>
    +procesarPago(monto: number, referencia: string) Pago
  }
  class PagoEfectivo {
    +procesarPago(monto: number, referencia: string) Pago
  }
  class PagoTarjeta {
    +procesarPago(monto: number, referencia: string) Pago
  }
  class PagoTransferencia {
    +procesarPago(monto: number, referencia: string) Pago
  }
  class FachadaPedidoCocina {
    +confirmarYDespachar(idMesa: int, idMesero: int, items: DetallePedido[]) ComandaCocina
  }

  Empleado <|-- Administrador
  Empleado <|-- Mesero
  Empleado <|-- Cocinero
  Empleado <|-- Cajero
  Empleado <|-- Gerente
  Gerente "1" --> "0..*" ReporteVentas : consulta
  ReporteVentas ..> Factura : consolida
  Mesero "1" --> "0..*" Pedido : atiende
  Mesa "1" o-- "0..*" Pedido : aloja
  Pedido "1" *-- "1..*" DetallePedido : contiene
  DetallePedido "0..*" --> "1" Plato : referencia
  Categoria "1" o-- "1..*" Plato : agrupa
  Plato "1" *-- "0..*" RecetaInsumo : define
  Insumo "1" <-- "0..*" RecetaInsumo : consume
  Pedido "1" --> "1" ComandaCocina : genera
  Cocinero "1" --> "0..*" ComandaCocina : despacha
  Pedido "1" --> "0..1" Factura : origina
  Cajero "1" --> "0..*" Factura : emite
  Factura "1" *-- "1..*" Pago : registra
  Factura ..> EstrategiaPago : usa
  EstrategiaPago <|.. PagoEfectivo
  EstrategiaPago <|.. PagoTarjeta
  EstrategiaPago <|.. PagoTransferencia
  FachadaPedidoCocina ..> Pedido : coordina
  FachadaPedidoCocina ..> ComandaCocina : emite
  FachadaPedidoCocina ..> Plato : verifica
  FachadaPedidoCocina ..> Insumo : descuenta
```

### Relación con los requisitos y separación de responsabilidades
* **Composición:** `Pedido *-- DetallePedido`, `Factura *-- Pago` y `Plato *-- RecetaInsumo` (los ítems, pagos y líneas de receta dependen del ciclo de vida de su contenedor).
* **Agregación:** `Mesa o-- Pedido` y `Categoria o-- Plato` (los pedidos históricos o platos permanecen si se reorganiza una mesa o categoría).
* **Herencia y Polimorfismo:** `Empleado` generaliza a `Administrador`, `Mesero`, `Cocinero` y `Cajero`. La interfaz `EstrategiaPago` tiene 3 implementaciones polimórficas (`PagoEfectivo`, `PagoTarjeta`, `PagoTransferencia`), por lo que `Factura.aplicarPago()` procesa pagos simples o mixtos sin conocer la lógica de cada medio.
* **Cohesión (Regla 5):** Ninguna clase mezcla interfaz gráfica, persistencia SQL ni reportes; las clases de dominio mantienen únicamente estado y reglas propias del negocio.

---

## 2. Catálogo de patrones de diseño aplicados (A3)

| Patrón GoF | Problema concreto del caso (SIGRES) | Por qué ese patrón | Clases que lo implementan | Qué mejora en mantenibilidad |
|---|---|---|---|---|
| **Estrategia (Strategy)** | `RF13` exige soportar pagos en efectivo, tarjeta, transferencia y pagos mixtos o divididos en una misma factura (`H7` del análisis). | Encapsula cada algoritmo de validación y generación de comprobante fuera de `Factura`, evitando condicionales `if/else` rígidos. | `EstrategiaPago` (interfaz), `PagoEfectivo`, `PagoTarjeta`, `PagoTransferencia` y contexto `Factura`. | Agregar un nuevo medio de pago (ej. billetera digital QR) requiere crear una sola clase nueva sin modificar ni probar de nuevo `Factura`. |
| **Fachada (Facade)** | `RF04`, `RF05` y `RF10` exigen que al confirmar un pedido en mesa se cree el pedido, se verifique disponibilidad en catálogo, se descuente inventario por receta y se envíe la comanda a cocina. | Ofrece un punto de entrada único de alto nivel para el controlador, ocultando la orquestación interna entre dominio de pedido, catálogo, inventario y cocina. | `FachadaPedidoCocina` coordinando `Pedido`, `Plato`, `Insumo` y `ComandaCocina`. | Si cambia la regla de verificación de inventario o el canal de despacho KDS, la capa de presentación no sufre cambios. |
