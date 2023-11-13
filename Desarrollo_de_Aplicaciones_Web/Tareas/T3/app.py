from flask import Flask, request, render_template, redirect, url_for
from utilities.validations import validate_form
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


@app.route("/agregar_artesano", methods = ["GET", "POST"])
def agregar_artesano():
    if request.method == "POST":
        image_1 = request.files.get("image_1")
        image_2 = request.files.get("image_2")
        image_3 = request.files.get("image_3")
        valid_form, error_messages = validate_form(request.form, image_1, image_2, image_3)
        if not valid_form:
            return render_template("agregar-artesano.html", errors = error_messages)
        name = request.form.get("name")
        email = request.form.get("email")
        comunne = request.form.get("comunne")
        region = request.form.get("region")
        phone = request.form.get("phone")
        description = request.form.get("handicraft_description", "")
        comunne_id, _, _, _ = db.get_comunneNregion(comunne, region)
        # Agregar artesano a bd
        db.create_handicrafter(name, email, comunne_id, phone, description)

        # Agregar artesano tipo
        handicrafter_id = db.get_handicrafter_id(name, email)
        h_type_1 = request.form.get("handicraft_type_1")
        h_type_2 = request.form.get("handicraft_type_2")
        h_type_3 = request.form.get("handicraft_type_3")
        handicraft_types = []
        if h_type_1 != "0":
            handicraft_types.append(h_type_1)
        if h_type_2 != "0":
            handicraft_types.append(h_type_2)
        if h_type_3 != "0":
            handicraft_types.append(h_type_3)
        for h_type in handicraft_types:
            handicraft_type_id, _ = db.get_handicraft_type(h_type)
            db.create_handicrafter_type(handicrafter_id, handicraft_type_id)

        # Agregar imágenes
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
            db.create_image(image_path, image_file_name, handicrafter_id)
        return redirect(url_for("index", code= 1))
    else:
        return render_template("agregar-artesano.html")


@app.route("/ver_artesanos", methods = ["GET"])
def ver_artesanos():
    return render_template("ver-artesanos.html")

@app.route("/informacion_artesano", methods = ["GET"])
def informacion_artesano():
    return render_template("informacion-artesano.html")


if __name__ == "__main__":
    app.run(debug=True)