from flask import Flask, request, render_template, redirect, url_for, jsonify
from flask_cors import cross_origin
from utilities.validations import validate_artisan_form, validate_supporter_form
from database import db
from werkzeug.utils import secure_filename
import hashlib
import filetype
import os
import math
import uuid
from markupsafe import escape

UPLOAD_FOLDER = "static/uploads"
app = Flask(__name__)

app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER


@app.route("/", defaults={"code" : 0})
@app.route("/<int:code>")
def index(code):
    messages = [None, "El artesano se ha registrado con éxito", "El hincha se ha registrado con éxito"]
    i = code if 0 <= code < len(messages) else 0
    return render_template("index.html", message = messages[i])


# Artesanos
@app.route("/agregar_artesano", methods = ["GET", "POST"])
def agregar_artesano():
    if request.method == "GET":
        return render_template("agregar-artesano.html")
    
    # request.method == "POST"
    else:
        image_1 = request.files.get("image_1")
        image_2 = request.files.get("image_2")
        image_3 = request.files.get("image_3")

        # Si el formulario no es válido, se indican los errores.
        valid_form, error_messages = validate_artisan_form(request.form, image_1, image_2, image_3)
        if not valid_form:
            return render_template("agregar-artesano.html", errors = error_messages)
        
        # Se agrega al artesano a la base de datos.
        name = request.form.get("name")
        email = request.form.get("email")
        comunne = request.form.get("comunne")
        region = request.form.get("region")
        phone = request.form.get("phone")
        description = request.form.get("handicraft_description", "")
        comunne_id, _, _, _ = db.get_comunneNregion(comunne, region)
        db.create_artisan(name, email, comunne_id, phone, description)

        # Se obtienen los tipos de artesanía sin repeticiones ni entradas vacías.
        handicraft_types = [request.form.get("handicraft_type_1"), request.form.get("handicraft_type_2"), request.form.get("handicraft_type_3")]
        clean_handicraft_types = []
        for h_type in handicraft_types:
            if h_type is None or h_type == "0" or h_type in clean_handicraft_types:
                continue
            clean_handicraft_types.append(h_type)
        
        # Se agrega la relación de artesano y tipo de artesanía a la base de datos
        artisan_id = db.get_artisan_by_email(email)[0]
        for h_type in clean_handicraft_types:
            handicraft_type_id, _ = db.get_handicraft_type_by_name(h_type)
            db.create_artisan_type(artisan_id, handicraft_type_id)

        # Se guardan las imágenes en el sistema de archivos y sus respectivas rutas en la base de datos.
        images = []
        if image_1:
            images.append(image_1)
        if image_2:
            images.append(image_2)
        if image_3:
            images.append(image_3)
        for image in images:
            hash_image_name = hashlib.sha256(secure_filename(image.filename).encode("utf-8")).hexdigest()
            image_extension = filetype.guess(image).extension
            unique_image_name = f"{hash_image_name}_{str(uuid.uuid4())}.{image_extension}"
            image_path = os.path.join(app.config["UPLOAD_FOLDER"], unique_image_name)

            # Se guarda imagen en sistema de archivos
            image.save(image_path)
            # Se guarda imagen en base de datos

            db.create_image(url_for("static", filename= f"uploads/{unique_image_name}"), unique_image_name, artisan_id)

        # Finalmente, se redirige a la página principal.
        return redirect(url_for("index", code= 1))

@app.route("/ver_artesanos", defaults = {"page":1})
@app.route("/ver_artesanos/<int:page>")
def ver_artesanos(page : int):
    artisans_num = db.get_registered_artisans_num()
    total_pages_num = math.ceil(artisans_num/5)
    # Se revisa que el número de página recibido por la URL esté dentro del rango posible.
    if page < 1:
        p = 1
    elif page > total_pages_num:
        p = total_pages_num
    else:
        p = page

    artisans = []
    for artisan in db.get_artisans(5, 5*(p-1)):
        
        artisan_id, name, phone, comunne_id = artisan
        comunne = db.get_comunne_by_id(comunne_id)[1]
        handicraft_types = [escape(h_type[0]) for h_type in db.get_handicraft_types_by_artisan_id(artisan_id)] 
        _, image_path, _, _ = db.get_image_by_artisan_id(artisan_id)
        info_path = url_for("informacion_artesano", id = artisan_id)
        artisans.append({
            "id" : artisan_id, "name": escape(name), "phone" : escape(phone), "comunne" : escape(comunne),
            "handicraft_types" : handicraft_types, "image_path" : image_path, "info_path" : info_path
            })
    
    return render_template("ver-artesanos.html", context = {"page_num" : p, "total_pages_num" : total_pages_num, "artisans" : artisans})


