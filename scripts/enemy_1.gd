extends CharacterBody2D
@export var speed = 40
@export var gravity = 900
var direction = -1
@export var damage = 25
@export var damage_delay = 2.0
var player_in_range = false
var can_damage = true
var player_ref = null
func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity*delta
	velocity.x = direction * speed
	move_and_slide()
	if is_on_wall():
		direction *= -1
		scale.x *= -1
func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body.name == "player":
	if body.has_method("take_damage"):
		player_in_range = true
		player_ref = body
		damage_loop()
func _on_area_2d_body_exited(body: Node2D) -> void:
	#print("Something entered",body.name)
	#if body.name == "player":
	#if body is CharacterBody2D:
	if body.has_method("take_damage"):
		player_in_range = false
		player_ref = null
func damage_loop():
	if not can_damage:
		return
	can_damage = false
	if player_in_range and player_ref and is_instance_valid(player_ref):
		player_ref.take_damage(damage)
	await get_tree().create_timer(damage_delay).timeout
	can_damage = true
	if player_in_range:
		damage_loop()
