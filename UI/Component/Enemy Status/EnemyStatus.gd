extends CanvasLayer

# Get needed nodes and resources
@onready var enemy = self.get_tree().get_first_node_in_group("enemy") as EnemyClass
@onready var enemy_resource = enemy.enemy_resource as EnemyResource
@onready var intent_timer = enemy.get_node("intent_timer") as Timer
@onready var intent_executor = enemy.get_node("intent_executor") as Timer
@onready var enemy_hp = enemy_resource.hp

const ICON_ATTACK_INTENT_OFF = preload("res://Assets/UI/IntentAttackOff.png")
const ICON_SHIELD_INTENT_OFF = preload("res://Assets/UI/IntentDefendOff.png")
const ICON_ABILITY_INTENT_OFF = preload("res://Assets/UI/IntentAbilityOff.png")
const ICON_ATTACK_INTENT_ON = preload("res://Assets/UI/IntentAttackOn.png")
const ICON_SHIELD_INTENT_ON = preload("res://Assets/UI/IntentDefendOn.png")
const ICON_ABILITY_INTENT_ON = preload("res://Assets/UI/IntentAbilityOn.png")

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
	print(enemy.enemy_intent)
	#match enemy.enemy_intent:
		#0: $intent_icon.texture = ICON_ATTACK_INTENT_OFF   # Basic atk icon
		#1: $intent_icon.texture = ICON_ABILITY_INTENT_OFF    # Ability icon
		#2: $intent_icon.texture = ICON_SHIELD_INTENT_OFF  # Block icon
	pass	

func _on_intent_executor_timeout():
	$intent_orb.value = 1
	$intent_icon_timer.start()
	match enemy.enemy_intent:
		0: $intent_icon.texture = ICON_ATTACK_INTENT_ON   # Basic atk icon
		1: $intent_icon.texture = ICON_ABILITY_INTENT_ON    # Ability icon
		2: $intent_icon.texture = ICON_SHIELD_INTENT_ON  # Block icon

func shield_toggled():
	if (enemy_resource.has_shield == true):
		$shield_bar/Timer.start()
	$shield_icon.visible = enemy_resource.has_shield
	$shield_bar.visible = enemy_resource.has_shield


func _on_intent_icon_timer_timeout() -> void:
	$intent_orb.value = 0
	match enemy.enemy_intent:
		0: $intent_icon.texture = ICON_ATTACK_INTENT_OFF   # Basic atk icon
		1: $intent_icon.texture = ICON_ABILITY_INTENT_OFF    # Ability icon
		2: $intent_icon.texture = ICON_SHIELD_INTENT_OFF  # Block icon
