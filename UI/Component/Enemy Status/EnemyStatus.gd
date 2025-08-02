extends Node

# Get needed nodes and resources
@onready var enemy = self.get_tree().get_first_node_in_group("enemy") as EnemyClass
@onready var enemy_resource = enemy.enemy_resource as EnemyResource
@onready var intent_timer = enemy.get_node("intent_timer") as Timer
@onready var intent_executor = enemy.get_node("intent_executor") as Timer

@onready var enemy_hp = enemy_resource.hp

func _ready() -> void:
	# Initialize all of the UI components
	$intent_bar.max_value = enemy_resource.intent_interval*100
	$hp_bar.max_value = enemy_hp
	$shield_bar.max_value = enemy_resource.block_duration*100
	$shield_bar/Timer.wait_time = enemy_resource.block_duration
	
	$hp_bar.value = enemy_resource.hp
	
	# Connect the intent timers, to update the UI appropriately
	intent_timer.timeout.connect(_on_intent_timer_timeout)
	intent_executor.timeout.connect(_on_intent_executor_timeout)
	enemy_resource.hasShieldSet.connect(shield_toggled)

func _process(delta: float) -> void:
	$intent_bar.value = $intent_bar.max_value - (intent_timer.time_left*100)
	$hp_label.text = str(enemy_resource.hp) + "/" + str(enemy_hp)
	$hp_bar.value = enemy_resource.hp
	$shield_bar.value = $shield_bar/Timer.time_left*100

# Update icon after the enemy intent timer timed out
func _on_intent_timer_timeout():
	$intent_orb.value = 1
	match enemy.enemy_intent:
		0: $intent_icon.texture = load("res://Assets/Card/SymbolSword.png")   # Basic atk icon
		1: $intent_icon.texture = load("res://Assets/Card/SymbolFire.png")    # Ability icon
		2: $intent_icon.texture = load("res://Assets/Card/SymbolShield.png")  # Block icon
			

func _on_intent_executor_timeout():
	$intent_orb.value = 0

func shield_toggled():
	if (enemy_resource.has_shield == true):
		$shield_bar/Timer.start()
	$shield_icon.visible = enemy_resource.has_shield
	$shield_bar.visible = enemy_resource.has_shield
