# G1-P1 · Matriz requisito → caso de uso

Fuente de los requisitos: SRS de SIGRES del equipo (versión del 26/10/2026), sección «1. Requerimientos funcionales».

## 1. Distinción entre funcionales y no funcionales

- **Funcionales (RF01–RF17):** describen **qué hace** el sistema para un actor (registrar un pedido, generar una factura). Son los que se trazan a casos de uso.
- **No funcionales (RNF-01–RNF-31):** describen **cómo de bien** lo hace (5 s para que la comanda llegue a cocina, contraseñas cifradas, 95 % de disponibilidad). No generan casos de uso propios: se vuelven **restricciones o reglas** de los casos. En la sección 3 se muestra a qué casos afectan los más relevantes para el flujo crítico.
- **Requisitos de interfaz (IU, IH, IS, IC):** son restricciones de diseño. No se trazan a casos de uso; se retoman en la guía 2 (diseño).

## 2. Matriz RF → CU

| RF | Nombre en el SRS | Caso(s) de uso | Cobertura | Observación del análisis |
|---|---|---|---|---|
| RF01 | Registro de usuarios | CU-03 Gestionar usuarios y roles | Total | Se agrupa con RF03 (mismo actor y mismo objeto). Corregido: el criterio de aceptación decía «nombre y apellido» para iniciar sesión; se usa **nombre de usuario** (hallazgo H8). |
| RF02 | Inicio de sesión | CU-01 Iniciar sesión; CU-02 Recuperar contraseña | Total | El bloqueo tras 5 intentos fallidos queda como excepción de CU-01. |
| RF03 | Gestión de roles y permisos | CU-03 Gestionar usuarios y roles | Total | Se agrega el rol **Cocina**, que faltaba en RF01 y RF03 (hallazgo H1). |
| RF04 | Registrar pedido (comanda) | CU-06 Registrar pedido | Total | Caso crítico. Plantilla y diagrama de actividades en el P2. |
| RF05 | Enviar pedido a cocina | CU-07 Enviar comanda a cocina («include» de CU-06) | Total | Corregido: la ficha decía «Pedido registrado (desde RF05)»; la entrada viene de **RF04** (hallazgo H3). |
| RF06 | Consultar estado del pedido | CU-09 Consultar estado del pedido; CU-17 (lo incluye) | Total | Estados unificados con RF07 (hallazgo H2). |
| RF07 | Actualizar estado del pedido (cocina) | CU-08 Actualizar estado del pedido | Total | Caso crítico. Plantilla en el P2. |
| RF08 | Administrar productos del menú | CU-04 Gestionar menú | Total | CRUD agrupado (regla 1 de la sección 7 de la rúbrica). |
| RF09 | Gestionar categorías del menú | CU-04 Gestionar menú | Total | Las categorías se gestionan dentro del mismo objetivo: organizar el menú. |
| RF10 | Registrar y actualizar inventario | CU-10 Registrar movimiento de inventario | Total | Corregido: citaba «RF12 (Alertas)»; las alertas son **RF11** (H3). Se agrega el concepto **Receta** para que el descuento automático sea posible (H4). |
| RF11 | Alertas de existencias mínimas | CU-11 Emitir alerta de existencias mínimas («extend» de CU-10) | Total | Proceso automático: su iniciador es el caso base CU-10, que lo extiende. |
| RF12 | Generar factura | CU-12 Generar factura | Total | Caso crítico. Plantilla y diagrama de actividades en el P2. |
| RF13 | Procesar pago | CU-13 Procesar pago («include» de CU-12); CU-14 Dividir cuenta | Total | El SRS admitía un solo método por factura en RF13, pero su CU-07 permitía pago mixto y división. Se modela **factura con uno o varios pagos** (H7). |
| RF14 | Gestionar mesas | CU-05 Gestionar mesas; CU-06 (cambia el estado a «Ocupada»); CU-12/13 (la libera) | Total | Corregido: citaba «RF05 (Registrar pedido)»; es **RF04** (H3). |
| RF15 | Generar reportes de ventas | CU-15 Generar reportes de ventas | Total | Corregido: citaba «RF14 (Procesar pago), RF05 (Registrar pedido)»; son **RF13 y RF04** (H3). |
| RF16 | Ver menú digital (QR) | CU-16 Consultar menú digital | Total | Corregido: citaba «RF10 (Gestionar categorías)»; es **RF09** (H3). |
| RF17 | Consultar consumo actual (QR) | CU-17 Consultar consumo actual | Total | Corregido: se citaba a sí mismo como «RF17 (Ver menú digital)»; es **RF16** (H3). |

## 3. RNF que restringen los casos del flujo crítico

| RNF | Restricción | Casos afectados |
|---|---|---|
| RNF-02 | Cada rol solo ejecuta lo autorizado (5 roles, incluido Cocina) | Todos los casos de empleados |
| RNF-07 | Un pedido completo se registra en menos de 3 minutos | CU-06 |
| RNF-11 | Confirmar antes de acciones irreversibles (cancelar pedido, anular) | CU-06, CU-08, CU-12 |
| RNF-17 | La comanda aparece en cocina en 5 segundos o menos | CU-07, CU-08 |
| RNF-19 | Un pedido o pago confirmado no se pierde ante una falla | CU-06, CU-13 |
| RNF-06 | No se guardan datos personales sensibles del cliente | CU-16, CU-17 |

## 4. Indicador de cobertura

- Requisitos funcionales en el SRS: **17**
- Requisitos funcionales trazados a al menos un caso de uso: **17**
- **Cobertura: 17 / 17 = 100 %.** No hay requisitos funcionales sin cubrir que justificar.
