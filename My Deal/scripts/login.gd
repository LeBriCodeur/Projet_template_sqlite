extends Control

onready var list = $Bg/ListProfil

var main_lvl = preload("res://scenes/Main.tscn")
var list_profilname : Array
var CfgGame
func _ready():
	CfgGame = Game.get_cfgGame()
	update_list()


func _on_btn_create():
	var profilname = $Bg/LineEdit.text
	if profilname.empty(): 
		print("Merci de choisir un nom de profil.")
		return
	if profilname.to_lower() in list_profilname: 
		print("Nom de profil déjà existant.")
		return
	var num = {"ligne_1":{"num": Game.create_num(),"nameline": "Ligne principal"}}
	var xp = {"lvl":0,"xp":0,"xp_max":150}
	DB.insert_profil(profilname, CfgGame.cash_start, CfgGame.bank_start, num, xp)
	var p = Player.new(profilname, CfgGame.cash_start, CfgGame.bank_start, num, xp)
	Game.player = p
	print("Profil créé, chargement du jeu.")
#	update_list()
	run_game()

func update_list():
	var all = DB.get_profils()
	list.clear()
	for i in all:
		list_profilname.append(i.name.to_lower())
		list.add_item(i.name)
		list.set_item_metadata(list.get_item_count()-1, to_json(i))

func run_game():
	get_tree().change_scene_to(main_lvl)

func get_data_list():
	var arr_idx = list.get_selected_items()
	if arr_idx.empty(): return
	var idx = arr_idx[0]
	return list.get_item_metadata(idx)


func _on_BtnDelete():
	var data = get_data_list()
	if !data: return
	data = parse_json(data)
	list_profilname.remove(list_profilname.find(data.name.to_lower()))
	DB.delete_profil(data.id)
	update_list()


func _on_BtnValide():
	var data = get_data_list()
	if !data: return
	data = parse_json(data)
	var p = Player.new(data.name, data.cash, data.bank, data.numero, data.exp)
	Game.player = p
	run_game()
