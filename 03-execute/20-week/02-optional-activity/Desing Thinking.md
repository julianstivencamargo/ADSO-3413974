# DESING THINKING

## 1.Empatizar
    Se identifica que el agente de la aerolinea se le dificulta el proceso y registro (tener un seguimiento) de un ciclo de vida de un viaje aereo, desde que el pasajero realiza la reserva hasta que (o no) aborda el avion, en caso de un no-show (pasajeros que tienen tiquete emitido pero no viajaron) no tiene esa manera facil y rapida para consultarlos, asi que esos asientos quedaban vacios y generan una perdida de dinero para la aerolinea 
    
### Dolores identificados 
 -Asientos "muertos" por no-show.
 -Falta de trazabilidad del ciclo completo.
 -Riesgo de asignar el mismo asiento dos veces.	
 -Registro de equipaje desordenado

## 2.Definir
    El agente de la aerolinea busca la manera de que se le facilite el proceso y registros permitiendole realizar el seguimiento a el ciclo de vida de los viajes aeros a detalle a demas requiere de identificar eficazmente los no-show (pasajeros que tienen tiquete emitido pero no viajaron).

## 3. Idear 

-Búsqueda directa: Localización instantánea del pasajero digitando pasaporte o cédula.
Asistente paso a paso: Secuencia obligatoria y lineal: Reserva ➔ Tiquete ➔ Vuelo.
Filtro de asientos ocupados: Mapa del avión que oculta las sillas llenas y solo muestra las libres.
### 4. Prototipar

1. Login
2. Pasajeros
3. Reservas
4. Tiquetes
5. Vuelos
6. Asignacion de asientos
7. Pagos
8. Equipaje
9. Embarque
10. Reporte No-Show

### 5. Testear

pasos para el testeo 

- Inicio de sesion con credenciales validas e invalidas
- Creacion de un pasajero
- Creacion de una reserva
- Emision de un tiquete
- Creacion de un vuelo con origen y destino diferentes
- Intento de asignar el mismo asiento dos veces en el mismo vuelo (debe fallar)
- Registro de equipaje y pagos
- Registro de embarque
- Consulta del reporte de no-show, verificando que solo aparezcan los pasajeros con tiquete y sin registro de embarque
- Verificacion de que las operaciones criticas sean atomicas y mantengan la integridad de los datos