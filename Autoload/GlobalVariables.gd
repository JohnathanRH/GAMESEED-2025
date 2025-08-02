extends Node

# For easy access.

enum State { IDLE, AWAITING_SECOND_CARD, CHECKING }
var current_state = State.IDLE
var card_grid : GridContainer
var check_time: float = 0.4

signal check_time_changed(value)

func set_check_time(new_check_time: int):
	check_time = new_check_time
