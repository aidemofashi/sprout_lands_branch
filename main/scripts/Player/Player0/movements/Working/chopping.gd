extends  NodeState

@export var player: Player
@export var anima2d : AnimatedSprite2D
@export var hit_component_collision_shape : CollisionShape2D

func _ready() -> void:
	hit_component_collision_shape.disabled = true
	hit_component_collision_shape.position = Vector2(0,0)
	
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
			anima2d.play("chopping_back")
			hit_component_collision_shape.position = Vector2(0,-17)
		elif player.player_direction == Vector2.DOWN:
			anima2d.play("chopping_front")
			hit_component_collision_shape.position = Vector2(0,5)
		elif player.player_direction == Vector2.LEFT:
			anima2d.play("chopping_left")
			hit_component_collision_shape.position = Vector2(-9,0)
		elif player.player_direction == Vector2.RIGHT:
			anima2d.play("chopping_right")
			hit_component_collision_shape.position = Vector2(9,0)
			
		hit_component_collision_shape.disabled = false
		
func _on_exit() -> void:
	anima2d.stop()
	hit_component_collision_shape.disabled = true
