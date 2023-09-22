let image_div = document.getElementById("image_div");
let info_div = document.getElementById("info_div");

let normal_image = document.getElementById("normal_image");
let big_image = document.getElementById("big_image");

let back_to_list_btn = document.getElementById("back_to_list_btn");

let is_big = false;
const change_image_size = () => {
    is_big = !is_big;
    info_div.hidden = !info_div.hidden;
    image_div.hidden = !image_div.hidden;
};

const back_to_list = () => {
    window.location.href = "../html/ver-artesanos.html";
};

normal_image.addEventListener("click", change_image_size);
big_image.addEventListener("click", change_image_size);
back_to_list_btn.addEventListener("click", back_to_list);