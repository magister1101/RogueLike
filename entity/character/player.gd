extends CharacterBody2D


@export var speed: int = 50



func _physics_process(delta):
	handleInput()
	
func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down");
	var isRunning = Input.is_action_pressed("running");
	velocity = moveDirection*speed
	move_and_slide()
