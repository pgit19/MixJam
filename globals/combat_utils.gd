extends Node

signal character_damaged


func damage_character(damage : float, character : Character):
	character_damaged.emit(damage, character)