@app.route("/informacion_artesano/<int:id>")
def informacion_artesano(id : int):
    # Se obtiene la información del artesano
    _, commune_id, handicraft_desc, name, email, phone = db.get_artisan_by_id(id)
    comunne, region = db.get_comunne_region_names_by_comunne_id(commune_id)
    handicraft_types = [escape(h_type[0]) for h_type in db.get_handicraft_types_by_artisan_id(id)] 
    images_paths = [image[1] for image in db.get_images_by_artisan_id(id)]
    context = {"comunne" : escape(comunne), "region" : escape(region), "handicraft_desc" : escape(handicraft_desc), "name" : escape(name), "email" : escape(email),
                "phone" : escape(phone), "handicraft_types" : handicraft_types, "images_paths" : images_paths}
    return render_template("informacion-artesano.html", context = context)



# Hinchas
@app.route("/agregar_hincha", methods=["GET", "POST"])
def agregar_hincha():
    if request.method == "GET":
        return render_template("agregar-hincha.html")
    
    # if request.method == "POST"
    else:
        # Si el formulario no es válido, se informan los errores.
        valid_form, error_messages = validate_supporter_form(request.form)
        if not valid_form:
            return render_template("agregar-hincha.html", errors = error_messages)
        
        # Se agrega al hincha a la base de datos
        comunne_id, _, _ = db.get_comunne_by_name(request.form.get("comunne"))
        transport = request.form.get("transport").lower()
        name = request.form.get("name")
        email = request.form.get("email")
        phone = request.form.get("phone")
        comment = request.form.get("comment")
        db.create_supporter(comunne_id, transport, name, email, phone, comment) 
        
        # Se obtiene una lista de los deportes seleccionados sin repeticiones o entradas vacías.
        sports_list = [request.form.get("sport_1"), request.form.get("sport_2"), request.form.get("sport_3")]
        clean_sports_list = []
        for sport in sports_list:
            if sport is None or sport == "0" or sport in clean_sports_list:
                continue
            clean_sports_list.append(sport)

        # Se agregan las relaciones de hincha y deportes en la base de datos
        supporter_id = db.get_supporter_by_email(email)[0] 
        for sport in clean_sports_list:
            sport_id, _ = db.get_sport_by_name(sport)
            db.create_supporter_sport(supporter_id, sport_id)

        # Finalmente se redirecciona a la página principal
        return redirect(url_for("index", code= 2))

@app.route("/ver_hinchas", defaults = {"page":1})
@app.route("/ver_hinchas/<int:page>")
def ver_hinchas(page : int):
    supporters_num = db.get_registered_supporters_num()
    total_pages_num = math.ceil(supporters_num/5)
    if page < 1:
        p = 1
    elif page > total_pages_num:
        p = total_pages_num
    else:
        p = page

    supporters = []
    for supporter in db.get_supporters(5, 5*(p-1)):
        supporter_id, name, comunne_id, transport, phone = supporter
        comunne = db.get_comunne_by_id(comunne_id)[1]
        sports = [escape(sport[0]) for sport in db.get_sports_names_by_supporter_id(supporter_id)]
        info_path = url_for("informacion_hincha", id = supporter_id)
        supporters.append({"id": supporter_id, "name" : escape(name), "comunne": escape(comunne), "transport" : escape(transport), "sports" : sports, "phone": escape(phone), "info_path": info_path})
    context = {"page_num" : p, "total_pages_num" : total_pages_num, "supporters" : supporters}
    return render_template("ver-hinchas.html", context=context)


@app.route("/informacion_hincha/<int:id>")
def informacion_hincha(id : int):
    _, comunne_id, transport, name, email, phone, comments = db.get_supporter_by_id(id)
    comunne, region = db.get_comunne_region_names_by_comunne_id(comunne_id)
    sports = [escape(sport[0]) for sport in db.get_sports_names_by_supporter_id(id)]
    context = {"comunne" : escape(comunne), "region" : escape(region), "name" : escape(name), "email" : escape(email), "phone" : escape(phone), "transport" : escape(transport), "sports" : sports, "comments":escape(comments)}
    return render_template("informacion-hincha.html", context=context)

@app.route("/graficos")
def graficos():
    return render_template("graficos.html")

@app.route("/datos_graficos")
@cross_origin(origins="localhost", supports_credentials=True)
def datos_graficos():
    supporters_per_sport = db.get_supporters_per_sport()
    artisans_per_type = db.get_artisans_per_type()
    data = [
        [{"sport" : sport_data[0], "count" : sport_data[1]} for sport_data in supporters_per_sport],
        [{"type" : type_data[0].capitalize(), "count" : type_data[1]} for type_data in artisans_per_type]
    ]
    
    return jsonify(data)


if __name__ == "__main__":
    app.run(debug=True)
