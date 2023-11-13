import re
from database import db
import filetype

def validate_region_comunne(region, comunne):
    if region is None:
        return False, "Es necesario indicar una región."
    if comunne is None:
        return False, "Es necesario indicar una comuna."
    comunneNregion = db.get_comunneNregion(comunne, region)
    if comunneNregion is None:
        return False, "La comuna indicada no corresponde a la región indicada."
    return True, None

def validate_handicraft_types(handicraft_type_1, handicraft_type_2, handicraft_type_3):
    if handicraft_type_1 == "0" and handicraft_type_2 == "0" and handicraft_type_3 == "0":
        return False, "Es necesario elegir al menos un tipo de artesanía."
    
    handicraft_types = []
    if handicraft_type_1 != "0":
        handicraft_types.append(handicraft_type_1)
    if handicraft_type_2 != "0":
        handicraft_types.append(handicraft_type_2)
    if handicraft_type_3 != "0":
        handicraft_types.append(handicraft_type_3)

    for handicraft_type in handicraft_types:
        handicraft_type_tuple = db.get_handicraft_type(handicraft_type.lower())
        if handicraft_type_tuple is None:
            return False, "Al menos uno de los tipos de artesanía ingresados no es válido."
    return True, None
            
def validate_name(name):
    if name is None:
        return False, "Es necesario ingresar un nombre."
    name_len = len(name)
    if name_len < 3 or 80 < name_len:
        return False, "El nombre debe tener entre 3 y 80 caracteres."
    return True, None

def validate_email(email):
    if email is None:
        return False, "Es necesario ingresar un correo electrónico."
    valid_email = bool(re.search(r"^[\w.-]+@([\w-]+\.)+[\w]{2,3}$", email))
    if not valid_email:
        return valid_email, "El correo no tiene formato de correo electrónico."
    return True, None

def validate_phone(phone) -> tuple:
    """Retorna una tupla con un booleano indicando si el número de teléfono es válido y un mensaje de error.
    Se toma como válido no recibir número de teléfono."""
    error_msg = None
    if phone is None or phone == "":
        valid_phone = True
    else:
        valid_phone = bool(re.search(r"^\+56\s?9\s?[0-9]{4}\s?[0-9]{4}$", phone))
        if not valid_phone:
            error_msg = "El número de teléfono debe ser de la forma +56 9 1234 5678"
    return valid_phone, error_msg

def validate_images(image_1, image_2, image_3):
    ALLOWED_EXTENSIONS = {"png", "jpg", "jpeg", "gif"}
    ALLOWED_MIMETYPES = {"image/jpeg", "image/png", "image/gif"}
    
    if image_1 is None and image_2 is None and image_3 is None:
        return False, "Es necesario subir al menos una imagen."
    images = []
    
    if image_1.filename != "":
        images.append(image_1)
    if image_2.filename != "":
        images.append(image_2)
    if image_3.filename != "":
        images.append(image_3)

    for image in images:
        ftype = filetype.guess(image)
        if ftype.extension not in ALLOWED_EXTENSIONS:
            return False, "Una de las imágenes tiene una extensión no permitida."
        if ftype.mime not in ALLOWED_MIMETYPES:
            return False, "Una de las imágenes no es del tipo permitido."
    return True, None


def validate_form(form_dict, image_1, image_2, image_3) -> bool:
    is_valid = True
    error_messages = []
    
    # Validación de región y comuna
    valid_comunneNregion, comunneNregion_msg = validate_region_comunne(form_dict.get("region"), form_dict.get("comunne"))
    if not valid_comunneNregion:
        error_messages.append(comunneNregion_msg)
        is_valid = False

    # Validación de tipo de artesanía
    valid_handicraft_types, handicraft_type_msg = validate_handicraft_types(form_dict.get("handicraft_type_1"), form_dict.get("handicraft_type_2"), form_dict.get("handicraft_type_3"))
    if not valid_handicraft_types:
        is_valid = False
        error_messages.append(handicraft_type_msg)

    # Validación de nombre
    valid_name, name_msg = validate_name(form_dict.get("name"))
    if not valid_name:
        is_valid = False
        error_messages.append(name_msg)

    # Validación de email
    valid_email, email_msg = validate_email(form_dict.get("email"))
    if not valid_email:
        is_valid = False
        error_messages.append(email_msg)

    # Validación de teléfono
    valid_phone, phone_msg = validate_phone(form_dict.get("phone"))
    if not valid_phone:
        is_valid = False
        error_messages.append(phone_msg)

    # Validación de imágenes 
    valid_images, images_msg = validate_images(image_1, image_2, image_3)
    if not valid_images:
        is_valid = False
        error_messages.append(images_msg)

    return is_valid, error_messages
