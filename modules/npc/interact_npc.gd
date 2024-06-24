extends CharacterBody2D
class_name InteractNPC

@onready var interaction_area = $InteractionArea
@export var timeline: DialogicTimeline
signal interaction_end

# Called when the node enters the scene tree for the first time.
func _ready():
	interaction_area.interact = Callable(self,"_on_interact")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_interact():
	var state_chart = get_tree().get_first_node_in_group("player").get_node("%StateChart")
	state_chart.send_event("is_talking")
	Dialogic.timeline_ended.connect(_on_timeline_ended)
	await Dialogic.start(timeline)
	get_viewport().set_input_as_handled()

func _on_timeline_ended():
	InteractionManager.can_interact=true
	var state_chart = get_tree().get_first_node_in_group("player").get_node("%StateChart")
	state_chart.send_event("ended_talking")
