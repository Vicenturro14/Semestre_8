// Arreglo de regiones de Chile
const regions_array = [
    "Región Arica y Parinacota",
    "Región de Tarapacá",
    "Región de Antofagasta",
    "Región de Atacama",
    "Región de Coquimbo",
    "Región de Valparaíso",
    "Región Metropolitana de Santiago",
    "Región del Libertador Bernardo Ohiggins",
    "Región del Maule",
    "Región del Ñuble",
    "Región del Biobío",
    "Región de La Araucanía",
    "Región de Los Ríos",
    "Región de Los Lagos",
    "Región Aisén del General Carlos Ibáñez del Campo",
    "Región de Magallanes y la Antártica Chilena"
];

// Objeto con las comunas de cada región de Chile
const comunnes = {
    "Región Arica y Parinacota": ["Arica", "Camarones", "Putre", "Gral. Lagos"],
    "Región de Tarapacá": ["Iquique", "Alto Hospicio", "Pozo Almonte", "Camiña", "Colchane", "Huara", "Pica"],
    "Región de Antofagasta": ["Antofagasta", "Mejillones", "Sierra Gorda", "Taltal", "Calama", "Ollague", "San Pedro Atacama", "Tocopilla", "María Elena"],
    "Región de Atacama": ["Copiapo", "Caldera", "Tierra Amarilla", "Chañaral", "Diego de Almagro", "Vallenar", "Alto del Carmen", "Freirina", "Huasco"],
    "Región de Coquimbo": ["La Serena", "Coquimbo", "Andacollo", "La Higuera", "Paihuano", "Vicuña", "Illapel", "Los Vilos", "Salamanca", "Ovalle", "Combarbala", "Monte Patria", "Punitaqui", "Río Hurtado"],
    "Región de Valparaíso": ["Valparaiso", "Casablanca", "Concon", "Juan Fernandez", "Puchuncavi", "Quintero", "Viña del Mar", "Isla de Pascua", "Los Andes", "Calle Larga", "Rinconada", "San Esteban", "La Ligua", "Cabildo", "Papudo", "Petorca", "Zapallar", "Quillota", "Hijuelas", "La Cruz", "Nogales", "San Antonio", "Algarrobo", "Cartagena", "El Quisco", "El Tabo", "Santo Domingo", "San Felipe", "Catemu", "Llay Llay", "Pencahue", "Putaendo", "Santa Maria", "Quilpue", "Limache", "Olmue", "Villa Alemana"],
    "Región Metropolitana de Santiago": ["Cerrillos", "Cerro Navia", "Conchali", "El Bosque", "Estacion Central", "Huechuraba", "Independencia", "La Cisterna", "La Florida", "La Granja", "La Pintana", "La Reina", "Las Condes", "Lo Barrenechea", "Lo Espejo", "Lo Prado", "Macul", "Maipú", "Ñuñoa", "Pedro Aguirre Cerda", "Peñalolén", "Providencia", "Pudahuel", "Quilicura", "Quinta Normal", "Recoleta", "Renca", "Santiago", "San Joaquín", "San Miguel", "San Ramon", "Vitacura", "Puente Alto", "Pirque", "San José de Maipo", "Colina", "Lampa", "Tiltil", "San Bernardo", "Buin", "Calera de Tango", "Paine", "Melipilla", "Alhué", "Curacavi", "María Pinto", "San Pedro", "Talagante", "El Monte", "Isla de Maipo", "Padre Hurtado", "Peñaflor"],
    "Región del Libertador Bernardo Ohiggins": ["Rancagua", "Codegua", "Coinco", "Coltauco", "Doñihue", "Graneros", "Las Cabras", "Machali", "Malloa", "Mostazal", "Olivar", "Peumo", "Pichidegua", "Quinta Tilcoco", "Rengo", "Requinoa", "San Vicente", "Pichilemu", "La Estrella", "Litueche", "Marchigue", "Navidad", "Paredones", "San Fernando", "Chepica", "Chimbarongo", "Lolol", "Nancagua", "Palmilla", "Peralillo", "Placilla", "Pumanque", "Santa Cruz"],
    "Región del Maule": ["Talca", "Constitucion", "Curepto", "Empedrado", "Maule", "Pelarco", "Pencahue", "Rio Claro", "San Clemente", "San Rafael", "Cauquenes", "Chanco", "Pelluhue", "Curico", "Hualañe", "Licanten", "Molina", "Rauco", "Romeral", "Sagrada Familia", "Teno", "Vichuquen", "Linares", "Colbun", "Longavi", "Parral", "Retiro", "San Javier", "Villa Alegre", "Yerbas Buenas"],
    "Región del Ñuble": ["Cobquecura", "Coelemu", "Ninhue", "Portezuelo", "Quirihue", "Ranquil", "Trehuaco", "Bulnes", "Chillán Viejo", "Chillan", "El Carmen", "Pemuco", "Pinto", "Quillon", "San Ignacio", "Yungay", "Coihueco", "Ñiquen", "San Carlos", "San Fabian", "San Nicolas"],
    "Región del Biobío": ["Concepcion", "Coronel", "Chiguayante", "Florida", "Hualqui", "Lota", "Penco", "San Pedro de la Paz", "Santa Juana", "Talcahuano", "Tome", "Hualpen", "Lebu", "Arauco", "Cañete", "Contulmo", "Curanilahue", "Los Alamos", "Tirua", "Los Angeles", "Antuco", "Cabrero", "Laja", "Mulchen", "Nacimiento", "Negrete", "Quilaco", "Quilleco", "San Rosendo", "Santa Barbara", "Tucapel", "Yumbel", "Alto Bio Bio"],
    "Región de La Araucanía": ["Temuco", "Carahue", "Cunco", "Curarrehue", "Freire", "Galvarino", "Gorbea", "Lautaro", "Loncoche", "Melipeuco", "Nueva Imperial", "Padre Las Casas", "Perquenco", "Pitrufquen", "Pucon", "Teodoro Schmidt", "Tolten", "Vilcun", "Villarrica", "Cholchol", "Angol", "Collipulli", "Curacautin", "Ercilla", "Lonquimay", "Los Sauces", "Lumaco", "Puren", "Renaico", "Traiguen", "Victoria"],
    "Región de Los Ríos": ["Valdivia", "Corral", "Lanco", "Los Lagos", "Mafil", "Mariquina", "Paillaco", "Panguipulli", "La Union", "Futrono", "Lago Ranco", "Rio Bueno"],
    "Región de Los Lagos": ["Puerto Montt", "Calbuco", "Cochamo", "Fresia", "Frutillar", "Los Muermos", "Llanquihue", "Maullin", "Puerto Varas", "Castro", "Ancud", "Chonchi", "Curaco de Velez", "Dalcahue", "Puqueldon", "Queilen", "Quellon", "Quemchi", "Quinchao", "Osorno", "Puerto Octay", "Purranque", "Puyehue", "Rio Negro", "San Juan", "San Pablo", "Chaiten", "Futaleufu", "Hualaihue", "Palena"],
    "Región Aisén del General Carlos Ibáñez del Campo": ["Coyhaique", "Lago Verde", "Aysen", "Cisnes", "Guaitecas", "Cochrane", "O'Higgins", "Tortel", "Chile Chico", "Rio Ibañez"],
    "Región de Magallanes y la Antártica Chilena": ["Punta Arenas", "Laguna Blanca", "Rio Verde", "San Gregorio", "Antartica", "Porvenir", "Primavera", "Timaukel", "Torres del Paine"]
};

