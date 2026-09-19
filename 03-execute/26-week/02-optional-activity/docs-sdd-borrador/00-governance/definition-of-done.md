# Definition of Done

Una historia se considera terminada cuando:

- Cumple todos sus criterios de aceptación.
- La validación de entradas y errores está implementada.
- Se probaron los casos exitoso, inválido y duplicado cuando corresponda.
- Los cambios de base de datos tienen un archivo SQL versionado.
- No se exponen credenciales ni archivos internos desde `public/`.
- La documentación afectada fue actualizada en el mismo cambio.
- La prueba funciona en XAMPP con PHP 8.2 y MariaDB.
- Otro integrante revisó el cambio y la rama principal queda estable.

Para NFC, además se verifica navegador compatible, HTTPS y una tarjeta registrada.
