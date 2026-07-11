# Sistema de Control de Asistencia — Conexión por Zona Wi-Fi (Hotspot + QR)

## Descripción General

### Situación actual

el instructor reporta que registrar la asistencia a través de Sofía Plus le quita bastante tiempo de clase, ya que debe ingresar aprendiz por aprendiz. A esto se suma que, cuando alguien llega después de iniciada la jornada.

### Propósito

Construir una herramienta que agilice el registro de asistencia usando una red inalámbrica local (hotspot) compartida por el instructor, de modo que cada aprendiz pueda registrarse por sí mismo al conectarse dentro del ambiente de formación, mientras el instructor conserva el control y la validación final del proceso.

---

# Propuesta de Solución

Se plantea una aplicación web en la que el aprendiz registra su asistencia conectándose al punto de acceso móvil (hotspot) que el instructor activa desde su computador. El instructor genera un código QR que contiene tanto los datos de conexión a esa red como el enlace a la página de registro; el aprendiz solo necesita escanearlo para conectarse y confirmar su presencia.

Funcionalidades principales:

* Inicio de sesión para instructores.
* Registro automático al conectarse al hotspot y confirmar en la página del sistema.
* Confirmación de presencia física a partir del alcance de la red del hotspot.
* Restricción de un solo registro por aprendiz en cada sesión.
* Opción de registro manual para casos particulares.
* Validación de justificaciones de tardanza por parte del instructor.
* Consulta de historial y generación de reportes.

---

# Descripción del Funcionamiento

## Apertura de la Sesión

### Pasos del instructor

1. Ingresa al sistema.
2. Selecciona la ficha correspondiente.
3. Selecciona la competencia a registrar.
4. Define el tiempo de tolerancia para el registro (15 minutos por defecto).
5. Activa el punto de acceso móvil desde su equipo.
6. Abre la sesión de asistencia; el sistema genera el código QR de acceso.

### Respuesta del sistema

1. Crea la sesión correspondiente.
2. Genera el código QR con los datos del hotspot y el enlace a la página de registro.
3. Habilita la página de autorregistro dentro de la red local del hotspot.
4. Marca como **Presente** a quienes se conecten y confirmen su asistencia dentro del tiempo de tolerancia.
5. Marca como **Retardo** a quienes se conecten y confirmen después de vencido ese tiempo, pero antes del cierre de la sesión.
6. Cierra automáticamente la sesión al completarse la duración de la jornada (por ejemplo, 5 horas y media o 6 horas), si el instructor no la cerró antes.

---

## Registro de Asistencia por Parte del Aprendiz

### Pasos del aprendiz

1. Escanea el código QR que comparte el instructor.
2. El dispositivo se conecta de forma automática a la red del hotspot.
3. Accede a la página de registro.
4. Ubica y confirma su nombre en la lista.
5. Recibe la confirmación de su registro.

### Respuesta del sistema

1. Comprueba que el dispositivo esté conectado a la red de la sesión activa.
2. Identifica al aprendiz seleccionado.
3. Confirma que la sesión siga activa.
4. Verifica que no exista un registro previo de ese aprendiz en la sesión.
5. Guarda la fecha y hora exacta del registro.
6. Muestra la confirmación correspondiente.

---

## Registro Manual

Se contempla para situaciones como:

* Aprendices sin conexión disponible o sin dispositivo compatible.
* Problemas con el hotspot o con la red.
* Aprendices que llegan después de cerrada la ventana de autorregistro.

## Manejo de Tardanzas

Cuando el registro —automático o manual— ocurre después del tiempo de tolerancia definido, el sistema:

1. Clasifica el registro como **Retardo** de forma automática.
2. Calcula cuánto tiempo de retraso tuvo.
3. Determina las horas de formación perdidas según los parámetros definidos por la institución.
4. Guarda esta información en el historial del aprendiz.

Si un aprendiz no logra registrarse antes del cierre de la sesión, queda marcado con estado **Ausente**.

### Pasos del instructor

1. Busca y selecciona al aprendiz.
2. Ingresa la hora real en que llegó.
3. Indica el motivo del registro manual.

### Respuesta del sistema

1. Guarda el registro de asistencia.
2. Calcula las horas de falla a partir de la hora de llegada ingresada.
3. Almacena el motivo señalado por el instructor.
4. Deja constancia del instructor responsable, la fecha y la hora de la acción.

---

## Validación de Justificaciones por Tardanza

Un aprendiz al que se le hayan calculado horas de falla por tardanza puede presentar un motivo que la justifique.

### Pasos del aprendiz o del instructor

1. Se ingresa el motivo de la tardanza en el sistema.

### Pasos del instructor

1. Revisa el motivo presentado.
2. Decide si lo acepta o lo rechaza.

### Respuesta del sistema

1. Conserva sin variación las horas de falla ya calculadas.
2. Si el instructor **aprueba** el motivo, marca la falla como **"Justificada"**.
3. Si el instructor **no aprueba** el motivo, marca la falla como **"No justificada"**.
4. Guarda la decisión tomada, el instructor responsable, la fecha y la hora.

---

# Aspectos de Seguridad

## Un solo registro por sesión

Cada aprendiz únicamente puede registrar su asistencia una vez por sesión.

Con esto se evita:

* Duplicidad de registros.
* Alteración de las estadísticas de asistencia.

## Validez limitada a la sesión activa

Los registros solo se aceptan mientras la sesión y el hotspot sigan activos.

Con esto se evita:

* Registros por fuera del horario de clase.
* Registros después de cerrada la sesión.

## Confirmación por cobertura de red

Únicamente los dispositivos conectados al hotspot del instructor pueden acceder a la página de registro, lo que permite confirmar que el aprendiz se encontraba físicamente en el ambiente de formación al momento de registrarse.

## Trazabilidad de acciones manuales y justificaciones

Cada registro manual y cada decisión sobre una justificación queda asociado a:

* El instructor que realizó la acción.
* La fecha.
* La hora.
* El motivo del registro o la decisión tomada.

Esto asegura que todas las acciones del instructor queden documentadas.

---

# Riesgos y Cómo se Atienden

## Aprendiz sin datos móviles ni Wi-Fi disponible

**Cómo se atiende**

* Se habilita el registro manual, autorizado por el instructor.

---

## Problemas con el hotspot o con la red

**Cómo se atiende**

* Se continúa el registro mediante el mecanismo manual mientras se soluciona el inconveniente.

---

## Cantidad de dispositivos que puede admitir el hotspot

**Cómo se atiende**

* Se ajusta la configuración del punto de acceso móvil del equipo del instructor para ampliar el número de dispositivos permitidos, según el tamaño de la ficha.

---

## Intentos de registrar la asistencia más de una vez

**Cómo se atiende**

* El sistema no permite registros duplicados.

## Aprendices que llegan tarde

**Cómo se atiende**

- El registro se clasifica automáticamente como **Retardo** una vez vencido el tiempo de tolerancia.
- Se calculan el tiempo de retraso y las horas de formación perdidas.
- El aprendiz puede presentar un motivo, y el instructor decide si la falla queda como justificada o no justificada.

