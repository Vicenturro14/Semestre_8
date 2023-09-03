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
