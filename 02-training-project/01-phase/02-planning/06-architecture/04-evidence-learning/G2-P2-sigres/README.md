# README de entrega · Guía 2: Diseño de la solución

## 1. Datos de la entrega

| Campo | Valor |
|---|---|
| Producto | P2 (modelo de datos y verificación) |
| Usuario de GitHub del autor | `julianstivencamargo` |
| Ficha | 3413974 |
| Caso elegido (nombre del proyecto) | SIGRES — Sistema Integral de Gestión para Restaurantes |
| Enlace al informe de análisis o SRS del caso (ruta en tu fork) | [08_informe_analisis.md](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-sigres/08_informe_analisis.md) |
| Cuenta de GitHub con la que haces los commits | `julianstivencamargo` |

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
|---|---|
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | Sí, el SRS base de SIGRES fue elaborado por el equipo formativo (`Equipo SIGRES`, 4 integrantes). El ajuste e informe de análisis individual se entregó en G1. |
| ¿Qué parte del SRS es tuya? | Participé en el levantamiento de requisitos de salón/pedidos, revisión de casos de uso y validación de flujo crítico mesa → cocina → caja. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | Sí. El modelo lógico relacional, la normalización 3FN, el diccionario de datos, el script SQL ejecutable, las políticas de seguridad y la lista de chequeo son de autoría individual. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No. |

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
|---|---|---|---|
| B1 y B2 Modelo conceptual y lógico | [01_modelo_conceptual_y_logico.md](./01_modelo_conceptual_y_logico.md) · [diagrama_modelo_logico.svg](./diagrama_modelo_logico.svg) | [04_modelo_entidad_relacion.md](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-sigres/04_modelo_entidad_relacion.md) | Transformé las entidades conceptuales al modelo lógico relacional de 13 tablas en `snake_case`, resolví los N:M y añadí la tabla `telefono_usuario` y el cuadro de transformación. |
| B3 Normalización 0FN → 3FN | [02_normalizacion_3fn.md](./02_normalizacion_3fn.md) | Nuevo | Documenté paso a paso (0FN → 1FN → 2FN → 3FN) con dependencias funcionales explícitas las tablas `pedido_detalle_sin_norm` (llave compuesta) y `factura_pago_sin_norm` (transitiva). |
| B4 Diccionario de datos | [03_diccionario_datos.md](./03_diccionario_datos.md) | Nuevo | Especifiqué el 100 % de las 13 tablas y columnas con estándar `snake_case`, tipo, tamaño, restricciones y dominio de negocio. |
| B5 Script SQL y evidencia | [04_script_creacion_sigres.sql](./04_script_creacion_sigres.sql) · [04_evidencia_ejecucion_sql.md](./04_evidencia_ejecucion_sql.md) | Nuevo | Implementé el DDL completo con PK, 14 FK con acciones `ON DELETE`/`ON UPDATE`, `UNIQUE`, 17 `CHECK` y ejecuté pruebas reales en SQLite 3.50.4 sin errores. |
| B6 Políticas de seguridad y roles | [05_politicas_seguridad.md](./05_politicas_seguridad.md) | Nuevo | Definí 9 políticas (3 por principio CID), contraseñas con hash+sal, TLS 1.3, Ley 1581, respaldo con prueba mensual y matriz de 4 roles. |
| B7 Lista de chequeo y hallazgos | [06_lista_chequeo_y_hallazgos.md](./06_lista_chequeo_y_hallazgos.md) | Nuevo | Evalué 22 criterios medibles sobre G2-P1 y G2-P2 con evidencia directa y registré 4 hallazgos (`H-01` a `H-04`) corregidos. |

**Qué reutilicé (resumen en 3 a 5 líneas):**
Reutilicé el modelo Entidad-Relación conceptual de 13 entidades de SIGRES elaborado en `G1-P2-sigres`, conservando las entidades de negocio (`ROL`, `USUARIO`, `MESA`, `CATEGORIA`, `PLATO`, `INSUMO`, `PEDIDO`, `COMANDA_COCINA`, `FACTURA`, `PAGO`) y las relaciones asociativas clave (`RECETA_INSUMO` y `DETALLE_PEDIDO`).

**Qué ajusté para llevarlo al estándar de la rúbrica (resumen en 3 a 5 líneas):**
Apliqué formalmente las reglas de transformación al modelo lógico relacional, extraje el atributo multivaluado de teléfonos a `telefono_usuario`, unifiqué la jerarquía `Empleado` en `usuario` con `id_rol` y corregí acciones referenciales (`ON DELETE SET NULL` en cocina).

**Qué hice completamente nuevo (resumen en 3 a 5 líneas):**
Elaboré desde cero la normalización paso a paso 0FN → 3FN con dependencias funcionales, el diccionario de datos al 100 %, el script SQL DDL ejecutable con su log de pruebas en SQLite, las 9 políticas de seguridad con matriz de 4 roles y la auditoría completa de 22 criterios.

## 4. Autoverificación de mínimos

- [x] B1 Modelo conceptual: ≥ 6 entidades, cardinalidades, ≥ 1 N:M y ≥ 1 1:N
- [x] B2 Modelo lógico: ≥ 8 tablas con PK/FK y cuadro de reglas de transformación
- [x] B3 Normalización: ≥ 2 tablas de 0FN a 3FN con dependencias funcionales (una con llave compuesta y una con dependencia transitiva)
- [x] B4 Diccionario de datos completo
- [x] B5 Script SQL ejecutado sin errores (evidencia adjunta) y `ON DELETE` en ≥ 3 FK
- [x] B6 ≥ 6 políticas de seguridad (con hash y sal en contraseñas y TLS) y matriz de ≥ 3 roles
- [x] B7 Lista de chequeo de ≥ 20 criterios, diligenciada sobre P1 y P2, con evidencia

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
|---|---|
| Jueves 26/11/2026 | [`2c9f91b`](https://github.com/julianstivencamargo/ADSO-3413974/commit/2c9f91b) · `feat(G2-P2): modelo conceptual, logico relacional, normalizacion 3FN y diccionario SIGRES` |
| Viernes 27/11/2026 | `docs(G2-P2): script SQL verificado, politicas de seguridad, lista de chequeo, ajustes Pata de Gallo y cierre README` |

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
|---|---|---|
| Antigravity (asistente IA) | Generar el diagrama SVG del modelo lógico, redactar las tablas de diccionario y estructurar la plantilla DDL SQL. | Ejecuté el script SQL en SQLite 3.50.4 verificando las 13 tablas, las 17 restricciones `CHECK` y la integridad referencial `ON DELETE RESTRICT` / `SET NULL`, y ajusté la redacción de hash+sal en seguridad. |

## 7. Enlaces

- Informe de análisis / SRS del caso: [08_informe_analisis.md](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-sigres/08_informe_analisis.md)
- Carpeta de esta entrega en GitHub: `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-sigres/`
- Otros enlaces de apoyo: [diagrama_modelo_logico.svg](./diagrama_modelo_logico.svg) · [04_script_creacion_sigres.sql](./04_script_creacion_sigres.sql) · [04_evidencia_ejecucion_sql.md](./04_evidencia_ejecucion_sql.md)

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.
