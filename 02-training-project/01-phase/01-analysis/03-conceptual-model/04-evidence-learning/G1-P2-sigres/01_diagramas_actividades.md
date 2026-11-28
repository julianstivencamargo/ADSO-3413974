# G1-P2 · Diagramas de actividades (casos de uso críticos)

**Caso de estudio:** SIGRES — Sistema Integral de Gestión para Restaurantes  
**Casos modelados:** flujo crítico operativo mesa → cocina → caja (**CU-06**, **CU-07**, **CU-08**, **CU-12**, **CU-13** y **CU-14**).  
**Convención:** cada calle (*swimlane*) separa responsabilidades por actor; toda decisión lleva guardas entre corchetes `[condición]` cubriendo todas sus salidas; las ramas paralelas usan bifurcación (*Fork*) y unión (*Join*).

---

## 1. Diagrama de actividades 1 · Registrar pedido y ciclo en cocina (CU-06, CU-07 y CU-08)

Modela el recorrido completo desde que el mesero abre una comanda en mesa hasta que cocina prepara los platos y el mesero confirma la entrega al cliente. Incluye el manejo de mesa ocupada (adicionales), cancelación antes de confirmar, faltantes de inventario en cocina y ejecución paralela tras confirmar el pedido.

```mermaid
flowchart TD
    subgraph Mesero
        I1(( )) --> M1[Acceder a toma de pedidos y ver mapa de mesas]
        M1 --> M2[Seleccionar mesa del cliente]
        M3[Ingresar número de comensales] --> M4[Seleccionar platos, cantidades y notas especiales]
        M4 --> M5{Decisión del mesero}
        M5 -- "[cancelado antes de confirmar]" --> M_CANC[Descartar borrador de comanda]
        M_CANC --> F1((( )))
        M5 -- "[confirmado]" --> S_VAL
        M_RECH[Recibir aviso de error y ajustar pedido] --> M4
        M_NOTIF[Recibir notificación de pedido listo] --> M_ENT[Entregar platos al cliente en mesa]
        M_ALT[Informar al cliente y ofrecer alternativa] --> M4
    end

    subgraph Sistema["Sistema SIGRES"]
        M2 --> D_MESA{Estado de la mesa}
        D_MESA -- "[mesa disponible]" --> M3
        D_MESA -- "[mesa con pedido activo]" --> S_ADIC[Cargar pedido activo en modo adicional]
        S_ADIC --> M4

        S_VAL{Validar pedido y menú}
        S_VAL -- "[campos incompletos]" --> S_ERR1[Mostrar alerta de campos obligatorios]
        S_ERR1 --> M_RECH
        S_VAL -- "[producto agotado]" --> S_ERR2[Mostrar alerta de producto no disponible]
        S_ERR2 --> M_RECH
        S_VAL -- "[datos completos y productos disponibles]" --> S_REG[Registrar pedido con identificador y hora]

        S_REG --> FORK1[=== Bifurcación Fork ===]
        FORK1 --> P1[Publicar comanda en pantalla de cocina · CU-07]
        FORK1 --> P2[Cambiar estado de la mesa a Ocupada]
        FORK1 --> P3[Descontar insumos según receta y evaluar stock mínimo · CU-10 / CU-11]
        P1 --> JOIN1[=== Unión Join ===]
        P2 --> JOIN1
        P3 --> JOIN1
        JOIN1 --> S_CONF[Mostrar confirmación al mesero]

        S_AGOT[Marcar producto como no disponible y alertar al mesero] --> M_ALT
        S_NOTIF_M[Registrar hora de listo y notificar al mesero] --> M_NOTIF
        M_ENT --> S_CIERRE_ENT[Cambiar estado a Entregado y registrar hora]
        S_CIERRE_ENT --> F2((( )))
    end

    subgraph Cocina
        P1 --> C1[Visualizar comanda en cola FIFO]
        C1 --> C2{¿Insumos suficientes en estación?}
        C2 -- "[insumo agotado en cocina]" --> S_AGOT
        C2 -- "[insumos suficientes]" --> C3[Marcar pedido En preparación]
        C3 --> C4[Preparar platos según notas especiales]
        C4 --> C5[Marcar pedido como Listo]
        C5 --> S_NOTIF_M
    end
```

### Notas de diseño del Diagrama 1
- **Concurrencia explícita (Fork → Join):** al confirmarse el pedido, el sistema ejecuta de manera concurrente el despacho de la comanda a cocina (`CU-07`), el bloqueo visual de la mesa como `Ocupada` y el descuento de insumos por receta (`CU-10` con posible disparo de alerta `CU-11`).
- **Trazabilidad exacta con plantillas:** cada salida con guarda corresponde a un paso, flujo alterno o excepción de `CU-06` y `CU-08` en [02_plantillas_extendidas.md](./02_plantillas_extendidas.md).

---

## 2. Diagrama de actividades 2 · Facturar pedido y procesar pago (CU-12, CU-13 y CU-14)

Modela el cierre financiero de una mesa desde que el cajero consulta las cuentas activas hasta el pago completo (único o mixto, en efectivo o electrónico, con o sin división de cuenta y propina voluntaria) y la liberación de la mesa.

