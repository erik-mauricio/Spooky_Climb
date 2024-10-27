extends CharacterBody2D

@export var speed = 100
@export var jump_speed = -100
@export var gravity = 500
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0 , 1.0) var acceleration = 0.25

@onready var sprite = $AnimatedSprite2D
@export var move_animation_speed = 2
@export var idle_animation_speed = 1

func _physics_process(delta):
	velocity.y += gravity * delta
	var dir = Input.get_axis("left", "right")
	
	# Movement logic
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
		# Set animation speed for movement
		sprite.speed_scale = move_animation_speed
		# Play the appropriate moving animation
		if dir > 0:
			sprite.play("move_right")
		else:
			sprite.play("move_left")
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
		# Set animation speed for idle
		sprite.speed_scale = idle_animation_speed

	move_and_slide()
	
	# Jump logic
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed
