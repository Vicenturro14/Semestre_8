from flask import Flask, request, render_template, redirect, url_for

app = Flask(__name__)

@app.route("/", methods = ["GET"])
def index():
    return render_template("index.html")

@app.route("/agregar_artesano", methods = ["GET", "POST"])
def agregar_artesano():
    if request.method == "POST":
        region = request.form.get("region")
        comunne = request.form.get("commune")
        handicraft_type = request.form.get("handicraft_type")
        handicraft_desc = request.form.get("handicraft_description")
        image_1 = request.form.get("image_1")
        image_2 = request.form.get("image_2")
        image_3 = request.form.get("image_3")
        name = request.form.get("name")
        email = request.form.get("email")
        phone = request.form.get("phone")
        
        
    else:
        return render_template("agregar-artesano.html")


@app.route("/ver_artesanos", methods = ["GET"])
def ver_artesanos():
    return render_template("ver-artesanos.html")


if __name__ == "__main__":
    app.run(debug=True)