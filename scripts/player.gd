extends CharacterBody2D
@onready var animated_sprite = $AnimatedSprite2D
const SPEED = 150.0
const JUMP_VELOCITY = -275.0
var HEALTH = 100
var is_dead = false
var health_bar
var coins = 0
@onready var coin_label = $"../Player/CoinLabel"
func _ready():
	health_bar = get_tree().get_first_node_in_group("HealthBar")
func _physics_process(delta: float) -> void:
	# Add the gravity.
	var direction := Input.get_axis("Left", "Right")
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite.play("jumping")
	elif direction != 0:
		animated_sprite.play("running")
	else:
		animated_sprite.play("idle")
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		#animated_sprite.play("jump")
	
	if direction > 0:
		animated_sprite.flip_h = true
	elif direction < 0:
		animated_sprite.flip_h = false
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			animated_sprite.play("running")
		elif is_on_floor():
			animated_sprite.play("idle")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if global_position.y > 151:
		Die()
	move_and_slide()
func take_damage(amount):
	if is_dead:
		return
	print("Player got damage")
	HEALTH -= amount
	if health_bar:
		health_bar.value = HEALTH
	print("Health:",HEALTH)
	if HEALTH <= 0:
		Die()
		is_dead = true
func add_coin():
	coins += 1
	coin_label.text = "Coins: " + str(coins)
func _on_restart_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
func Die():
	is_dead = true
	get_tree().paused = true
	var death_ui = get_node("../UI/DeathUI/Control")
	death_ui.get_node("died_text").visible = true
	death_ui.get_node("restart").visible = true
