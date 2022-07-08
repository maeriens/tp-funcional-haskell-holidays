# **Punto 5: Contingentes**

**ATENCIÓN:** resolver únicamente con composición, aplicación parcial y funciones de orden superior.

**No se puede utilizar recursividad en ningún paso de este punto.**

Un contingente es un grupo de personas que quiere armar un viaje.

## Destino apto

Queremos saber si un destino es apto para un contingente, esto significa que todos tienen preferencia por ese destino (esto es que alguna de las preferencias se cumple para dicho destino).

**Aclaración:** una persona que tiene 3 preferencias y en ninguna se verifica que el destino lo cumple, no tiene preferencia por ese destino. Si de sus preferencias, alguna de ellas verifica que el destino lo cumple (por ejemplo, socializar con Puerto Madryn), entonces decimos que la persona tiene preferencia por ese destino (no importa que las otras preferencias no se cumplan para ese mismo destino).

## Casos de prueba que debe definir

| **Condición** | **Debe ser** |
| --- | --- |
| Queremos saber si Mar del Plata en marzo es un destino apto para el siguiente contingente:<br> - una persona de nivel de stress 45, llamada Ariel, cuyas preferencias son desenchufarse y socializar, de 21 años y sin amigues<br> - una persona de nivel de stress 50, llamada Pedro, cuyas preferencias son sinPretensiones, 38 años y sin amigues | True (Mar del Plata en marzo cumple la preferencia desenchufarse y sinPretensiones, de Ariel y Pedro respectivamente) |
| Queremos saber si Mar del Plata en marzo es un destino apto para el siguiente contingente:<br> - una persona de nivel de stress 45, llamada Carola, cuya preferencia es socializar, 21 años y sin amiguesv<br> - una persona de nivel de stress 50, llamada Pedro, cuya preferencia es enchufarseEspecial a 10, 38 años y sin amigues | False (Mar del Plata en marzo no cumple la preferencia socializar, porque no te da más amigues ni enchufarseEspecial a 10 para un nivel de stress de 50) |

## Destino piola

Queremos saber si un destino es piola, esto ocurre cuando el total de stress de un contingente simulando que viajó a ese destino suma menos de 100.

Debe resolverlo utilizando únicamente composición, aplicación parcial y funciones de orden superior. No puede utilizar recursividad.

## Casos de prueba que debe definir

| **Condición** | **Debe ser** |
| --- | --- |
| Queremos saber si Mar del Plata en marzo es un destino piola para el siguiente contingente:<br> - una persona de nivel de stress 45, llamada Carola, cuya preferencia es socializar, 21 años y sin amigues<br> - una persona de nivel de stress 35, llamada Pedro, cuya preferencia es enchufarseEspecial a 10, 38 años y sin amigues | True (suma menos de 100) |
| Queremos saber si Mar del Plata en enero es un destino piola para el mismo contingente del test anterior.| False (suma justo 100) |

# **Punto 6: Paquete**

Un paquete es un conjunto de destinos turísticos.

**ATENCIÓN:** resolver únicamente con composición, aplicación parcial y funciones de orden superior. **No se puede utilizar recursividad ni definir funciones auxiliares**

**en ningún paso de este punto.**

## Parte a: Stress de un paquete

Queremos saber con cuánto nivel de stress queda la persona luego de ir a un conjunto de destinos turísticos.

## Casos de prueba que debe definir

| **Condición** | **Qué se espera** |
| --- | --- |
| Stress de un paquete turístico que incluye ir a Mar del Plata en marzo, a La Adela y a Las Toninas sin plata, para la siguiente persona: nivel de stress 90, de nombre Gustavo, sin preferencias, 25 años y sin amigues. | 50 |
| Stress de un paquete turístico vacío para la misma persona del test anterior. | 90 |

## Parte b: Alguna persona la pasa bien

Dado un contingente, queremos saber si alguna persona la pasa bien, esto ocurre si algún amigue de esa persona forma parte del contingente.

**Tip:** debe redefinir cuándo dos personas son iguales, de manera de comparar solamente por nombre.
 Casos de prueba que debe definir

| **Condición** | **Qué se espera** |
| -- | -- |
| Saber si alguna persona la pasa bien con el siguiente contingente:<br> - una persona que tiene de amigue a Juan<br> - otra persona que tiene de amigue a Juan<br> - Juan (de la entrega anterior) | True |
| Saber si alguna persona la pasa bien con el siguiente contingente:<br> - una persona que tiene de amigue a Juan<br> - otra persona que tiene de amigue a Juan | False |

# **Punto 7: Contingente TOC**

**ATENCIÓN:** debe resolver este punto con recursividad

Dado un contingente, queremos saber si los que están en la posición par tienen todos un scoring par. Debe funcionar para un contingente de personas par o impar.

## Casos de prueba que debe definir

| **Condición** | **Qué se espera** |
| --- | --- |
|Contingente TOC de una persona con scoring par|True (solo se chequea la primera posición par)|
|Contingente TOC de una persona con scoring impar|True (solo se chequea la primera posición par)|
|Contingente TOC de las siguientes personas:<br> - Persona con nivel de stress 50, de nombre Fabiana, sin preferencias, 41 años y un amigo: Juan<br> - Persona con nivel de stress 20, de nombre Rigoberta, sin preferencias, 31 años y un amigo: Juan<br> - Persona con nivel de stress 51, de nombre Verónica, sin preferencias, 11 años y un amigo: Juan<br> - Juan | True (los scorings son 41, 18, 16 y 2960) respectivamente, es decir, en la posición par están el 18 y el 2960|
|Contingente TOC de las siguientes personas:<br> - Juan<br> - Persona con nivel de stress 50, de nombre Fabiana, sin preferencias, 41 años y un amigo: Juan<br> - Persona con nivel de stress 20, de nombre Rigoberta, sin preferencias, 31 años y un amigo: Juan|False, porque los scorings son (2960, 41 y 18). En la única posición par está el 41 que no es par.|

# **Punto 8: Contingente infinito**

Defina un contingente infinito de personas.

¿Es posible determinar si alguna persona de ese contingente infinito la pasa bien? Justifique su respuesta.

¿Es posible saber si un destino es piola para ese contingente infinito? Justifique su respuesta