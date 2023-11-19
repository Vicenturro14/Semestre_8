import pymysql

DB_NAME = "tarea2"
DB_USERNAME = "cc5002"
DB_PASSWORD = "programacionweb"
DB_HOST = "localhost"
DB_PORT = 3306
DB_CHARSET = "utf8"

def get_conn():
	conn = pymysql.connect(
		db=DB_NAME,
		user=DB_USERNAME,
		passwd=DB_PASSWORD,
		host=DB_HOST,
		port=DB_PORT,
		charset=DB_CHARSET
	)
	return conn

def get_comunne_by_name(comunne : str) -> tuple | None:
	conn = get_conn()
	cursor = conn.cursor()
	query = "SELECT * FROM comuna WHERE nombre=%s;"
	cursor.execute(query, (comunne,))
	comunne_tuple = cursor.fetchone()
	return comunne_tuple

def get_comunne_by_id(comunne_id : int) -> tuple | None:
	conn = get_conn()
	cursor = conn.cursor()
	query = "SELECT * FROM comuna WHERE id=%s;"
	cursor.execute(query, (comunne_id,))
	comunne_tuple = cursor.fetchone()
	return comunne_tuple

def get_comunneNregion(comunne : str, region : str) -> tuple[int, str, int, str] | None:
	conn = get_conn()
	cursor = conn.cursor()
	cursor.execute(
		"SELECT comuna.id, comuna.nombre, region.id, region.nombre FROM comuna JOIN region ON comuna.region_id=region.id WHERE comuna.nombre=%s AND region.nombre=%s;",
		(comunne, region))
	comunneNregion = cursor.fetchone()
	return comunneNregion

def get_handicraft_type_by_name(handicraft_type : str) -> tuple[int, str]:
	conn = get_conn()
	cursor = conn.cursor()
	cursor.execute("SELECT id, nombre FROM tipo_artesania WHERE nombre=%s;", (handicraft_type,))
	handicraft_type_tuple = cursor.fetchone()
	return handicraft_type_tuple

def create_artisan(name : str, email : str, comunne_id : str, phone : str = "", handicraft_desc : str = "") -> None:
	conn = get_conn()
	cursor = conn.cursor()
	query = "INSERT INTO artesano (nombre, email, comuna_id, celular, descripcion_artesania) VALUES (%s, %s, %s, %s, %s);"
	cursor.execute(query, (name, email, comunne_id, phone, handicraft_desc))
	conn.commit()

def get_artisan_by_email(email : str) -> None:
	conn = get_conn()
	cursor = conn.cursor()
	cursor.execute("SELECT * FROM artesano WHERE email=%s;", (email,))
	artisan = cursor.fetchone()
	return artisan

def create_artisan_type(artisan_id : str, handicraft_type_id : str) -> None:
	conn = get_conn()
	cursor = conn.cursor()
	query = "INSERT INTO artesano_tipo (artesano_id, tipo_artesania_id) VALUES (%s, %s);"
	cursor.execute(query, (artisan_id, handicraft_type_id))
	conn.commit()

def create_image(file_path : str, file_name : str, artisan_id : int) -> None:
	conn = get_conn()
	cursor = conn.cursor()
	query = "INSERT INTO foto (ruta_archivo, nombre_archivo, artesano_id) VALUES (%s, %s, %s);"
	cursor.execute(query, (file_path, file_name, artisan_id))
	conn.commit()

def get_sport_by_name(sport : str) -> tuple[int, str] | None:
	conn = get_conn()
	cursor = conn.cursor()
	query = "SELECT id, nombre FROM deporte WHERE nombre = %s;"
	cursor.execute(query, (sport,))
	sport_tuple = cursor.fetchone()
	return sport_tuple

def create_supporter(comunne_id : int, transport : str, name : str, email : str, phone : str | None, comment : str | None) -> None:
	conn = get_conn()
	cursor = conn.cursor()
	query = "INSERT INTO hincha (comuna_id, modo_transporte, nombre, email, celular, comentarios) VALUES (%s, %s, %s, %s, %s, %s);"
	cursor.execute(query, (comunne_id, transport, name, email, phone, comment))
	conn.commit()

def get_supporter_by_email(email : str) -> tuple | None:
	conn = get_conn()
	cursor = conn.cursor()
	query = "SELECT * FROM hincha WHERE email=%s;"
	cursor.execute(query, (email,))
	supporter_tuple = cursor.fetchone()
	return supporter_tuple

def create_supporter_sport(supporter_id : int, sport_id : int) -> None:
	conn = get_conn()
	cursor = conn.cursor()
	query = "INSERT INTO hincha_deporte (hincha_id, deporte_id) VALUES (%s, %s);"
	cursor.execute(query, (supporter_id, sport_id))
	conn.commit()

def get_supporters(supporters_num : int, offset : int) -> tuple:
	"""Retorna los primeros supporters_num hinchas ordenados por nombre, con el offset indicado."""
	conn = get_conn()
	cursor = conn.cursor()
	query = "SELECT id, nombre, comuna_id, modo_transporte, celular FROM hincha ORDER BY nombre LIMIT %s, %s;"
	cursor.execute(query, (offset, supporters_num))
	supporters_tuple = cursor.fetchall()
	return supporters_tuple

