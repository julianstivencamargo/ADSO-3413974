# A2 y A3 · Diagrama de clases UML y patrones de diseño

**Proyecto:** SIGRES  
**Imagen vectorial exportada:** [diagrama_clases.svg](./diagrama_clases.svg)  
**Fuente editable Mermaid:** incluida abajo y respaldada en `diagrama_clases.svg`

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
  class Plato {
    -idPlato: int
    -nombre: string
    -precio: number
    -disponible: boolean
    +actualizarDisponibilidad(estado: boolean) void
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

  Empleado <|-- Mesero
  Empleado <|-- Cocinero
  Empleado <|-- Cajero
  Mesero "1" --> "0..*" Pedido : atiende
  Mesa "1" o-- "0..*" Pedido : aloja
  Pedido "1" *-- "1..*" DetallePedido : contiene
  DetallePedido "0..*" --> "1" Plato : referencia
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
```

### Relación con los requisitos y separación de responsabilidades
* **Composición:** `Pedido *-- DetallePedido` y `Factura *-- Pago` (si se elimina el pedido o la factura, sus ítems o pagos no existen de forma aislada).
* **Agregación:** `Mesa o-- Pedido` (los pedidos históricos permanecen si se reconfigura una mesa).
* **Herencia y Polimorfismo:** `Empleado` generaliza a `Mesero`, `Cocinero` y `Cajero`. La interfaz `EstrategiaPago` tiene 3 implementaciones polimórficas (`PagoEfectivo`, `PagoTarjeta`, `PagoTransferencia`), por lo que `Factura.aplicarPago()` procesa pagos simples o mixtos sin conocer la lógica de cada medio.
* **Cohesión (Regla 5):** Ninguna clase mezcla interfaz gráfica, persistencia SQL ni notificaciones; las clases de dominio mantienen únicamente estado y reglas propias del negocio.

---

## 2. Catálogo de patrones de diseño aplicados (A3)

| Patrón GoF | Problema concreto del caso (SIGRES) | Por qué ese patrón | Clases que lo implementan | Qué mejora en mantenibilidad |
|---|---|---|---|---|
| **Estrategia (Strategy)** | `RF13` exige soportar pagos en efectivo, tarjeta, transferencia y pagos mixtos o divididos en una misma factura (`H7` del análisis). | Encapsula cada algoritmo de validación y generación de comprobante fuera de `Factura`, evitando condicionales `if/else` rígidos. | `EstrategiaPago` (interfaz), `PagoEfectivo`, `PagoTarjeta`, `PagoTransferencia` y contexto `Factura`. | Agregar un nuevo medio de pago (ej. billetera digital QR) requiere crear una sola clase nueva sin modificar ni probar de nuevo `Factura`. |
| **Fachada (Facade)** | `RF04` y `RF05` exigen que al confirmar un pedido en mesa se cree el pedido, se verifique disponibilidad en catálogo y se envíe la comanda a cocina en un solo paso atómico. | Ofrece un punto de entrada único de alto nivel para el controlador, ocultando la orquestación interna entre dominio de pedido, catálogo y cocina. | `FachadaPedidoCocina` coordinando `Pedido`, `Plato` y `ComandaCocina`. | Si cambia la regla de verificación de inventario o el canal de despacho KDS, la capa de presentación no sufre cambios. |
