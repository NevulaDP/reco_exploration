extends Node
class_name DialogInteract

@export var timeline: DialogicTimeline #replace with data load
@onready var state_chart_self = $"../StateChart"
func _ready():
	Dialogic.timeline_ended.connect(_on_timeline_ended)

func _on_talking_state_entered():
	var state_chart_player = get_tree().get_first_node_in_group("player").get_node("%StateChart")
	state_chart_player.send_event("is_talking")
	await Dialogic.start(timeline)
	get_viewport().set_input_as_handled()

func _on_timeline_ended():
	state_chart_self.send_event("chat_finish")
	InteractionManager.can_interact=true
	var state_chart_player = get_tree().get_first_node_in_group("player").get_node("%StateChart")
	state_chart_player.send_event("ended_talking")
	
