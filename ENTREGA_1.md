# **Dominio**

Una persona tiene

- un nombre,
- su edad que se mide en años,
- un nivel de stress que va de 0 a 100,
- una lista de sus preferencias, que indican si un destino le gusta (ver más adelante)
- y sus amigues

# **Punto 1: Datos de una persona**

## Puntos de scoring

Queremos saber los puntos de scoring de una persona, que se da de la siguiente manera:

- si tiene una cantidad par de amigues, multiplica el nivel de stress por la edad
- si en cambio tiene más de 40 años, multiplica la cantidad de amigues por la edad
- de lo contrario, es la cantidad de letras del nombre \* 2

Debe resolverlo utilizando guardas, composición y aplicación parcial.

## Casos de prueba que debe definir

En caso de que el grupo sea de un integrante, éste será el encargado de implementar los tests.

| **Condición** | **Debe ser** |
| --- | --- |
| Scoring de una persona con cantidad par de amigues, edad 25 y nivel de stress 10 | 250 |
| Scoring de una persona de 41 años y un amigue | 41 |
| Scoring de una persona de 31 años y un amigue, llamada "Rigoberta" | 18 |

# **Punto 2**

 **ATENCIÓN:** resolver únicamente con composición y aplicación parcial. **No se puede utilizar recursividad ni definir funciones auxiliares en ningún paso de este punto.** 

En los siguientes puntos se especifica el trabajo que debe resolver cada integrante, esto incluye implementar las funciones y sus casos de prueba. En caso de que el grupo tenga menos de 2 integrantes, solo resolver la parte que le corresponde a cada persona.

## Parte a: Nombre firme

Saber si una persona tiene un nombre firme, que son aquellos que comienzan con la letra P (como Pedro Velasco).

## Casos de prueba que debe definir

| **Condición** | **Qué se espera** |
| --- | --- |
| Una persona que se llama "Paulina" | Tiene un nombre firme |
| Una persona que se llama "Rigoberta" | No tiene un nombre firme |

Pregunta para la defensa de TP:

- ¿Qué nombre representa mejor la clase de equivalencia del test: paulina o personaNombreFirme? Justifique

## Parte b: Persona interesante

Saber si una persona es interesante, esto ocurre si tiene 2 ó más amigues

## Casos de prueba que debe definir

| **Condición** | **Qué se espera** |
| --- | --- |
| Una persona con 1 amigue. | No es interesante |
| Una persona con 2 amigues. | Es interesante. |

Pregunta para la defensa de TP:

- ¿Qué nombre le puso a la variable para el test de la persona interesante? ¿y a la no-interesante? Justifique.

# **Punto 3: Destinos**

Queremos modelar los siguientes destinos turísticos, que afectan de diferente manera a las personas:

- **Mar del Plata:** depende del mes, si es enero o febrero (mes 1 ó 2) aumenta el nivel de stress en 10, en el resto del año disminuye tanto como la edad de la persona hasta un máximo de 20.
- **Las Toninas:** si se va con plata disminuye el nivel de stress de la persona a la mitad, si se va sin plata equivale a haber ido a Mar del Plata en julio.
- **Puerto Madryn:** disminuye a 0 el nivel de stress y hace que tengas como amigue a Juan, que no tiene preferencias, no tiene amigues, edad = 37 y nivel de stress = 80.
- **La Adela:** no produce cambios en la persona que se va.

## Casos de prueba que debe definir

| **Condición** | **Qué se espera** |
| --- | --- |
| Una persona con nivel de stress 20 se va a Mar del Plata en Enero | Debe quedar con un nivel de stress de 30 |
| Una persona de edad 18 y stress 50 se va a Mar del Plata en marzo | Debe quedar con nivel de stress 32 |
| Una persona de edad 18 y stress 15 se va a Mar del Plata en marzo | Debe quedar con nivel de stress 0 |
| Una persona de edad 45 y stress 50 se va a Mar del Plata en marzo | Debe quedar con nivel de stress 30 |
| Una persona con stress 75 se va a Las Toninas con plata | Debe quedar con nivel de stress 38 (75 división entera por 2) = 37 |
| Una persona con stress 75 se va a Las Toninas sin plata | Debe quedar con nivel de stress 55 (75 - 20 como haberse ido a Mar del Plata en invierno) |
| Una persona sin amigues y stress 40 se va a Puerto Madryn | Debe quedar con nivel de stress 0 |
| Una persona sin amigues y stress 40 se va a Puerto Madryn | Debe quedar con un amigue |
| Una persona con nivel de stress 80 se va a La Adela | Debe quedar con el mismo nivel de stress: 80 |

# **Punto 4: Preferencias**

Ahora sí que tenemos los destinos, las preferencias marcan cuáles son los tipos de destinos que les gustan a las personas. Debe modelar las siguientes preferencias:

- **Desenchufarse**: las personas que tienen esta preferencia quieren que luego de viajar a ese destino su nivel de stress disminuya.
- **EnchufarseEspecial**: las personas que tienen esta preferencia quieren que luego de viajar su nivel de stress sea igual a un cierto valor que elles establezcan como parámetro (por ejemplo, quieren tener 20).
- **Socializar:** las personas que tienen esta preferencia quieren tener más amigues luego de viajar a ese destino.
- **SinPretensiones:** las personas que tienen esta preferencia les da lo mismo lo que pase después del viaje.

## Casos de prueba que debe definir

| **Condición** | **Qué se espera** |
| --- | --- |
| Preferencia desenchufarse para una persona que va a Mar del Plata en enero | No se cumple la preferencia (no queda con menos nivel de stress) |
| Preferencia desenchufarse para una persona que va a Mar del Plata en marzo | Se cumple (queda con menos nivel de stress) |
| Preferencia enchufarse con nivel de stress 20 para una persona de 22 años de edad, con nivel de stress 40 que va a Mar del Plata en marzo | Se cumple (queda con nivel de stress 20) |
| Preferencia enchufarse con nivel de stress 20 para una persona de 22 años de edad, con nivel de stress 45 que va a Mar del Plata en marzo | No se cumple (no queda con nivel de stress 20) |
| Preferencia socializar para una persona que va a Puerto Madryn | Se cumple (queda con más amigues) |
| Preferencia socializar para una persona que va a La Adela | No se cumple (no queda con más amigues) |
| Preferencia sinPretensiones para una persona que va a La Adela | Se cumple (no importa el destino ni la persona) |
