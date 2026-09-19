# Límites de módulos

| Módulo | Propiedad | Datos | Entrada o API pública |
|---|---|---|---|
| `identity` | Autenticación y datos del instructor | `instructor` | `public/login.php`, `public/api/cerrar_sesion.php` |
| `academic` | Fichas, competencias, aprendices y seriales NFC | `ficha`, `competencia`, `aprendiz` | `public/Configurar_Sesion/Configurar.php`, `public/api/obtener_aprendices.php` |
| `attendance` | Sesiones y registros | `sesion_asistencia`, `asistencia` | `public/api/crear_sesion.php`, `registrar_asistencia.php`, `terminar_sesion.php` |

Dependencias permitidas:

```text
attendance -> academic
attendance -> identity
academic -> identity
```

Un módulo no debe consultar la lógica interna de otro. Las tablas mantienen las claves actuales por compatibilidad del MVP; la propiedad de escritura se documenta por módulo.