```mermaid
flowchart TD
    subgraph Cajero
        I2(( )) --> CJ1[Abrir módulo de Caja y Facturación]
        CJ1 --> CJ2[Seleccionar mesa con consumo por cobrar]
        CJ3[Revisar detalle de consumo e impuestos] --> CJ4{¿Cliente pide dividir cuenta?}
        CJ4 -- "[cuenta completa]" --> CJ5[Solicitar confirmación de propina voluntaria]
        CJ4 -- "[cliente solicita dividir cuenta]" --> S_DIV[Calcular montos parciales por comensal · CU-14]
        S_DIV --> CJ5
        CJ5 --> CJ6{Decisión sobre propina · Ley 1935}
        CJ6 -- "[propina voluntaria aceptada]" --> S_PROP[Sumar valor o porcentaje autorizado]
        CJ6 -- "[sin propina]" --> S_FAC[Emitir factura con consecutivo único]
        S_PROP --> S_FAC
        CJ7[Elegir esquema de pago] --> CJ8{¿Cantidad de métodos de pago?}
        CJ8 -- "[un método de pago]" --> CJ9[Seleccionar método y registrar valor]
        CJ8 -- "[pago mixto con varios métodos]" --> CJ9
        CJ_REINT[Corregir método o monto recibido] --> CJ8
    end

    subgraph Sistema2["Sistema SIGRES"]
        CJ2 --> D_PED{¿Estado de pedidos de la mesa?}
        D_PED -- "[sin pedidos activos o entregados]" --> E_SIN[Mostrar: No hay pedidos activos para esta mesa]
        E_SIN --> F3((( )))
        D_PED -- "[mesa con pedidos entregados sin facturar]" --> D_PAG{¿Factura ya pagada?}
        D_PED -- "[mesa con factura previa]" --> D_PAG

        D_PAG -- "[factura ya pagada]" --> E_DUP[Bloquear doble cobro: Factura ya procesada]
        E_DUP --> F4((( )))
        D_PAG -- "[factura pendiente de pago]" --> CJ3

        S_FAC --> CJ7

        CJ9 --> D_MET{Tipo de método seleccionado}
        D_MET -- "[método no seleccionado]" --> E_NOMET[Solicitar selección de método de pago]
        E_NOMET --> CJ_REINT

        D_MET -- "[pago en efectivo]" --> D_EF{¿Monto recibido cubre el saldo?}
        D_EF -- "[monto insuficiente]" --> E_INS[Mostrar error: Monto inferior al total]
        E_INS --> CJ_REINT
        D_EF -- "[monto recibido >= saldo]" --> S_VUELTO[Calcular cambio a entregar]
        S_VUELTO --> S_ABONO[Registrar pago y descontar saldo pendiente]

        D_MET -- "[pago electrónico]" --> D_EL{Resultado de confirmación}
        D_EL -- "[rechazado o sin confirmación]" --> E_RECH[Informar fallo y mantener saldo pendiente]
        E_RECH --> CJ_REINT
        D_EL -- "[confirmado]" --> S_ABONO

        S_ABONO --> D_SALDO{¿Saldo pendiente de la factura?}
        D_SALDO -- "[saldo restante > 0 en pago mixto]" --> CJ8
        D_SALDO -- "[saldo cubierto al 100 %]" --> FORK2[=== Bifurcación Fork ===]

        FORK2 --> Q1[Registrar ingreso en bitácora financiera y reportes]
        FORK2 --> Q2[Cambiar estado de la mesa a Disponible]
        FORK2 --> Q3[Generar comprobante de pago para el cliente]
        Q1 --> JOIN2[=== Unión Join ===]
        Q2 --> JOIN2
        Q3 --> JOIN2
        JOIN2 --> F5((( )))
    end
```

### Notas de diseño del Diagrama 2
- **Concurrencia explícita (Fork → Join):** una vez verificado que el saldo pendiente llegó a cero, el sistema consolida simultáneamente el registro financiero, la liberación de la mesa y la emisión del comprobante.
- **Separación legal y contable:** incluye de forma explícita la decisión de propina voluntaria (Ley 1935 de 2018) y el ciclo iterativo `[saldo restante > 0 en pago mixto]` para soportar pagos con dos o más métodos sin duplicar la factura.

---

## 3. Trazabilidad de ramas entre diagramas y plantillas

| Diagrama | Rama / guarda en el diagrama | Flujo en [02_plantillas_extendidas.md](./02_plantillas_extendidas.md) |
|---|---|---|
| Diagrama 1 | `[mesa con pedido activo]` | CU-06 · Flujo alterno `2a` (agregar ítems adicionales) |
| Diagrama 1 | `[cancelado antes de confirmar]` | CU-06 · Flujo alterno `5a` (cancelar productos antes de confirmar) |
| Diagrama 1 | `[campos incompletos]` | CU-06 · Excepción `4b` |
| Diagrama 1 | `[producto agotado]` | CU-06 · Excepción `4c` |
| Diagrama 1 | `[insumo agotado en cocina]` | CU-08 · Flujo alterno `2a` |
| Diagrama 2 | `[sin pedidos activos o entregados]` | CU-12 · Excepción `2b` |
| Diagrama 2 | `[factura ya pagada]` | CU-12 · Excepción `7b` |
| Diagrama 2 | `[cliente solicita dividir cuenta]` | CU-12 · Flujo alterno `3a` (extiende a CU-14) |
| Diagrama 2 | `[propina voluntaria aceptada]` / `[sin propina]` | CU-12 · Paso 3 y flujo alterno `4a` |
| Diagrama 2 | `[pago mixto con varios métodos]` / `[saldo restante > 0]` | CU-12 · Flujo alterno `5a` |
| Diagrama 2 | `[monto insuficiente]` | CU-12 · Excepción `5b` |
| Diagrama 2 | `[método no seleccionado]` / `[rechazado o sin confirmación]` | CU-12 · Excepción `5c` |
