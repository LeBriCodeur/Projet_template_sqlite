extends Node2D

onready var info = $info

var player

func _ready():
	player = Game.player
	show_info()

func show_info():
	var line = "Info du joueur :\n"
	line += "name : %s\n" % player._name
	line += "cash : %s\n" % player.cash
	line += "bank : %s\n" % player.bank
	line += "num : %s\n" % player.nums
	line += "xp : %s" % player.xp
	info.text = line
