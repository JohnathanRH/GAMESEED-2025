extends Node

# For easy access.

enum State { IDLE, AWAITING_SECOND_CARD, CHECKING }
var current_state = State.IDLE
var card_grid : GridContainer
var check_time: float = 0.4

signal check_time_changed(value)
