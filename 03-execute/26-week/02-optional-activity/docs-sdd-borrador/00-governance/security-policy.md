# Política de seguridad

Responsable: líder técnico del proyecto.

Reglas:

- Las contraseñas se verifican con `password_verify` y se almacenan con hash.
- `config/database.php` y sus credenciales permanecen fuera de `public/` y fuera de Git.
- Las consultas a datos recibidos usan sentencias preparadas.
- Las sesiones PHP se validan antes de operaciones del instructor.
- Los endpoints no deben confiar en identificadores enviados por el navegador.
- Los datos personales de aprendices solo se muestran a usuarios autorizados.
- La lectura NFC desde navegador se prueba bajo HTTPS y navegador compatible.
- Los errores de producción no muestran credenciales, consultas ni rutas internas.
- Las dependencias locales y de terceros se revisan antes de incorporarse.

Riesgo pendiente: revisar autorización por instructor en todos los endpoints y regenerar credenciales de ejemplo antes de producción.
