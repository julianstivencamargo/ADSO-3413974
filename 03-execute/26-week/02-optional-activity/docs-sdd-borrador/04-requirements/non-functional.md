# Requisitos no funcionales

| ID | Requisito | Medición | Estado |
|---|---|---|---|
| NFR-01 | El registro NFC debe responder rápidamente | 95% de respuestas en menos de 2 segundos | Por medir |
| NFR-02 | El sistema debe soportar grupos de hasta 40 aprendices | Prueba con 40 aprendices en una sesión | Por probar |
| NFR-03 | No debe haber duplicados | Índice único `(id_sesion, id_aprendiz)` | Implementado |
| NFR-04 | Las credenciales no deben estar en el document root | Revisión de `config/` y `.gitignore` | Parcial |
| NFR-05 | El acceso requiere autenticación de instructor | Pruebas de sesión para cada endpoint | Parcial |
| NFR-06 | NFC desde navegador requiere HTTPS y navegador compatible | Prueba en entorno HTTPS | Dependiente del entorno |
| NFR-07 | Los datos deben conservar fecha, sesión, aprendiz y método | Validación de columnas de `asistencia` | Implementado |
| NFR-08 | Los errores de API deben devolverse en JSON consistente | Prueba de respuestas HTTP y payloads | Parcial |
