extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
@export var move_animation_speed = 2
@export var idle_animation_speed = 1


func _physics_process(delta):
	var dir = Input.get_axis("left", "right")
	move_and_slide()
	
	# Horizontal movement logic
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * 200, 10 * delta)  # Replace 'speed' with 200, 'acceleration' with 10
		sprite.speed_scale = move_animation_speed
		if dir > 0:
			sprite.play("move_right")
		else:
			sprite.play("move_left")
	else:
		velocity.x = lerp(velocity.x, 0.0, 5 * delta)  # Replace 'friction' with 5
		sprite.speed_scale  = idle_animation_speed
	
	# Jump logic
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -800  # Replace 'jump_speed' with -800
	
	# Apply gravity
	if not is_on_floor():
		velocity.y += 980 * delta  # Gravity adjustment
	
