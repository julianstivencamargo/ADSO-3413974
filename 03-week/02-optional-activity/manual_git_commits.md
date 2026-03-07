# Manual Profesional para Realizar Commits desde la Terminal con Git

## 1. Introducción

En el desarrollo de software y en la gestión de proyectos digitales, es
fundamental llevar un control organizado de los cambios que se realizan
en los archivos. Para esto existe **Git**, un sistema de control de
versiones ampliamente utilizado en todo el mundo.

**Git** permite registrar cada cambio que se hace en un proyecto, de
modo que se pueda: - Revisar qué modificaciones se hicieron. - Volver a
versiones anteriores si ocurre algún error. - Trabajar en equipo sin
perder el control del proyecto.

Un **commit** es un registro que guarda los cambios realizados en los
archivos del proyecto en un momento específico. Es como tomar una
**fotografía del estado actual del proyecto** junto con un mensaje que
explica qué cambios se hicieron.

Cada commit crea un punto en el historial del proyecto, lo que permite
rastrear el progreso del desarrollo y entender cómo ha evolucionado el
código con el tiempo.

El uso de commits organizados es una práctica fundamental en proyectos
profesionales porque:

-   Permite mantener un historial claro de cambios.
-   Facilita el trabajo colaborativo entre desarrolladores.
-   Permite identificar errores rápidamente.
-   Mejora la organización y documentación del proyecto.

Este manual está diseñado para **personas que nunca han utilizado Git**,
explicando paso a paso cómo realizar commits desde la terminal.

------------------------------------------------------------------------

## 2. Requisitos Previos

Antes de comenzar a trabajar con Git desde la terminal, es necesario
contar con algunos elementos básicos.

### Tener Git instalado

Primero debes tener Git instalado en tu computador.

Para verificar si Git está instalado, abre la terminal y escribe:

``` bash
git --version
```

Si Git está correctamente instalado, aparecerá algo similar a:

    git version 2.x.x

------------------------------------------------------------------------

### Tener acceso a una terminal o consola

Git funciona principalmente desde la **terminal**, también conocida como
**línea de comandos**.

Dependiendo del sistema operativo, puedes usar:

-   Windows: PowerShell o Git Bash
-   Linux: Terminal
-   Mac: Terminal

------------------------------------------------------------------------

### Tener un repositorio Git

Un **repositorio** es la carpeta donde Git guarda el historial de
cambios del proyecto.

Existen dos formas comunes de obtener un repositorio:

Crear uno nuevo:

``` bash
git init
```

Clonar uno existente:

``` bash
git clone URL_DEL_REPOSITORIO
```

------------------------------------------------------------------------

## 3. Configuración Inicial de Git

Antes de comenzar a realizar commits, es importante configurar tu
identidad en Git. Esta información se registrará en cada commit que
realices.

### Configurar nombre de usuario

``` bash
git config --global user.name "Tu Nombre"
```

### Configurar correo electrónico

``` bash
git config --global user.email "correo@ejemplo.com"
```

### Verificar configuración

``` bash
git config --list
```

La opción `--global` indica que esta configuración se aplicará a todos
los repositorios del sistema.

------------------------------------------------------------------------

## 4. Flujo Básico para Realizar un Commit

El proceso para crear un commit en Git sigue tres pasos principales.

### Paso 1: Verificar el estado del repositorio

``` bash
git status
```

Este comando muestra:

-   Archivos modificados
-   Archivos nuevos
-   Archivos listos para commit

------------------------------------------------------------------------

### Paso 2: Agregar archivos al área de preparación (Staging)

Agregar un archivo específico:

``` bash
git add archivo.txt
```

Agregar todos los archivos modificados:

``` bash
git add .
```

------------------------------------------------------------------------

### Paso 3: Crear el commit

``` bash
git commit -m "Mensaje que describa los cambios"
```

Ejemplo:

``` bash
git commit -m "Se corrige error en el formulario de registro"
```

------------------------------------------------------------------------

## 5. Ejemplo Completo

Supongamos que editaste el archivo **index.html**.

1.  Revisar cambios:

``` bash
git status
```

2.  Agregar archivo:

``` bash
git add index.html
```

3.  Crear commit:

``` bash
git commit -m "Actualiza contenido de la página principal"
```

Salida posible:

    [main 8f72ab1] Actualiza contenido de la página principal
    1 file changed, 4 insertions(+), 1 deletion(-)

------------------------------------------------------------------------

## 6. Buenas Prácticas para Mensajes de Commit

Un buen mensaje de commit ayuda a entender rápidamente qué cambios se
realizaron.

### Recomendaciones

-   Escribir mensajes claros y específicos.
-   Usar frases cortas.
-   Describir qué cambio se hizo.
-   Evitar mensajes genéricos.

### Ejemplos de buenos commits

    Agrega validación al formulario
    Corrige error en cálculo de precios
    Actualiza diseño de la página principal
    Elimina código duplicado

### Ejemplos de malos commits

    Cambios
    Update
    Arreglo

------------------------------------------------------------------------

## 7. Comandos Útiles Adicionales

Ver estado del repositorio:

``` bash
git status
```

Ver historial de commits:

``` bash
git log
```

Ver diferencias entre cambios:

``` bash
git diff
```

Restaurar cambios en un archivo:

``` bash
git restore archivo.txt
```

------------------------------------------------------------------------

## 8. Conclusión

Aprender a utilizar Git desde la terminal es una habilidad fundamental
en el desarrollo moderno de software. Los commits permiten guardar
cambios de forma organizada, mantener un historial claro del proyecto y
facilitar el trabajo colaborativo.

Dominar comandos como `git status`, `git add` y `git commit` permite
tener control total sobre la evolución de un proyecto y mejorar la
gestión del código.
