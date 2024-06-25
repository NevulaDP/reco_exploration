extends Node2D

class_name PlayerMovement

const tile_size:int = 64
var moving:bool = false
var input_dir : Vector2
var speed:int = 1
#Character
@export var actor: CharacterBody2D #player node
@onready var animation_tree = $"../AnimationTree"
@onready var anim_state = animation_tree.get("parameters/playback")
@onready var state_chart = %StateChart



func _physics_process(delta):
	input_dir=Vector2(Input.get_action_strength("ui_right")-Input.get_action_strength("ui_left"),
	Input.get_action_strength("ui_down")-Input.get_action_strength("ui_up")).normalized()
	
	actor.velocity = input_dir*delta*3000*speed
	if input_dir !=Vector2.ZERO:
		anim_state.travel("walk")
		animation_tree.set("parameters/walk/blend_position",input_dir)
		animation_tree.set("parameters/idle/blend_position",input_dir)
	else:
		actor.velocity=Vector2.ZERO
		anim_state.travel("idle")
	actor.move_and_slide()



func _on_talking_state_entered():
	input_dir=Vector2.ZERO
	actor.velocity=Vector2.ZERO
	anim_state.travel("idle")
	self.set_physics_process(false)


func _on_walking_state_entered():
	self.set_physics_process(true)
