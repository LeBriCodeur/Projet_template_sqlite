extends Node

const LIB_SQL = preload("res://lib/gdsqlite.gdns");
const NAME_DB_FILE = "mydeal_save.db"
const FOLDER = "db"
const DEBUG = true
var PATH = "";


func _ready():
	PATH = "user://{fol}/{fn}".format(get_info())
	db_exist()


func get_info():
	return {"fol":FOLDER,"fn":NAME_DB_FILE}

# Check exist db 
func db_exist():
	var dir = Directory.new()
	var file = File.new()
	print("Check if the database exist")
	if dir.dir_exists("user://{fol}".format(get_info())): 
		if file.file_exists("user://{fol}/{fn}".format(get_info())):
			print("Database is existed")
			return
		dir.copy("res://db/%s" % NAME_DB_FILE, "user://db/%s" % NAME_DB_FILE)
	else:
		dir.make_dir("user://db")
		print("Save folder create")
		dir.copy("res://db/%s" % NAME_DB_FILE, "user://db/%s" % NAME_DB_FILE)
	print("Database create in the save folder")
	print("Database create with succes")


# insert new profil
func insert_profil(a_name, a_cash, a_bank, a_nums, a_xp):
	var _query = "INSERT INTO players (name, cash, bank, numero, exp) VALUES"
	_query += "('%s','%s','%s','%s','%s')" % [a_name, a_cash, a_bank, a_nums, a_xp]
	var r = query(_query)
	if DEBUG:
		print("insert player : ", r)
	return r

# get info profils / monsters
func get_infos(a_name):
	var _query = 'SELECT p.name "nom", p.exp "xp", p.currentMonster "mymonster", m.*' + \
	'FROM profils "p" INNER JOIN monsters "m" WHERE m.owner == p.name and p.name == "%s"' % a_name
	return array(_query)


func get_monsters(a_name):
	var _query = "SELECT * FROM monsters WHERE owner == '%s'" % a_name
	return array(_query)


# get db profils
func get_profils():
	var _query = "SELECT * FROM players"
	return array(_query)
	
# delete profil
func delete_profil(id):
	var _query = "DELETE FROM players WHERE id = %s" % id
	_query = query(_query)

#FNC DB query
func query(query: String) -> bool:
	var db:LIB_SQL = LIB_SQL.new()
	db.open(PATH)
	var _queryrequest = db.query(query)
	db.close()
	print(str(_queryrequest) + ":" + str(query))
	return _queryrequest

#query ARRAY
func array(query: String):
	var db:LIB_SQL = LIB_SQL.new()
	db.open(PATH)
	var _queryrequest: Array = db.fetch_array(query)
	db.close()
	print(str(_queryrequest) + ":" + str(query))
	return _queryrequest
