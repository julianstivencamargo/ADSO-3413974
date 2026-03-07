# Manual para realizar commits desde la terminal con Git

## 1. Introducción

**Git** es un sistema de control de versiones que permite gestionar los
cambios realizados en archivos de un proyecto a lo largo del tiempo. Es
ampliamente utilizado en el desarrollo de software para llevar un
historial de modificaciones, colaborar con otras personas y recuperar
versiones anteriores del proyecto cuando sea necesario.

Un **commit** es una confirmación de cambios en el repositorio. Cada
commit guarda una "foto" del estado actual del proyecto junto con un
mensaje que describe los cambios realizados.

El uso de control de versiones es importante porque permite:

-   Mantener un historial de cambios del proyecto.
-   Trabajar de manera colaborativa con otras personas.
-   Recuperar versiones anteriores si ocurre algún error.
-   Organizar y documentar el desarrollo del proyecto.

------------------------------------------------------------------------

## 2. Requisitos previos

Antes de realizar commits desde la terminal, es necesario contar con lo
siguiente:

-   Tener **Git instalado** en el sistema.
-   Tener acceso a una **terminal o consola**.
-   Tener un **repositorio Git creado o clonado**.

Para verificar si Git está instalado, ejecuta:

``` bash
git --version
```

Si Git está instalado correctamente, se mostrará la versión instalada.

------------------------------------------------------------------------

## 3. Configuración inicial de Git

Antes de comenzar a trabajar con Git, es recomendable configurar el
**nombre de usuario** y el **correo electrónico**, ya que esta
información se asociará a cada commit.

### Configurar nombre de usuario

``` bash
git config --global user.name "Tu Nombre"
```

### Configurar correo electrónico

``` bash
git config --global user.email "tuemail@ejemplo.com"
```

### Ver la configuración actual

``` bash
git config --list
```

La opción `--global` indica que la configuración se aplicará a todos los
repositorios del usuario.

------------------------------------------------------------------------

## 4. Flujo básico para realizar un commit

El proceso para crear un commit generalmente sigue tres pasos
principales.

### 1. Verificar el estado del repositorio

``` bash
git status
```

Este comando permite ver qué archivos han sido modificados o añadidos.

### 2. Agregar archivos al área de preparación (staging)

Agregar un archivo específico:

``` bash
git add archivo.txt
```

Agregar todos los archivos modificados:

``` bash
git add .
```

### 3. Crear el commit con un mensaje

``` bash
git commit -m "Descripción breve de los cambios realizados"
```

El mensaje debe describir claramente qué cambios se realizaron.

------------------------------------------------------------------------

## 5. Ejemplo completo

A continuación se muestra un ejemplo práctico.

### Paso 1: Verificar el estado

``` bash
git status
```

Salida posible:

    modified: index.html

### Paso 2: Agregar el archivo modificado

``` bash
git add index.html
```

### Paso 3: Crear el commit

``` bash
git commit -m "Se actualiza el contenido del archivo index.html"
```

Salida posible:

    [main 1a2b3c4] Se actualiza el contenido del archivo index.html
    1 file changed, 5 insertions(+), 2 deletions(-)

Esto indica que el commit fue creado correctamente.

------------------------------------------------------------------------

## 6. Buenas prácticas para mensajes de commit

Un buen mensaje de commit debe ser claro, breve y descriptivo.

### Recomendaciones

-   Usar frases cortas y claras.
-   Explicar **qué cambio se hizo**.
-   Usar verbos en presente.

### Ejemplos de buenos mensajes

    Agrega formulario de registro
    Corrige error en cálculo de precios
    Actualiza estilos de la página principal
    Elimina código duplicado

### Ejemplos de malos mensajes

    Cambios
    Update
    Arreglo

Los mensajes poco claros dificultan entender el historial del proyecto.

------------------------------------------------------------------------

## 7. Comandos útiles adicionales

### Ver estado del repositorio

``` bash
git status
```

### Ver historial de commits

``` bash
git log
```

### Ver diferencias entre cambios

``` bash
git diff
```

### Restaurar cambios en archivos

``` bash
git restore archivo.txt
```

Este comando descarta los cambios realizados en un archivo y lo restaura
a su última versión guardada.

------------------------------------------------------------------------

## 8. Conclusión

Realizar commits en Git es una práctica fundamental para el control de
versiones en cualquier proyecto. Los commits permiten guardar cambios de
manera organizada, mantener un historial claro del desarrollo y
facilitar el trabajo colaborativo.

Aprender a usar comandos como `git add`, `git commit` y `git status`
desde la terminal brinda mayor control sobre el repositorio y ayuda a
mantener un proyecto ordenado y bien documentado.
