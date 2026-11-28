# B7 · Lista de chequeo de diseño y registro de hallazgos

**Proyecto:** SIGRES  
**Alcance:** 22 criterios medibles aplicados sobre los artefactos de **G2-P1** y **G2-P2**, más 4 hallazgos detectados y corregidos durante la verificación.

---

## 1. Lista de chequeo diligenciada (22 criterios)

| ID | Artefacto | Criterio de aceptación (medible) | Severidad | Cumple | Evidencia |
|---|---|---|---|---|---|
| `LC-01` | Clases (A2) | El diagrama incluye $\ge 8$ clases con atributos tipados, visibilidad y métodos con parámetros. | Mayor | Sí | [02_diagrama_clases_y_patrones.md](../G2-P1-sigres/02_diagrama_clases_y_patrones.md): 15 clases con visibilidad y tipos. |
| `LC-02` | Clases (A2) | Todas las asociaciones tienen multiplicidad explícita en ambos extremos. | Menor | Sí | `diagrama_clases.svg`: `1`, `0..*`, `1..*`, `0..1` visibles en cada enlace. |
| `LC-03` | Clases (A2) | Incluye $\ge 1$ composición o agregación y $\ge 1$ herencia o interfaz polimórfica ($\ge 2$ impl.). | Mayor | Sí | `Pedido *-- DetallePedido`, `Factura *-- Pago`, `Empleado <|-- Mesero/Cocinero/Cajero`, `EstrategiaPago` (3 impl.). |
| `LC-04` | Clases (A2) | Ninguna clase mezcla responsabilidades de UI, lógica de negocio, persistencia y reportes (Regla 5). | Crítico | Sí | Clases de dominio puras; coordinación en `FachadaPedidoCocina`; persistencia en repositorios. |
| `LC-05` | Clases (A2) | El 100 % de las clases traza a $\ge 1$ requisito funcional o no funcional. | Mayor | Sí | [06_matriz_trazabilidad.md](../G2-P1-sigres/06_matriz_trazabilidad.md) §3 (cero clases huérfanas). |
| `LC-06` | Patrones (A3) | Se aplican $\ge 2$ patrones GoF distintos en el diagrama (al menos uno distinto de Singleton). | Mayor | Sí | Patrones **Strategy** (`EstrategiaPago`) y **Facade** (`FachadaPedidoCocina`). |
| `LC-07` | Patrones (A3) | Cada patrón documenta problema concreto, clases participantes y mejora en mantenibilidad. | Menor | Sí | Tabla A3 en [02_diagrama_clases_y_patrones.md](../G2-P1-sigres/02_diagrama_clases_y_patrones.md). |
| `LC-08` | Arquitectura (A4) | El diagrama de arquitectura define el estilo en capas sin saltos entre presentación y datos. | Crítico | Sí | [03_arquitectura_software.md](../G2-P1-sigres/03_arquitectura_software.md): Presentación solo invoca Negocio vía HTTPS/WSS. |
| `LC-09` | Arquitectura (A4) | La tabla de decisiones atiende $\ge 3$ RNF con alternativa descartada y justificación. | Mayor | Sí | Tabla A4 cubre `RNF-02`, `RNF-07`, `RNF-17`, `RNF-19` y estilo de 3 capas. |
| `LC-10` | Componentes (A5) | La vista contiene $\ge 5$ componentes con interfaces provistas/requeridas y dependencias dirigidas. | Mayor | Sí | [04_vista_componentes.md](../G2-P1-sigres/04_vista_componentes.md): 6 componentes + PostgreSQL. |
| `LC-11` | Despliegue (A6) | La vista define $\ge 3$ nodos con artefactos alojados, protocolo y puerto en cada conexión. | Menor | Sí | [05_vista_despliegue.md](../G2-P1-sigres/05_vista_despliegue.md): 4 nodos (`443`, `3000`, `5432`). |
| `LC-12` | Trazabilidad (A7) | La matriz cubre $\ge 90\%$ de los RF hasta clases, tablas y componentes. | Mayor | Sí | 17/17 RF (`100 %`) trazados en A7. |
| `LC-13` | Conceptual (B1) | El modelo conceptual tiene $\ge 6$ entidades, cardinalidades mín/máx y relaciones N:M y 1:N. | Mayor | Sí | [01_modelo_conceptual_y_logico.md](./01_modelo_conceptual_y_logico.md): 10 entidades principales y relaciones N:M / 1:N. |
| `LC-14` | Lógico (B2) | El modelo lógico tiene $\ge 8$ tablas con PK/FK, tablas intermedias N:M y cuadro de transformación. | Crítico | Sí | 13 tablas (`detalle_pedido` y `receta_insumo` para N:M) y cuadro en §2. |
| `LC-15` | Normalización (B3) | Evidencia 0FN → 3FN de $\ge 2$ tablas propias (una con llave compuesta y otra transitiva) con DF. | Crítico | Sí | [02_normalizacion_3fn.md](./02_normalizacion_3fn.md): `pedido_detalle_sin_norm` y `factura_pago_sin_norm`. |
| `LC-16` | Normalización (B3) | No existen atributos multivaluados en una misma celda en el esquema final (1FN). | Crítico | Sí | `telefonos` extraído a `telefono_usuario`; pagos mixtos extraídos a `pago`. |
| `LC-17` | Diccionario (B4) | El 100 % de las tablas y columnas tiene nombre `snake_case`, tipo, tamaño, restricciones y dominio. | Mayor | Sí | [03_diccionario_datos.md](./03_diccionario_datos.md): 13 tablas documentadas al 100 %. |
| `LC-18` | Script SQL (B5) | El script crea el 100 % de las tablas con PK, FK, `NOT NULL`, `UNIQUE` y $\ge 3$ `CHECK`. | Crítico | Sí | [04_script_creacion_sigres.sql](./04_script_creacion_sigres.sql): 13 tablas, 17 `CHECK`. |
| `LC-19` | Script SQL (B5) | Declara `ON DELETE` / `ON UPDATE` en $\ge 3$ FK y adjunta log de ejecución sin errores. | Mayor | Sí | 14 FK con acción referencial + log real SQLite en `04_evidencia_ejecucion_sql.md`. |
| `LC-20` | Diccionario vs SQL | Nombres de tablas, columnas y tipos en B4 coinciden exactamente con el script SQL B5. | Crítico | Sí | Verificación 1:1 de las 13 tablas entre B4 y B5. |
| `LC-21` | Seguridad (B6) | Existen $\ge 6$ políticas ($\ge 2$ por principio CID) con hash+sal para contraseñas y tráfico TLS. | Crítico | Sí | [05_politicas_seguridad.md](./05_politicas_seguridad.md): 9 políticas (`POL-CON-01` Argon2id/sal, `POL-CON-02` TLS 1.3). |
| `LC-22` | Seguridad (B6) | Matriz de permisos de $\ge 3$ roles contra tablas y política de respaldo con prueba de restauración. | Mayor | Sí | 4 roles mapeados contra tablas + `POL-DIS-03` (prueba mensual con acta). |

