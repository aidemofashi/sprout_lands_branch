class_name Player
extends CharacterBody2D

@export var current_tools : DataTypes.Tools = DataTypes.Tools.None

var player_direction : Vector2

func _process(_delta: float) -> void:
	if !GameInputEvent.is_movment_input():
		player_direction = GameInputEvent_player0.last_direction
