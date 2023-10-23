let go_to_index_btn = document.getElementById("go_to_index_btn")

const go_to_index = () => {
    window.location.href = "../html/index.html";
};

go_to_index_btn.addEventListener("click", go_to_index);