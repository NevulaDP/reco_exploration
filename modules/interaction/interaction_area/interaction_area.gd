extends Area2D
class_name InteractionArea

@export var action_name: String = "interact"
var body

var interact: Callable = func():
	pass	




func _on_body_entered(body):
	if body.is_in_group("player"):
		InteractionManager.register_area(self)
		self.body=body
	
	


func _on_body_exited(body):
	if body.is_in_group("player"):
		InteractionManager.unregister_area(self)
