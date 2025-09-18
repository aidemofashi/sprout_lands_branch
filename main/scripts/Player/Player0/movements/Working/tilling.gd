extends  NodeState

@export var player: Player
@export var anima2d : AnimatedSprite2D
func _on_process(_delta:float) -> void:
	pass

func _on_physics_process(_delta:float) -> void:
	pass

func _on_next_transitions() -> void:
	if !anima2d.is_playing():
		transition.emit("Idle")
		
func _on_enter() -> void:
	if GameInputEvent_player0.is_using_tools():
		if player.player_direction == Vector2.UP:
			anima2d.play("tilling_back")
		elif player.player_direction == Vector2.DOWN:
			anima2d.play("tilling_front")
		elif player.player_direction == Vector2.LEFT:
			anima2d.play("tilling_left")
		elif player.player_direction == Vector2.RIGHT:
			anima2d.play("tilling_right")
func _on_exit() -> void:
	anima2d.stop()
