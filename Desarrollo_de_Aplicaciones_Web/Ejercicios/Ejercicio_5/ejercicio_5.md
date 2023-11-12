# Ejercicio 5

**Nombre**: Vicente Olivares Gómez

---
## Observaciones
Tenga en cuenta las siguientes observaciones al realizar el ejercicio:

- El ejercicio es de carácter **personal**; la copia será penalizada con **nota mínima**.
- De ser necesario investigar, usted esta **autorizado a utilizar internet** como herramienta.
- El uso de modelos generativos de lenguaje como **ChatGPT está estrictamente prohibido** y será penalizado con **nota mínima**. 

## Pregunta 1

HTTP es un protocolo *stateless*, esto significa que no existe ninguna relación entre dos pares (request, response). Esto es particularmente problematico al intentar mantener la coherencia entre una cadena de requests dependientes como por ejemplo el manipular un carrito de compras en un sitio de e-commerce. Como se ha mencionado en clases, una solución para este problema es el uso de **cookies**, las cuales nos permiten mantener un mismo contexto para varias requests. 

Si bien las cookies son muy utiles para mantener una o mas sesiones mientras nos comunicamos con un servidor web, el usarlas o no es una decision moralmente no trivial. En efecto, a lo largo del tiempo el uso de las cookies ha sido cuestionado en numerosas ocasiones.

El objetivo de esta pregunta es que usted investigue las razones por las que el uso de las cookies es controversial y las explique con sus propias palabras.

**Respuesta**: Las cookies, al guardar información para mantener un contexto entre varias requests, terminan guardando información posiblemente personal y sensible del cliente. La controversia de las cookies cae principalmente en el mal manejo y uso de esta información. Un caso de mal manejo se tiene en aquellas páginas que no están encriptadas, ya que terceros, como hackers, podrían interceptar esta información y utilizarla con malos propósitos, por ejemplo suplantar la identidad del cliente. Otro caso de mal manejo de la información es cuando dentro de las cookies de una página, hay cookies de terceros, causando que el cliente pierde el rastro de quién tiene acceso a su información, teniendo aun menos control de cómo se usará.

Fuente: https://us.norton.com/blog/privacy/should-i-accept-cookies


## Pregunta 2

Como vimos en el auxiliar, al usar la función **fetch** de Javascript estamos cargando un recurso desde una URL diferente a la que se esta usando. Por esto pueden haber problemas de Cross Origin Request Sharing o **CORS** por sus siglas en inglés.

Investigue y explique qué es CORS. Detalle por qué es importante este mecanismo (**Hint**: Las peticiones AJAX llevan las cookies que se tienen en el sitio objetivo). Nombre una cabecera HTTP de solicitud y una cabecera HTTP de respuesta asociado a este mecanismo.


**Respuesta**: CORS es un mecanismo que permite controlar el intercambio de recursos entre distintos dominios. Este se basa en cabezeras HTTP para poder restringir el intercambio que se desea realizar. Esta restricción puede ser por dominio que desea realizar el intercambio, por tipo de contenido, por métodos HTTP, por cabezeras HTTPP y otros. Las solicitudes de intercambio deben primero realizar una petición verificada antes de poder recibir el recurso deseado, esta consiste en una serie de cabezeras que indican información de la solicitud de intercambio, como es el dominio de origen, el método HTTP y otros. Por ejemplo las cabezeras correspondientes a la información rencién mencionada serían Origin y Access-Control-Request-Method respectivamente. Con esta petición, el servidor puede determinar si aceptará o no el intercambio de recursos y manda una respuesta con cabezeras que indican las restricciones que impone. Estas cabezeras pueden ser Access-Control-Allow-Origin, Access-Control-Allow-Methods u otras. Existen solicitudes simples que no requieren esta petición previa y el servidor responde directamente con el recurso solicitado, si es que cumple con las restricciones.

Fuente: https://developer.mozilla.org/es/docs/Web/HTTP/CORS