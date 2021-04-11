extends Node

signal cfg_valide
var CfgGame
var player : Player setget set_player, get_player
const NAME_Configfile = "CfgGame.json"


func _ready():
	get_exist_config_user()
#	yield(self, "cfg_valide")
	CfgGame = load_cfg("user://Configs/%s" % NAME_Configfile)
	print("load cfg : ", CfgGame)

func set_player(value): player = value
func get_player(): return player

func get_cfgGame(): return CfgGame

func random(value = 100):
	randomize()
	return randi() % value + 1

func create_num():
	randomize()
	var prefix = ["06", "07"]
	prefix = prefix[randi() % prefix.size()]
	print("prefix : ", prefix)
	var n : String= "%s" % prefix
	for i in 4:
		randomize()
		n += str(ceil(rand_range(10, 99)))
	return n


func get_exist_config_user():
	var file = File.new()
	var dir = Directory.new()
	if !dir.dir_exists("user://Configs"):
		dir.make_dir("user://Configs")
	if !file.file_exists("user://Configs/%s" % NAME_Configfile): 
		dir.copy("res://Configs/%s" % NAME_Configfile, "user://Configs/%s" % NAME_Configfile)
#	emit_signal("cfg_valide")

func load_cfg(file_path):
	var file = File.new()
	assert (file.file_exists(file_path))
	file.open(file_path, file.READ)
	var cfg = parse_json(file.get_as_text())
	assert (cfg.size() > 0)
	return cfg
