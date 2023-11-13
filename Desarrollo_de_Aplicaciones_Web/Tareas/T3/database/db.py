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

def get_comunneNregion(comunne, region):
	conn = get_conn()
	cursor = conn.cursor()
	cursor.execute(
		"SELECT comuna.id, comuna.nombre, region.id, region.nombre FROM comuna JOIN region ON comuna.region_id=region.id WHERE comuna.nombre=%s AND region.nombre=%s;",
		(comunne, region))
	comunneNregion = cursor.fetchone()
	return comunneNregion

def get_handicraft_type(handicraft_type):
	conn = get_conn()
	cursor = conn.cursor()
	cursor.execute("SELECT id, nombre FROM tipo_artesania WHERE nombre=%s;", (handicraft_type,))
	handicraft_type_tuple = cursor.fetchone()
	return handicraft_type_tuple

def create_handicrafter(name, email, comunne_id, phone = "", handicraft_desc = ""):
	conn = get_conn()
	cursor = conn.cursor()
	query = "INSERT INTO artesano (nombre, email, comuna_id, celular, descripcion_artesania) VALUES (%s, %s, %s, %s, %s);"
	cursor.execute(query, (name, email, comunne_id, phone, handicraft_desc))
	conn.commit()

def get_handicrafter_id(name, email):
	conn = get_conn()
	cursor = conn.cursor()
	cursor.execute("SELECT id FROM artesano WHERE nombre=%s AND email=%s;",(name, email))
	id = cursor.fetchone()
	return id

def create_handicrafter_type(handicrafter_id, handicraft_type_id):
	conn = get_conn()
	cursor = conn.cursor()
	query = "INSERT INTO artesano_tipo (artesano_id, tipo_artesania_id) VALUES (%s, %s);"
	cursor.execute(query, (handicrafter_id, handicraft_type_id))
	conn.commit()

def create_image(file_path, file_name, handicrafter_id):
	conn = get_conn()
	cursor = conn.cursor()
	query = "INSERT INTO foto (ruta_archivo, nombre_archivo, artesano_id) VALUES (%s, %s, %s);"
	cursor.execute(query, (file_path, file_name, handicrafter_id))
	conn.commit()
