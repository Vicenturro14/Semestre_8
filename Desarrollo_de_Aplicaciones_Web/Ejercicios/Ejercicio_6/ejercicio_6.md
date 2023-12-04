# Ejercicio 6: "*Spring Boot*"

**Nombre**: Vicente Olivares Gómez

---
## Observaciones
Tenga en cuenta las siguientes observaciones al realizar el ejercicio:

- El ejercicio es de carácter **personal**; la copia será penalizada con **nota mínima**.
- De ser necesario investigar, usted esta **autorizado a utilizar internet** como herramienta.
- El uso de modelos generativos de lenguaje como **ChatGPT está estrictamente prohibido** y será penalizado con **nota mínima**. 

## Pregunta 1

Como hemos visto en auxiliares previas, el *engine* de templates **Thymeleaf** permite a los desarrolladores crear "fragmentos" de HTML que pueden ser importados a distintas templates. El objetivo de esta pregunta es llevar a la practica lo anterior. Para ello ud. cuenta con una version incompleta de un fragmento en `fragment.html` y una version incompleta de una template en `index.html`. 

**Observacion:** Puede asumir que ambos archivos se encuentran en una misma carpeta.
 
**Respuesta:**
```html
<!-- fragment.html -->
<div th:fragment = "navbar">
  <nav class="navbar">  
      <a href="#home">Home</a>
      <a href="#about">About</a>
      <a href="#services">Services</a>
      <a href="#contact">C  ontact</a>
  </nav>
</div>
```

```html
<!-- index.html -->
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
  <head>
    [...]
  </head>
  <body>
    <!-- Aqui importar fragment.html -->
    <div th:replace="~{fragment :: navbar}"></div>
  </body>
</html>
```

## Pregunta 2

Investigue 3 ventajas de utilizar Spring Boot como *backend* en vez de Flask.

**Respuesta:** Usar Spring Boot como backend en vez de Flask tiene varias ventajas. En primer lugar, Spring Boot facilita el trabajo con la base de datos, ya que JPA permite representar tuplas de las bases de datos como objetos, mientras que con Flask se trabaja directamente con la base de datos con SQL. En segundo lugar, trabaja fuertemente con el patrón MVC que permite separar el código de manera modular, separando la lógica de la aplicación, la interacción con el usuario y el modelo de datos. Esto permite que el código sea más fácil de mantener. En cambio, Flask no tiene esta separación. Por último, Spring Boot es un framework en Java y Flask en Python, por lo que Spring Boot tiene mejor desempeño, ya que Python no tiene tan buen desempeño como Java, pues este último es un lenguaje compilado.

Fuentes: https://www.geeksforgeeks.org/10-reasons-to-use-spring-framework-in-projects/ y clase Auxiliar 10 