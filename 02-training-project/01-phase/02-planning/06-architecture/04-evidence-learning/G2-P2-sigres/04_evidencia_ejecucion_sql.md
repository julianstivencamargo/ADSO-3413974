# B5 · Evidencia de ejecución del script SQL

**Script ejecutado:** [04_script_creacion_sigres.sql](./04_script_creacion_sigres.sql)  
**Motor empleado:** SQLite 3.50.4 (con `PRAGMA foreign_keys = ON;`)  
**Resultado:** 13 / 13 tablas creadas sin errores, inserción relacional completa verificada, restricciones `CHECK` y `ON DELETE RESTRICT` comprobadas activas.

---

## Log de ejecución verificado

```text
$ python scratch/verify_sql.py
SQLite version: 3.50.4
Tablas creadas (13): categoria, comanda_cocina, detalle_pedido, factura, insumo, mesa, pago, pedido, plato, receta_insumo, rol, telefono_usuario, usuario
Prueba de insercion relacional y pagos mixtos: OK (2 pagos en factura FAC-0001)
Validacion CHECK monto > 0 activa: CHECK constraint failed: ck_pago_monto
Validacion FK ON DELETE RESTRICT activa: FOREIGN KEY constraint failed
```

## Resumen de restricciones verificadas en el DDL

- **Llaves primarias (`PRIMARY KEY`):** presentes en el 100 % de las 13 tablas (`receta_insumo` con PK compuesta).
- **Llaves foráneas (`FOREIGN KEY`):** 14 llaves foráneas declaradas con acción referencial explícita (`ON DELETE RESTRICT` en `usuario`, `plato`, `receta_insumo`, `pedido`, `detalle_pedido`, `comanda_cocina`, `factura`, `pago`; `ON DELETE CASCADE` en `telefono_usuario`, `receta_insumo.id_plato`, `detalle_pedido.id_pedido`; `ON DELETE SET NULL` en `comanda_cocina.id_cocinero`).
- **Restricciones de unicidad (`UNIQUE`):** `rol.nombre`, `usuario.nombre_usuario`, `mesa.numero`, `categoria.nombre`, `plato.nombre`, `insumo.nombre`, `comanda_cocina.id_pedido`, `factura.id_pedido`, `factura.numero_factura`.
- **Restricciones de validación (`CHECK`):** 17 restricciones `CHECK` activas sobre estados, montos, precios, cantidades, capacidades y métodos de pago.
