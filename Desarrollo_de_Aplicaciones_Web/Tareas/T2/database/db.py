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

def get_comunneNregion(commune, region):
	conn = get_conn()
	cursor = conn.cursor()
	cursor.execute(
		"SELECT comuna.id, comuna.nombre, region.id, region.nombre FROM comuna JOIN region ON comuna.region_id=region.id WHERE comuna.nombre=%s AND region.nombre=%s;",
		(commune, region))
	communeNregion = cursor.fetchone()
	return communeNregion

def get_handicraft_type(handicraft_type):
	conn = get_conn()
	cursor = conn.cursor()
	cursor.execute("SELECT nombre FROM tipo_artesania WHERE tipo_artesania=%s;", (handicraft_type,))
	handicraft_type_name = cursor.fetchone()
	return handicraft_type_name
