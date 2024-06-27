extends Node2D

class_name NPCMovement


@onready var last_pos= actor.global_position
@onready var animation_tree = $"../AnimationTree"
@onready var anim_state = animation_tree.get("parameters/playback")
@onready var path2d:PathFollow2D = get_parent().get_parent()
@onready var interaction_area = $"../InteractionArea"

@export var actor:CharacterBody2D
@export var speed =20
var dir:Vector2

func _physics_process(delta):
	path2d.progress +=speed*delta
	dir = (actor.global_position-last_pos).normalized()
	if dir !=Vector2.ZERO:
		anim_state.travel("walk")
		animation_tree.set("parameters/walk/blend_position",dir)
		animation_tree.set("parameters/idle/blend_position",dir)
	else:
		anim_state.travel("idle")
		pass
	last_pos=actor.global_position
	



func _on_talking_state_entered():
	#anim_state.travel("idle")
	#animation_tree.set("parameters/walk/blend_position",dir)
	#animation_tree.set("parameters/idle/blend_position",dir)
	speed =0
	#dir =Vector2.ZERO
	var vector = interaction_area.body.global_position - actor.global_position
	var vecangle = rad_to_deg(-vector.angle())
	if (vecangle >-45 and vecangle <45):
		dir = Vector2(1,0)
	elif (vecangle >45 and vecangle <135):
		dir = Vector2(0,-1)
	elif (vecangle >135 or vecangle <-135):
		dir = Vector2(-1,0)
	elif (vecangle <-45 and vecangle >-135):
		dir = Vector2(0,1)
	animation_tree.set("parameters/idle/blend_position",dir)
	print(vecangle)
	



func _on_talking_state_exited():
	speed=20
	
