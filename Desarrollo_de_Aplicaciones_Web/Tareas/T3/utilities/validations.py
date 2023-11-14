import re
from database import db
import filetype

def validate_region_comunne(region: str | None, comunne: str | None) -> tuple[bool, str | None]:
    """Valida la comuna y la región recibidas, 
    comprobando que ambas existan y que la comuna se encuentre dentro de la región."""
    # Si no se recibe comuna o región, se rechaza.
    if region is None:
        return False, "Es necesario indicar una región."
    
    if comunne is None:
        return False, "Es necesario indicar una comuna."
    
    # Se busca la comuna junto a la región en la base de datos
    comunneNregion = db.get_comunneNregion(comunne, region)

    # Si no se encuentra el par, entonces la comuna no corresponde a la región indicada.
    if comunneNregion is None:
        return False, "La comuna indicada no corresponde a la región indicada."
    
    return True, None

def validate_handicraft_types(handicraft_type_1 : str, handicraft_type_2 : str, handicraft_type_3 : str) -> tuple[bool, str | None]:
    """Retorna un booleano indicando si los tipos de artesanía recibidos son válidos
    y un mensaje en caso de no ser válidos."""

    # Si no se recibe ningún tipo de artesanía, se rechaza.
    if handicraft_type_1 == "0" and handicraft_type_2 == "0" and handicraft_type_3 == "0":
        return False, "Es necesario elegir al menos un tipo de artesanía."
    
    # Se filtran las entradas vacías
    handicraft_types = []
    if handicraft_type_1 != "0":
        handicraft_types.append(handicraft_type_1)
    if handicraft_type_2 != "0":
        handicraft_types.append(handicraft_type_2)
    if handicraft_type_3 != "0":
        handicraft_types.append(handicraft_type_3)

    # Se corrobora que todos los tipos de artesanías recibidos existan en la base de datos.
    for handicraft_type in handicraft_types:
        handicraft_type_tuple = db.get_handicraft_type(handicraft_type.lower())
        if handicraft_type_tuple is None:
            return False, "Al menos uno de los tipos de artesanía ingresados no es válido."
        
    return True, None
            
def validate_name(name : str | None) -> tuple[bool, str | None]:
    """Retorna un booleano indicando si el nombre recibido es válido 
    junto a un mensaje en caso de no ser válido."""

    # Si no se recibe un nombre se rechaza.
    if name is None:
        return False, "Es necesario ingresar un nombre."
    
    # Si el nombre no cumple con las restricciones de largo, se rechaza.
    name_len = len(name)
    if name_len < 3 or 80 < name_len:
        return False, "El nombre debe tener entre 3 y 80 caracteres."
    
    # Se revisa que el nombre no contenga números y que tenga letras.
    status = False
    msg = "El nombre debe contener letras"
    for char in name:
        if char.isnumeric():
            return False, "El nombre no puede contener números"
        if char.isalpha():
            msg = None
            status = True
    
    return status, msg 

def validate_email(email : str | None) -> tuple[bool, str | None]:
    """Retorna un booleano indicando si el email recibido es válido 
    junto a un mensaje en caso de no serlo"""

    # Se revisa que se haya recibido un correo electrónico
    if email is None:
        return False, "Es necesario ingresar un correo electrónico."
    
    # Se revisa que el correo recibido tenga formato de correo electrónico.
    valid_email = bool(re.search(r"^[\w.-]+@([\w-]+\.)+[\w]{2,3}$", email))
    if not valid_email:
        return valid_email, "El correo no tiene formato de correo electrónico."
    
    return True, None

def validate_phone(phone : str | None) -> tuple[bool, str | None]:
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

def validate_images(image_1, image_2, image_3) -> tuple[bool, str | None]:
    """Retorna un booleano indicando si las imágenes recibidas son válidas 
    junto a un mensaje en caso de no ser válidas."""
    ALLOWED_EXTENSIONS = {"png", "jpg", "jpeg", "gif"}
    ALLOWED_MIMETYPES = {"image/jpeg", "image/png", "image/gif"}
    
    # Se revisa que se haya recibido al menos una imagen.
    if image_1 is None and image_2 is None and image_3 is None:
        return False, "Es necesario subir al menos una imagen."
    
    images = []
    if image_1.filename != "":
        images.append(image_1)
    if image_2.filename != "":
        images.append(image_2)
    if image_3.filename != "":
        images.append(image_3)

    # Se revisa que las imágenes recibidas tengan extensiones permitidas
    # y sean de los tipos permitidos.
    for image in images:
        ftype = filetype.guess(image)
        if ftype.extension not in ALLOWED_EXTENSIONS:
            return False, "Una de las imágenes tiene una extensión no permitida."
        if ftype.mime not in ALLOWED_MIMETYPES:
            return False, "Una de las imágenes no es del tipo permitido."
    
    return True, None

def validate_form(form_dict : dict, image_1, image_2, image_3) -> tuple[bool, list[str]]:
    """Retorna un booleano indicando si el formulario y las imágenes recibidas son válidas, 
    junto a los mensajes de error de aquellos campos que no son válidos."""
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
