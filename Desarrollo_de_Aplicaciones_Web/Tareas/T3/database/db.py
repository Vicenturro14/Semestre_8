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
