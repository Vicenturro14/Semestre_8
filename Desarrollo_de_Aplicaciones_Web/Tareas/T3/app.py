from flask import Flask, request, render_template, redirect, url_for
from utilities.validations import validate_artisan_form, validate_supporter_form
from database import db
from werkzeug.utils import secure_filename
import hashlib
import filetype
import os

UPLOAD_FOLDER = "static/uploads"
app = Flask(__name__)

app.config["UPLOAD_FOLDER"] = UPLOAD_FOLDER

@app.route("/", defaults={"code" : 0})
@app.route("/<int:code>")
def index(code):
    messages = [None, "El artesano se ha registrado con éxito", "El hincha se ha registrado con éxito"]
    return render_template("index.html", message = messages[code])

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

        # Se guardan las imágenes en el sistema de archivos y 
        # sus respectivas rutas en la base de datos.
        images = []
        if image_1:
            images.append(image_1)
        if image_2:
            images.append(image_2)
        if image_3:
            images.append(image_3)
        for image in images:
            image_name = hashlib.sha3_256(secure_filename(image.filename).encode("utf-8")).hexdigest()
            image_extension = filetype.guess(image).extension
            image_file_name = f"{image_name}.{image_extension}"
            image_path = os.path.join(app.config["UPLOAD_FOLDER"], image_file_name)
            # Se guarda imagen en sistema de archivos
            image.save(image_path)
            # Se guarda imagen en base de datos
            db.create_image(image_path, image_file_name, artisan_id)

        # Finalmente, se redirige a la página principal.
        return redirect(url_for("index", code= 1))


@app.route("/ver_artesanos")
def ver_artesanos():
    return render_template("ver-artesanos.html")

@app.route("/informacion_artesano")
def informacion_artesano():
    return render_template("informacion-artesano.html")


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

@app.route("/ver_hinchas")
def ver_hincha():
    return render_template("ver-hinchas.html")

# TODO: Validar que email no se encuentre en la base de datos. => email es único por cada hincha y por cada artesano
if __name__ == "__main__":
    app.run(debug=True)