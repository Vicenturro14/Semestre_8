
const change_image_size = (element_id) => {
    image = document.getElementById(element_id);
    if (image.className == "normal_img") {
        image.className = "big_img";
    } else {
        image.className = "normal_img";
    }
};

