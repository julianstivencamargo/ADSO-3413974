# Matriz de trazabilidad

| Requisito | Implementación | Evidencia o prueba | Estado |
|---|---|---|---|
| HU-01 | `public/login.php` | Credencial válida e inválida | Implementado |
| HU-02 | `public/Configurar_Sesion/Configurar.php` | Selects cargan desde MySQL | Implementado |
| HU-03 | `public/api/crear_sesion.php` | Inserción con ficha, competencia y tolerancia | Implementado |
| HU-04 | `public/api/obtener_aprendices.php` | Respuesta JSON con aprendices y registrados | Implementado |
| HU-05 | `public/api/registrar_asistencia.php` | Registro con método NFC | Implementado |
| HU-06 | `asistencia` y `registrar_asistencia.php` | Segundo registro devuelve duplicado | Implementado |
| HU-07 | `public/api/terminar_sesion.php` | Estado cambia a `CERRADA` | Implementado |
| HU-08 | Sin endpoint de registro manual | Debe crearse prueba de motivo y auditoría | Pendiente |
| HU-09 | Lógica de estado | El endpoint actual fija `PRESENTE` | Parcial |
| HU-10 | `public/Registrar_Aprendices/Registrar.html` | Flujo CRUD pendiente | Pendiente |
| HU-11 | Sin endpoint de historial | Consulta por sesión, aprendiz y fecha | Pendiente |
| HU-12 | Sin endpoint de reportes | Exportación y filtros | Pendiente |
| NFR-03 | `db/schema.sql` | Violación del índice único | Implementado |
| NFR-06 | Configuración de despliegue | Prueba con HTTPS y navegador compatible | Dependiente del entorno |
