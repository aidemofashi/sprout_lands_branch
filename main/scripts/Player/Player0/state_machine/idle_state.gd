extends NodeState

@export var player: Player
@export var anima2d:AnimatedSprite2D

var direction: Vector2

func _on_process(_delta:float) -> void:
	pass

func _on_physics_process(_delta:float) -> void:
	direction = GameInputEvent_player0.movement_input()
	if direction == Vector2.UP:
		anima2d.play("idle_back")
	elif direction == Vector2.DOWN:
		anima2d.play("idle_front")
	elif direction == Vector2.LEFT:
		anima2d.play("idle_left")
	elif direction == Vector2.RIGHT:
		anima2d.play("idle_right")
	else:
		anima2d.play("idle_front")
	

func _on_next_transitions() -> void:
	if GameInputEvent_player0.is_movment_input():
		transition.emit("Walk")
		
	if player.current_tools == DataTypes.Tools.AxeWood && GameInputEvent_player0.is_using_tools():
		transition.emit("Chopping")
	
	if player.current_tools == DataTypes.Tools.TillGround && GameInputEvent_player0.is_using_tools():
		transition.emit("Tilling")
		
	if player.current_tools == DataTypes.Tools.WaterCrops && GameInputEvent_player0.is_using_tools():
		transition.emit("Watering")
func _on_enter() -> void:
	pass
 
func _on_exit() -> void:
	anima2d.stop()
