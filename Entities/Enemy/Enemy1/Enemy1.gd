extends EnemyClass

# All moved to the EnemyClass for the sake of code reusability.
# You can still customize anything right here but i suggest heavily
# That we minimize it. everything that are necessary is already set up within the EnemyClass.

# Custom ability unique to this slime
func ability() -> void:
	AudioManager.play_attack()
	
