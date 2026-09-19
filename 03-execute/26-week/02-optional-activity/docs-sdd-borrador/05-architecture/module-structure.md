# Estructura de módulos

## Estructura actual

```text
public/
├── api/
├── Dashboard/
├── Configurar_Sesion/
├── Registrar_Aprendices/
└── assets/
src/core/
config/
db/
docs/
```

## Estructura objetivo gradual

```text
src/
├── identity/
│   ├── domain/
│   ├── application/
│   └── persistence/
├── academic/
│   ├── domain/
│   ├── application/
│   └── persistence/
├── attendance/
│   ├── domain/
│   ├── application/
│   └── persistence/
└── core/

public/api/
public/views/
config/
db/
tests/
```

`public/` es la única zona expuesta por Apache. Las credenciales, reglas de dominio y conexión permanecen fuera de ella.
