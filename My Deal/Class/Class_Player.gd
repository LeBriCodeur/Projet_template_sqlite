extends Resource

class_name Player

var _name = "" setget _set_name, _get_name
var xp = {} setget set_xp, get_xp
var cash = 0 setget set_cash, get_cash
var bank = 0 setget set_bank, get_bank
var nums = {}

func _set_name(value): _name = value
func _get_name(): return _name

func set_xp(value): xp = value
func get_xp(): return xp

func set_cash(value): cash = value
func get_cash(): return cash

func set_bank(value): bank = value
func get_bank(): return bank

func _init(a_name, a_cash, a_bank, a_nums, a_xp):
	_name = a_name
	cash = a_cash
	bank = a_bank
	nums = a_nums
	xp = a_xp
