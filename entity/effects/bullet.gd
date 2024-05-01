extends CharacterBody2D

@export var speed: int = 450;
@onready var bulletExpireTimer = $Timer;

func _physics_process(delta):
	var collision_info = move_and_collide(velocity.normalized() * delta * speed);


func _on_visible_on_screen_notifier_2d_screen_exited():
	bulletExpireTimer.start()
	await bulletExpireTimer.timeout;
	queue_free();


func _on_area_2d_area_entered(area):
	if area.name == "hitBox":
		queue_free();
