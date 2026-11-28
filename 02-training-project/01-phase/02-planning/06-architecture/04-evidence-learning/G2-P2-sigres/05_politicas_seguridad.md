# B6 · Políticas de seguridad de los datos y matriz de roles

**Proyecto:** SIGRES  
**Principios cubiertos:** Integridad, Confidencialidad y Disponibilidad (9 políticas concretas sobre las tablas del modelo).

---

## 1. Políticas de seguridad de los datos

| Principio | ID | Política concreta aplicada al caso SIGRES |
|---|---|---|
| **Integridad** | `POL-INT-01` | Todas las operaciones de cobro en `factura` y `pago`, así como el descuento de `insumo.stock_actual` mediante `receta_insumo`, se ejecutan dentro de transacciones ACID con restricciones `CHECK` (`monto > 0`, `stock_actual >= 0`). |
| **Integridad** | `POL-INT-02` | Las llaves foráneas críticas (`pedido` → `mesa`, `detalle_pedido` → `plato`, `factura` → `pedido`, `pago` → `factura`) usan `ON DELETE RESTRICT` para impedir la eliminación física de registros con historial comercial. |
| **Integridad** | `POL-INT-03` | Los cambios de estado en `comanda_cocina` y anulaciones en `factura` registran obligatoriamente el `id_usuario` autenticado y marca de tiempo (`hora_inicio`, `hora_listo`, `fecha_emision`). |
| **Confidencialidad** | `POL-CON-01` | Las contraseñas en `usuario.hash_contrasena` se almacenan exclusivamente mediante **hash criptográfico con sal única por usuario** (`Argon2id` o `bcrypt`, factor $\ge 12$), nunca en texto plano ni con cifrado reversible. |
| **Confidencialidad** | `POL-CON-02` | Todo el tráfico entre los dispositivos de meseros, caja, cocina, clientes QR y el proxy Nginx viaja cifrado mediante **TLS 1.3** (puerto `443`); el nodo de PostgreSQL (`5432`) permanece aislado en red privada sin acceso desde Internet. |
| **Confidencialidad** | `POL-CON-03` | **Tratamiento de datos personales (Ley 1581):** en `usuario` y `telefono_usuario` se recolectan únicamente los datos laborales necesarios con finalidad informada y autorización previa del titular; en el flujo QR (`RF16`–`RF17`) no se almacenan datos personales sensibles del comensal. |
| **Disponibilidad** | `POL-DIS-01` | Respaldo automático completo diario de `sigres_db` a las 02:00 a. m. (fuera de horario de servicio) con copia cifrada replicada en almacenamiento externo al servidor VPS. |
| **Disponibilidad** | `POL-DIS-02` | Respaldo incremental de transacciones (*WAL archiving*) cada 4 horas durante la jornada operativa del restaurante para garantizar RPO $\le 4\text{ h}$. |
| **Disponibilidad** | `POL-DIS-03` | **Prueba de restauración mensual** en ambiente aislado el primer domingo de cada mes, dejando acta de verificación de integridad de las 13 tablas y tiempos de recuperación. |

---

## 2. Matriz de permisos por rol contra tablas

| Rol | `usuario` | `plato` / `categoria` | `insumo` / `receta_insumo` | `pedido` / `detalle_pedido` | `comanda_cocina` | `factura` / `pago` |
|---|---|---|---|---|---|---|
| **Administrador** | `SELECT`, `INSERT`, `UPDATE` | `SELECT`, `INSERT`, `UPDATE`, `DELETE` | `SELECT`, `INSERT`, `UPDATE` | `SELECT` (solo lectura/auditoría) | `SELECT` | `SELECT` (reportes `RF15`) |
| **Gerente** | `SELECT` (solo lectura) | `SELECT` | `SELECT` | `SELECT` (auditoría) | `SELECT` | `SELECT` (reportes `RF15`) |
| **Mesero** | `SELECT` (solo su perfil) | `SELECT` | `SELECT` (solo disponibilidad) | `SELECT`, `INSERT`, `UPDATE` (pedidos activos de sus mesas) | `SELECT`, `INSERT` (envío inicial) | `SELECT` (estado de cuenta) |
| **Cocinero** | `SELECT` (solo su perfil) | `SELECT`, `UPDATE` (`disponible`) | `SELECT`, `UPDATE` (descuento por receta) | `SELECT` (solo ítems de comanda) | `SELECT`, `UPDATE` (`estado_cocina`, horas) | Sin acceso |
| **Cajero** | `SELECT` (solo su perfil) | `SELECT` | Sin acceso | `SELECT`, `UPDATE` (estado `'Pagado'`) | `SELECT` | `SELECT`, `INSERT` |