// Arreglo con los tipos de artesanía
const handicraft_types = [
    "Mármol",
    "Madera",
    "Cerámica",
    "Mimbre", 
    "Metal",
    "Cuero", 
    "Telas", 
    "Joyas", 
    "Otro"
]

// Elementos del DOM

// Elementos select de región, comuna y tipo de artesanía
let regions_select = document.getElementById("region");
let comunnes_select = document.getElementById("comunne");
let handicraft_types_select_1 = document.getElementById("handicraft_type_1")
let handicraft_types_select_2 = document.getElementById("handicraft_type_2")
let handicraft_types_select_3 = document.getElementById("handicraft_type_3")

// Formulario
let register_form = document.getElementById("register_form");

// Botones
let add_image_btn = document.getElementById("add_image_btn");
let register_btn = document.getElementById("register_btn");
let confirm_btn = document.getElementById("confirm_btn");
let back_to_form_btn = document.getElementById("back_to_form_btn");
let add_handicraft_type_btn = document.getElementById("add_handicraft_type_btn")

// Elementos de confirmación
let confirmation_div = document.getElementById("confirmation_div");
let confirmation_msg = document.getElementById("confirmation_msg");

// Elementos de mensaje de error
let error_msg_div = document.getElementById("error_msg_div");
let error_msg_element = document.getElementById("error_msg");
let error_list_element = document.getElementById("error_list");



