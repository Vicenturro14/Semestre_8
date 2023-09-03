# Ejercicio 1

**Nombre**: Vicente Olivares Gómez
---

## Pregunta 1
Explique por que el realizar validaciones del input del usuario en el front-end es una facilidad pero no una medida de seguridad. 

**Respuesta**: Las validaciones del input del usuario en el front-end cuentan como medida de seguridad, porque estas pueden ser evadidas utilizando herramientas que ofrece el mismo navegador, viendo el destino de un post y luego con un programa externo realizar un post malicioso.

## Pregunta 2
Usted cuenta con el siguiente codigo HTML:
```html
<div>
    <p>Contador: <span id="contador">0</span></p>
    <button type="button" id="btn-resta">-1</button>
    <button type="button" id="btn-suma">+1</button>
</div>
```
Implemente un contador bidireccional utilizando la plantilla disponible mas abajo, solo programe donde se le indica. Se espera que tras apretar un boton, el contador se actualice sin la necesidad de recargar la pagina. **No esta permitido modificar el HTML**.

**Respuesta**:
```js
// se buscan los elementos necesarios
let addBtn = document.getElementById("btn-suma");
let subtrBtn = document.getElementById("btn-resta");
let cntr = document.getElementById("contador");

let n = 0; // contador

const suma = () => {
    // --> PROGRAME AQUI!<---
    n++;
    cntr.innerHTML = n;
};

const resta = () => {
    // --> PROGRAME AQUI!<---
    n--;
    cntr.innerHTML = n;
};

// asignar respectivamente la funciones al evento "click"
addBtn.addEventListener("click", suma);
subtrBtn.addEventListener("click", resta);

```