---

## 2. Registro de hallazgos y correcciones aplicadas

| ID | Artefacto | Descripción del hallazgo | Requisito afectado | Severidad | Corrección propuesta y aplicada |
|---|---|---|---|---|---|
| `H-01` | Clases (A2) | Al diseñar `Factura`, se contempló inicialmente un método `procesarPagoPorTipo(tipo)` con condicionales internos, dificultando el pago mixto. | `RF13` | Mayor | Se extrajo la interfaz `EstrategiaPago` con 3 implementaciones (`PagoEfectivo`, `PagoTarjeta`, `PagoTransferencia`), aplicando el patrón **Strategy** (`LC-06`). |
| `H-02` | Modelo de datos (B2/B3) | El atributo de teléfonos de empleados (`telefonos_mesero`) aparecía en el borrador inicial como texto separado por comas, violando 1FN. | `RF01` | Crítico | Se creó la tabla independiente `telefono_usuario(id_telefono, id_usuario FK, numero, tipo)` con `ON DELETE CASCADE` (`LC-16`). |
| `H-03` | Script SQL (B5) | La FK `comanda_cocina.id_cocinero` tenía `ON DELETE RESTRICT` inicialmente; si un cocinero antiguo se retiraba del sistema no se podía reasignar ni desvincular su registro temporal. | `RF07` | Menor | Se ajustó `fk_comanda_cocinero` a `ON DELETE SET NULL` mientras las cuentas de empleados usan borrado lógico (`usuario.activo = FALSE`). |
| `H-04` | Políticas de seguridad (B6) | La primera versión de `POL-CON-01` mencionaba «contraseñas cifradas», término impreciso según la rúbrica de seguridad. | `RNF-06` | Crítico | Se corrigió explícitamente a **hash criptográfico con sal única por usuario (`Argon2id` / `bcrypt`)**, y se añadió la prueba de restauración mensual (`POL-DIS-03`). |