def get_artisans(artisans_num : int, offset : int) -> tuple:
	"""Retorna los primeros artisans_num artesanos ordenados por nombre, con el offset indicado."""
	conn = get_conn()
	cursor = conn.cursor()
	query = "SELECT id, nombre, celular, comuna_id FROM artesano ORDER BY nombre LIMIT %s, %s;"
	cursor.execute(query, (offset, artisans_num))
	supporters_tuple = cursor.fetchall()
	return supporters_tuple

def get_registered_artisans_num() -> int:
	"""Retorna la cantidad de artesanos registrados en la base de datos."""
	conn = get_conn()
	cursor = conn.cursor()
	query = "SELECT COUNT(id) FROM artesano;"
	cursor.execute(query)
	artisans_num = cursor.fetchone()
	return artisans_num[0]

def get_registered_supporters_num() -> int:
	"""Retorna la cantidad de hinchas registrados en la base de datos."""
	conn = get_conn()
	cursor = conn.cursor()
	query = "SELECT COUNT(id) FROM hincha;"
	cursor.execute(query)
	supporters_num = cursor.fetchone()
	return supporters_num[0]

def get_handicraft_types_by_artisan_id(artisan_id : int) -> tuple[tuple]:
	"""Retorna los tipos de artesanías asociadas al artesano indicado por el id recibido."""
	conn = get_conn()
	cursor = conn.cursor()
	query = "SELECT tipo_artesania.nombre FROM artesano_tipo JOIN tipo_artesania ON artesano_tipo.tipo_artesania_id = tipo_artesania.id WHERE artesano_tipo.artesano_id = %s;"
	cursor.execute(query, (artisan_id,))
	handicraft_types = cursor.fetchall()
	return handicraft_types

def get_image_by_artisan_id(artisan_id : int) -> tuple:
	"""Retorna la información de una de las imágenes del artesano indicado por el id recibido."""
	conn = get_conn()
	cursor = conn.cursor()
	query = "SELECT * FROM foto WHERE artesano_id = %s;"
	cursor.execute(query, (artisan_id,))
	image_tuple = cursor.fetchone()
	return image_tuple

def get_artisan_by_id(artisan_id : int) -> tuple:
	"""Retorna la información almacenada en la base de datos del artesano indicado por el id recibido."""
	conn = get_conn()
	cursor = conn.cursor()
	query = "SELECT * FROM artesano WHERE id = %s;"
	cursor.execute(query, (artisan_id,))
	artisan = cursor.fetchone()
	return artisan

def get_supporter_by_id(supporter_id : int) -> tuple:
	"""Retorna la información almacenada en la base de datos del hincha indicado por el id recibido."""
	conn = get_conn()
	cursor = conn.cursor()
	query = "SELECT * FROM hincha WHERE id = %s;"
	cursor.execute(query, (supporter_id,))
	supporter = cursor.fetchone()
	return supporter

def get_comunne_region_names_by_comunne_id(comunne_id : int) -> tuple:
	"""Retorna el nombre y la región en la que se ubica, de la comuna indicada por el id recibido."""
	conn = get_conn()
	cursor = conn.cursor()
	query = "SELECT comuna.nombre, region.nombre FROM comuna JOIN region ON comuna.region_id = region.id WHERE comuna.id = %s;"
	cursor.execute(query, (comunne_id,))
	comunne_region_names = cursor.fetchone()
	return comunne_region_names

def get_images_by_artisan_id(artisan_id : int) -> tuple:
	"""Retorna la información de las imágenes del artesano indicado por el id recibido."""
	conn = get_conn()
	cursor = conn.cursor()
	query = "SELECT * FROM foto WHERE artesano_id = %s;"
	cursor.execute(query, (artisan_id,))
	images_tuple = cursor.fetchall()
	return images_tuple

def get_sports_names_by_supporter_id(supporter_id : int) -> tuple:
	"""Retorna los nombres de los deportes asociados al hincha indicado por el id recibido."""
	conn = get_conn()
	cursor = conn.cursor()
	query = "SELECT deporte.nombre FROM hincha_deporte JOIN deporte ON hincha_deporte.deporte_id=deporte.id WHERE hincha_deporte.hincha_id= %s;"
	cursor.execute(query, (supporter_id,))
	sports = cursor.fetchall()
	return sports

def get_artisans_per_type() -> tuple:
	"""Retorna la cantidad de artesanos asociados a cada tipo de artesanía."""
	conn = get_conn()
	cursor = conn.cursor()
	query = "SELECT tipo_artesania.nombre, COUNT(*) FROM artesano_tipo JOIN tipo_artesania ON artesano_tipo.tipo_artesania_id = tipo_artesania.id GROUP BY tipo_artesania.nombre;"	
	cursor.execute(query)
	artisans_per_type = cursor.fetchall()
	return artisans_per_type

def get_supporters_per_sport() -> tuple:
	"""Retorna la cantidad de hinchas asociados a cada deporte."""
	conn = get_conn()
	cursor = conn.cursor()
	query = "SELECT deporte.nombre, COUNT(*) FROM hincha_deporte JOIN deporte ON hincha_deporte.deporte_id = deporte.id GROUP BY deporte.nombre;"	
	cursor.execute(query)
	supporters_per_sport = cursor.fetchall()
	return supporters_per_sport