// Funciones auxiliares
// Inserta los elementos del arreglo select_elements como opciones al nodo select select_node
const fill_select = (select_elements, select_node, default_message) => {
    select_node.textContent = "";
    let option_0 = document.createElement("option");
    option_0.value = "0";
    option_0.innerText = default_message;
    select_node.append(option_0);
    for (const element of select_elements) {
        let option = document.createElement("option");
        option.value = element;
        option.innerText = element;
        select_node.append(option);
    }
};

// Inserta las comunas al nodo select de comunas correspondientes a la región seleccionada
const fill_comunne = () => {
    let region = regions_select.value;
    if (region != "0") {
        fill_select(comunnes[region], comunnes_select, "Seleccione una comuna");
    }
};

// Funcion de confirmación de registro
const ask_confirmation = () => {
    confirmation_msg.innerText = "¿Confirma el registro de este artesano?";
    confirmation_div.hidden = false;
}


// Funciones de validación

// Retorna un booleano indicando si el elemento seleccionado es distinto a la opción predeterminada "0"
const select_validation = (selected_element) => selected_element != "0";

// Retorna una lista con un booleano indicando si se eligió una región y un mensaje en caso de error
const region_validation = (region) => {
    let valid_region_bool = select_validation(region);
    let error_msg = "";
    if (!valid_region_bool) error_msg = "Es necesario elegir una regíon";
    return [valid_region_bool, error_msg];
};

// Retorna una lista con un booleano indicando si se eligió una comuna y un mensaje en caso de error
const comunne_validation = (comunne) => {
    let valid_comunne_bool = select_validation(comunne);
    let error_msg = "";
    if (!valid_comunne_bool) error_msg = "Es necesario elegir una comuna";
    return [valid_comunne_bool, error_msg];
};

// Retorna una lista con un booleano indicando si se eligió un tipo de artesanía y un mensaje en caso de error.
const handicraft_types_validation = (handicraft_type_1, handicraft_type_2, handicraft_type_3) => {
    let valid_handicraft_type_bool = select_validation(handicraft_type_1) || select_validation(handicraft_type_2) || select_validation(handicraft_type_3);
    let error_msg = "";
    if (!valid_handicraft_type_bool) error_msg = "Es necesario elegir un tipo de artesanía";
    return [valid_handicraft_type_bool, error_msg];
};

const images_validation = (image_input_1, image_input_2, image_input_3) => {
    let valid_images_bool = true;
    let error_msg = "";
    let images_num = image_input_1.length + image_input_2.length + image_input_3.length;
    if (images_num == 0) {
        valid_images_bool = false;
        error_msg = "Es necesario subir al menos una foto de la artesanía";
    } else if (images_num > 3) {
        valid_images_bool = false;
        error_msg = "Puedes subir un máximo de tres fotos";
    } 
    return [valid_images_bool, error_msg];
};

// Retorna una lista con un booleano indicando si se recibió un nombre válido y un mensaje en caso de error
const name_validation = (name) => {
    // Se revisa que se haya recibido un nombre y el largo de este, en caso de haber recibido uno
    let valid_name_bool = true;
    let error_msg = "";
    if (!name) {
        valid_name_bool = false;
        error_msg = "Es necesario ingresar un nombre";
    } else if (name.length < 3 || 80 < name.length) {
        valid_name_bool = false;
        error_msg = "El nombre debe tener entre 3 y 80 caracteres";
    } 
    return [valid_name_bool, error_msg];
};

// Retorna una lista con un booleano indicando si el email recibido es válido y un mensaje en caso de error
const email_validation = (email) => {
    let valid_email_bool = true;
    let error_msg = "";
    let mail_re = /^[\w.-]+@([\w-]+\.)+[\w]{2,3}$/;
    if (!email) {
        valid_email_bool = false;
        error_msg = "Es necesario ingresar un correo electrónico";
    } else if (email.length > 30) {
        valid_email_bool = false;
        error_msg = "El correo debe tener máximo 30 caracteres";
    } else if (!mail_re.test(email)) {
        valid_email_bool = false;
        error_msg = "El correo no tiene formato de correo electrónico";
    }
    return [valid_email_bool, error_msg];
};

// Retorna una lista con un booleano indicando si el número de teléfono recibido es válido y un mensaje en caso de error.
// Se toma como válido no recibir número de teléfono
const phone_validation = (phone) => {
    let error_msg = "";
    let phone_re = /^\+56\s?9\s?[0-9]{4}\s?[0-9]{4}$/
    let valid_phone_bool = !phone || phone_re.test(phone);
    if (!valid_phone_bool) error_msg = "El número de teléfono debe ser de la forma +56 9 1234 5678"
    return [valid_phone_bool, error_msg];
};

