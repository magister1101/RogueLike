extends CharacterBody2D

@export var speed = 50
@export var navAgent: NavigationAgent2D

var targetNode = null
var homePos = Vector2.ZERO


func _ready():
	homePos = self.global_position
	
	navAgent.path_desired_distance = 4
	navAgent.target_desired_distance = 4
	
func _physics_process(delta):
	if navAgent.is_navigation_finished():
		return
	var axis = to_local(navAgent.get_next_path_position()).normalized()
	velocity = axis * speed
	
	move_and_slide()

func recalcPath():
	if targetNode:
		navAgent.target_position = targetNode.global_position
	else:
		navAgent.target_posiiton = homePos

func _on_timer_timeout():
	recalcPath()

func _on_aggro_range_area_entered(area):
	targetNode = area.owner


func _on_de_aggro_range_area_exited(area):
	if area.owner == targetNode:
		targetNode = null
