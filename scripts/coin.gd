extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(_body: Node2D) -> void:
	if _body.name == "Player":
		_body.add_coin()
		animation_player.play("pickup_sound")
