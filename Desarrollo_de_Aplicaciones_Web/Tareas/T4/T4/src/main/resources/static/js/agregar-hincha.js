
// Arreglo de deportes
const sports_array = [
    "Clavados",
    "Natación",
    "Natación artística",
    "Polo acuático",
    "Natación en Aguas abiertas",
    "Maratón",
    "Marcha",
    "Atletismo",
    "Bádminton",
    "Balonmano",
    "Básquetbol",
    "Básquetbol 3x3",
    "Béisbol",
    "Boxeo",
    "Bowling",
    "Breaking",
    "Canotaje Slalom",
    "Canotaje de velocidad",
    "BMX Freestyle",
    "BMX Racing",
    "Mountain Bike",
    "Ciclismo pista",
    "Ciclismo ruta",
    "Adiestramiento ecuestre",
    "Evento completo ecuestre",
    "Salto ecuestre",
    "Escalada deportiva",
    "Esgrima",
    "Esquí acuático y Wakeboard",
    "Fútbol",
    "Gimnasia artística Masculina",
    "Gimnasia artística Femenina",
    "Gimnasia rítmica",
    "Gimnasia trampolín",
    "Golf",
    "Hockey césped",
    "Judo",
    "Karate",
    "Levantamiento de pesas",
    "Lucha",
    "Patinaje artístico",
    "Skateboarding",
    "Patinaje velocidad",
    "Pelota vasca",
    "Pentatlón moderno",
    "Racquetball",
    "Remo",
    "Rugby 7",
    "Sóftbol",
    "Squash",
    "Surf",
    "Taekwondo",
    "Tenis",
    "Tenis de mesa",
    "Tiro",
    "Tiro con arco",
    "Triatlón",
    "Vela",
    "Vóleibol",
    "Vóleibol playa"
];

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

// Elementos del DOM

// Elementos select de región y comuna
let regions_select = document.getElementById("region");
let comunnes_select = document.getElementById("comunne");

// Formulario
let register_form = document.getElementById("register_form");

// Botones
let add_sport_btn = document.getElementById("add_sport_btn");
let register_btn = document.getElementById("register_btn");
let confirm_btn = document.getElementById("confirm_btn");
let back_to_form_btn = document.getElementById("back_to_form_btn");

// Elementos de confirmación
let confirmation_div = document.getElementById("confirmation_div");
let confirmation_msg = document.getElementById("confirmation_msg");

// Elementos de mensaje de error
let msg_div = document.getElementById("msg_div");
let msg_element = document.getElementById("msg");
let msg_list_element = document.getElementById("msg_list")


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
    if (region !== "0") {
        fill_select(comunnes[region], comunnes_select, "Seleccione una comuna");
    }
};


// Funcion de confirmación de registro
const ask_confirmation = () => {
    confirmation_msg.innerText = "¿Confirma el registro de este hincha?";
    confirmation_div.hidden = false;
}

// Funciones de validación

// Retorna un booleano indicando si el elemento seleccionado es distinto a la opción predeterminada "0"
const select_validation = (selected_element) => selected_element !== "0";

// Retorna una lista con un booleano indicando si se seleccionó al menos un deporte y un mensaje en caso de error.
const sports_validation = (sport_1, sport_2, sport_3) => {
    let validation_bool = select_validation(sport_1) || select_validation(sport_2) || select_validation(sport_3);
    let error_msg = "";
    if (!validation_bool) error_msg = "Es necesario elegir al menos un deporte";
    return [validation_bool, error_msg];
}

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

// Retorna una lista con un booleano indicando si se eligió una de las dos opciones de transporte y un mensaje en caso de error
const transport_validation = (transport) => {
    let valid_transport_bool = transport === "locomoción pública" || transport === "particular";
    let error_msg = "";
    if (!valid_transport_bool) error_msg = "Es necesario elegir un tipo de transporte";
    return [valid_transport_bool, error_msg];
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
    let mail_re = /^[\w.-]+@([\w-]+\.)+\w{2,3}$/;
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

// Retorna una lista con un booleano indicando si el comentario recibido es válido y un mensaje en caso de error.
// Se toma como válido no recibir comentario
const comment_validation = (comment) => {
    let valid_comment_bool = !comment || comment.length <= 80;
    let error_msg = "";
    if (!valid_comment_bool) error_msg = "El comentario no puede superar los 80 caracteres";
    return [valid_comment_bool, error_msg];
};

const validate_hincha_form = () => {
    // Se obtienen las respuestas del formulario de registro
    let hincha_form = document.forms["register_form"];
    let sport_1 = hincha_form["sport_1"];
    let sport_2 = hincha_form["sport_2"];
    let sport_3 = hincha_form["sport_3"];
    let region = hincha_form["region"];
    let comunne = hincha_form["comunne"];
    let transport = hincha_form["transport"];
    let name = hincha_form["name"];
    let email = hincha_form["email"];
    let phone = hincha_form["phone"];
    let comment = hincha_form["comment"];

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

    // Se validan las entradas del formulario
    validate_input(sports_validation(sport_1.value, sport_2.value, sport_3.value), [sport_1, sport_2, sport_3]);
    validate_input(region_validation(region.value), [region]);
    validate_input(comunne_validation(comunne.value), [comunne]);

    let transport_val_result = transport_validation(transport.value)
    if (!transport_val_result[0]) {
        invalid_input_messages.push(transport_val_result[1]);
        is_valid = false;
    }

    validate_input(name_validation(name.value), [name]);
    validate_input(email_validation(email.value), [email]);
    validate_input(phone_validation(phone.value), [phone]);
    validate_input(comment_validation(comment.value), [comment]);

    for (const valid_input of valid_input_elements) {
        valid_input.style = "";
    }

    // Se indican los inputs inválidos.
    if (!is_valid) {
        msg_list_element.textContent = "";
        for (const invalid_input_message of invalid_input_messages) {
            let list_item = document.createElement("li");
            list_item.innerText = invalid_input_message;
            msg_list_element.append(list_item);
        }
        for (const invalid_input_element of invalid_input_elements) {
            invalid_input_element.style.borderColor = "red";
        }
        msg_element.innerText = "Ha ocurrido un error:"
        msg_div.hidden = false;
    } else {
        msg_div.hidden = true;
        hincha_form.hidden = true;
        ask_confirmation();
    }
};


// Llenado de nodos select de deportes
for (let input = 1; input < 4; input++) {
    let select_node = document.getElementById("sport_" + input);
    fill_select(sports_array, select_node, "Seleccione un deporte");
}

// Llenado de nodo select de regiones
fill_select(regions_array, regions_select, "Seleccione una región");

// Configuración y funcionamiento de botones
let sport_num = 1;
const add_sport = () => {
    if (sport_num < 3) {
        sport_num++;
        let sport_div = document.getElementById("sport_" + sport_num + "_div");
        sport_div.hidden = false;
        if (sport_num === 3) {
            add_sport_btn.hidden = true;
        }
    }
};

const back_to_form = () => {
    confirmation_div.hidden = true;
    register_form.hidden = false;
}

const confirm_registration = () => {
    register_form.submit();
}

regions_select.addEventListener("change", fill_comunne);
add_sport_btn.addEventListener("click", add_sport);
register_btn.addEventListener("click", validate_hincha_form);
confirm_btn.addEventListener("click", confirm_registration);
back_to_form_btn.addEventListener("click", back_to_form);
