extends Node

# For easy access.

var is_checking_match := false
var available_cards : Array[Button]

signal card_substracted

func substractAvailableCards(at : int) -> void:
	available_cards.pop_at(at)
