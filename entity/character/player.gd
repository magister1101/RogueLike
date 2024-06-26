extends CharacterBody2D


@export var speed: int = 100;
@export var runningSpeed: int = 150;
@export var animationPlayer: AnimationPlayer;
@export var center: Node2D;

#arm for gun
@export var armGun: Node2D;
@export var aimGun: Marker2D;
@export var gun: Node2D;

#arm for sword
@export var armSword: Node2D;
@export var sword: Node2D;

#bullets
@onready var bulletInfo = preload("res://entity/effects/bullet.tscn")

var tempPositionsword;
var tempPositionGun;
var isArmSwitch: bool;


func _ready():
	tempPositionsword = armSword.position;
	tempPositionGun = armGun.position


func _physics_process(delta):
	handleInput();
	switchArm();
	
	
func handleInput():
	var moveDirection = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down");
	var isRunning = Input.is_action_pressed("running");
	var isSwordAttacking = Input.is_action_just_pressed("swordAttack");
	var isGunAttacking = Input.is_action_just_pressed("gunAttack");
	
	armGun.look_at(get_global_mouse_position());
	center.look_at(get_global_mouse_position());
	
	if isGunAttacking:
		gunAttack();
	elif isSwordAttacking:
		swordAttack();
		
	if center.global_rotation < -1.3 and center.global_rotation > -1.7:
		gun.z_index = -1;
	else:
		gun.z_index = 0;
		
	if center.global_rotation > -1.5 and center.global_rotation < 1.5:
		sword.scale.x =+1;
		gun.scale.y =+1;
		isArmSwitch = false;
		
	elif center.global_rotation < -1.5 or center.global_rotation > 1.5:
		gun.scale.y =-1;
		sword.scale.x =-1;
		isArmSwitch = true;
	
	velocity = moveDirection*speed;
	if isRunning:
		velocity = moveDirection*runningSpeed;
	
	move_and_slide();
	animations();
	
	
func switchArm():
	
	if isArmSwitch == true:
		armSword.position = tempPositionGun;
		armGun.position = tempPositionsword;
		gun.position.y;
		
	elif isArmSwitch == false:
		armSword.position = tempPositionsword;
		armGun.position = tempPositionGun;
		gun.position.y
		
	
func swordAttack():
	print_debug("sword attack")
	
	
func gunAttack():
	var mousePosition = get_global_mouse_position();
	var direction_to_mouse = mousePosition - armGun.global_position
	var bullet = bulletInfo.instantiate();
	get_parent().add_child(bullet);
	bullet.position = aimGun.global_position;
	bullet.velocity = direction_to_mouse.normalized()
	
	
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
	
	animationPlayer.play(play);
	
	
