extends Area2D
var lvl_done = false
func _on_body_entered(_body: Node2D) -> void:
	if _body.name == "Player":
		$FinishUI/Control_2/lvl_complete_txt.visible = true
		$FinishUI/Control_2/restart_2.visible = true
func _on_restart_2_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
