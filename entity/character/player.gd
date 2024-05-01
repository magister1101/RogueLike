extends CharacterBody2D


@export var speed: int = 50;
@export var runningSpeed: int = 100;
@export var animationPlayer: AnimationPlayer;



func _physics_process(delta):
	handleInput();
	
func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down");
	var isRunning = Input.is_action_pressed("running");

	animations();
	
	velocity = moveDirection*speed;
	if isRunning:
		velocity = moveDirection*runningSpeed;
	move_and_slide();
	
func animations():
	var play = "idle";
	
	if velocity.x > 0:
		play = "walkRight";
	elif velocity.x < 0:
		play = "walkLeft";
	elif velocity.y > 0:
		play = "walkDown";
	elif velocity.y < 0:
		play = "walkUp";
	
	animationPlayer.play(play)
	
	
