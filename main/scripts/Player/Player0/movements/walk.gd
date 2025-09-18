extends CharacterBody2D

@export var anima2d : AnimatedSprite2D

var speed = 60
var direction = 0  # 0=front, 1=back, 2=left, 3=right

func _physics_process(_delta) -> void:
	# 重置速度
	velocity = Vector2.ZERO
	
	# 检测键盘输入并移动
	var is_moving = false
	if Input.is_action_pressed("walk_front"):
		velocity.y += 1
		anima2d.play("walking_front")
		anima2d.sprite_frames.set_animation_speed("walking_front",speed/10)
		direction = 0
		is_moving = true
	elif Input.is_action_pressed("walk_back"):
		velocity.y -= 1
		anima2d.play("walking_back")
		anima2d.sprite_frames.set_animation_speed("walking_back",speed/10)
		direction = 1
		is_moving = true
	elif Input.is_action_pressed("walk_left"):
		velocity.x -= 1
		anima2d.play("walking_left")
		anima2d.sprite_frames.set_animation_speed("walking_left",speed/10)
		direction = 2
		is_moving = true
	elif Input.is_action_pressed("walk_right"):
		velocity.x += 1
		anima2d.play("walking_right")
		anima2d.sprite_frames.set_animation_speed("walking_right",speed/10)
		direction = 3
		is_moving = true
	
	# 如果没有移动输入，播放对应方向的待机动画
	if not is_moving:
		match direction:
			0:  # front
				anima2d.play("idle_front")
			1:  # back
				anima2d.play("idle_back")
			2:  # left
				anima2d.play("idle_left")
			3:  # right
				anima2d.play("idle_right")
	
	# 标准化速度并移动
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	move_and_slide()
