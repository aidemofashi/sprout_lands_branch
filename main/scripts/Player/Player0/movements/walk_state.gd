extends NodeState

@export var player : CharacterBody2D
@export var anima2d : AnimatedSprite2D
@export var speed : int = 50

@onready var sfx := player.get_node("SfxFootStep") as AudioStreamPlayer2D

func _on_process(_delta:float) -> void:
	pass

func _on_physics_process(_delta: float) -> void:
	var direction : Vector2 = GameInputEvent_player0.movement_input()
	if GameInputEvent_player0.is_movment_input():
		if not sfx.playing:
			sfx.play()
	if direction == Vector2.UP :
		anima2d.play("walking_back")
		anima2d.sprite_frames.set_animation_speed("walking_back",speed/10)
	elif direction == Vector2.DOWN :
		anima2d.play("walking_front")
		anima2d.sprite_frames.set_animation_speed("walking_front",speed/10)
	elif direction == Vector2.LEFT :
		anima2d.play("walking_left")
		anima2d.sprite_frames.set_animation_speed("walking_left",speed/10)
	elif direction == Vector2.RIGHT :
		anima2d.play("walking_right")
		anima2d.sprite_frames.set_animation_speed("walking_right",speed/10)
		
	player.velocity = direction * speed
	player.move_and_slide()
func _on_next_transitions() -> void:
	if !GameInputEvent_player0.is_movment_input():
		transition.emit("Idle")

func _on_enter() -> void:
	pass

func _on_exit() -> void:
	anima2d.stop()