const validate_form = () => {
    // Se obtienen las respuestas del formulario de registro
    let reg_form = document.forms["register_form"];
    let region = reg_form["region"];
    let comunne = reg_form["comunne"];
    let handicraft_type_1 = reg_form["handicraft_type_1"];
    let handicraft_type_2 = reg_form["handicraft_type_2"];
    let handicraft_type_3 = reg_form["handicraft_type_3"];
    let image_input_1 = reg_form["image_1"];
    let image_input_2 = reg_form["image_2"];
    let image_input_3 = reg_form["image_3"];
    let name = reg_form["name"];
    let email = reg_form["email"];
    let phone = reg_form["phone"];

    let is_valid = true;
    let invalid_input_messages = [];
    let invalid_input_elements = [];
    let valid_input_elements = [];
    
    const validate_input = (input_validation, input_elements) => {
        for (const input_element of input_elements) {
            if (!input_validation[0]){
                invalid_input_elements.push(input_element);
                is_valid = false;
            } else {
                valid_input_elements.push(input_element)
            } 
        }
        if (!input_validation[0]) {
            invalid_input_messages.push(input_validation[1]);
        }
    };

    validate_input(region_validation(region.value), [region]);
    validate_input(comunne_validation(comunne.value), [comunne]);
    validate_input(handicraft_types_validation(handicraft_type_1.value, handicraft_type_2.value, handicraft_type_3.value), [handicraft_type_1, handicraft_type_2, handicraft_type_3]);
    validate_input(images_validation(image_input_1.files, image_input_2.files, image_input_3.files), [image_input_1, image_input_2, image_input_3]);
    validate_input(name_validation(name.value), [name]);
    validate_input(email_validation(email.value), [email]);
    validate_input(phone_validation(phone.value), [phone]);

    for (const valid_input of valid_input_elements) {
        valid_input.style = "";
    }

    // Se indican los inputs inválidos
    if (!is_valid) {
        error_list_element.textContent = "";
        for (const invalid_input_message of invalid_input_messages) {
            let list_item = document.createElement("li");
            list_item.innerText = invalid_input_message;
            error_list_element.append(list_item);
        }
        for (const invalid_input_element of invalid_input_elements) {
            invalid_input_element.style.borderColor = "red";
        }
        error_msg_element.innerText = "Ha ocurrido un error";
        error_msg_div.hidden = false;
    } else {
        error_msg_div.hidden = true;
        reg_form.hidden = true;
        ask_confirmation();
    }
};


// Llenado de elemento select de regiones
fill_select(regions_array, regions_select, "Seleccione una región");

// Llenado de elemento select de tipos de artesanía
fill_select(handicraft_types, handicraft_types_select_1, "Seleccione el tipo de artesanía");
fill_select(handicraft_types, handicraft_types_select_2, "Seleccione el tipo de artesanía");
fill_select(handicraft_types, handicraft_types_select_3, "Seleccione el tipo de artesanía");

// Configuración y funcionamiento de botones
let image_inputs_num = 1;
const add_image_input = () => {
    if (image_inputs_num < 3) {
        image_inputs_num++;
        let image_input_div = document.getElementById("image_" + image_inputs_num + "_div");
        image_input_div.hidden = false;
        if (image_inputs_num == 3) {
            add_image_btn.hidden = true;
        }
    }
};

let handicraft_type_input_num = 1;
const add_handicraft_input = () => {
    if (handicraft_type_input_num < 3) {
        handicraft_type_input_num++;
        let handicraft_type_div = document.getElementById("handicraft_type_" + handicraft_type_input_num + "_div");
        handicraft_type_div.hidden = false;
        if (handicraft_type_input_num == 3) {
            add_handicraft_type_btn.hidden = true;
        }
    }
}

// Permite volver al menu de la página
const go_back = () => {
    window.location.href = "../../";
};

const back_to_form = () => {
    confirmation_div.hidden = true;
    register_form.hidden = false;
}

const confirm_registration = () => {
    register_form.submit()
}
regions_select.addEventListener("change", fill_comunne);
add_image_btn.addEventListener("click", add_image_input);
register_btn.addEventListener("click", validate_form);
confirm_btn.addEventListener("click", confirm_registration);
back_to_form_btn.addEventListener("click", back_to_form);
add_handicraft_type_btn.addEventListener("click", add_handicraft_input);
