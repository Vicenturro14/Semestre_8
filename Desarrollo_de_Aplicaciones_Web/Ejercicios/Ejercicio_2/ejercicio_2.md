# Ejercicio 2

**Nombre**: Vicente Olivares Gómez

---

## Observaciones

Tenga en cuenta las siguientes observaciones al realizar el ejercicio:

- El ejercicio es de carácter **personal**; la copia será penalizada con **nota mínima**.
- De ser necesario investigar, usted esta **autorizado a utilizar internet** como herramienta.
- El uso de modelos generativos de lenguaje como **ChatGPT está estrictamente prohibido** y será penalizado con **nota mínima**. 

## Pregunta 1

¿Qué es el ataque de "Cross-Site Scripting" (XSS) y cómo podría prevenirse en el desarrollo front-end? Describa un escenario en el cual este tipo de ataque podría ser especialmente peligroso.

**Respuesta**: Un ataque de "Cross-Site Scripting" (XSS) es un tipo de inyección en el que un usuario malicioso inyecta un script a un sitio web y este puede terminar en el navegador de otro usuario que visite este sitio. Como es una inyección, este ataque suele realizarse enviando formularios maliciosos en algún input de la página web y una forma recomendada de prevenir un ataque XSS en el desarrollo front-end es utilizar frameworks o librerías de JavaScript seguras, es decir, APIs que ofrezcan métodos que permitan recibir y utilizar inputs de parte del usuario, quitando el riesgo de que puedan ser utilizados para introducir instrucciones de código válidas.

Un escenario en el que este tipo de ataque puede ser especialmente peligroso es cuando eñ sitio atacado es un banco, ya que el script malicioso puede acceder a las cookies del navegador relacionadas con el sitio, y si un usuario víctima tiene la mala práctica de guardar sus datos de inicio de sesión del banco en el navegador, el atacante podría obtener acceso a la cuenta bancaria de la víctima.

La información utilizada para responder esta pregunta fue obtenida desde:

- https://owasp.org/www-community/attacks/xss/
- https://owasp.org/www-community/Types_of_Cross-Site_Scripting


## Pregunta 2

Existen variadas librerías y *frameworks* de Javascript que se pueden utilizar para programar tareas más complejas en el Frontend y manipular el DOM con mayor facilidad. Investigue, nombre y describa 3 de las librerías o Frameworks de javascript más usados en el desarrollo web (por ejemplo, **JQuery**). Si tuviese que implementar su página web ¿Cuál utilizaría?   

**Respuesta**:

- React: Se trata de una librería para el desarrollo de interfaces que tiene como objetivo principal la reducción de la aparición de bugs al desarrollar una interfaz de usuario. Para el desarrollo web se suele utilizar junto a ReactDOM. Una de las caracteristicas que diferencian a React es que no es rígido respecto a las convenciones a la hora de programar ni con la estructura de la organización de archivos.
    - Fuente: https://developer.mozilla.org/en-US/docs/Learn/Tools_and_testing/Client-side_JavaScript_frameworks/React_getting_started

- Angular: Este es un framework basado en componentes para el desarrollo de páginas web escalables. Angular está diseñado para facilitar las actualizaciones, de manera que un proyecto de un solo desarrollador pueda escalar a un proyecto a de una empresa.

    - Fuente: https://developer.mozilla.org/en-US/docs/Learn/Tools_and_testing/Client-side_JavaScript_frameworks/Angular_getting_started

- JQuery: Es una librería rápida y pequeña de JavaScript que suministra métodos que permiten manejar eventos y manipular elementos del DOM usando su clase.
    - Fuente: https://api.jquery.com
