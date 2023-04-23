extends CharacterBody2D

@export var movement_speed = 20.0
@export var health = 60.0

@onready var sprite = $Sprite2D
@onready var player = get_tree().get_first_node_in_group("player")
@onready var animationPlayer = $AnimationPlayer

func _ready():
	animationPlayer.play("walk")

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed
	move_and_collide(velocity * delta)

	if direction.x > 0.1:
		sprite.flip_h = true
	elif direction.x < -0.1:
		sprite.flip_h = false


func _on_hurt_box_hurt(damage):
	health -= damage
	if health <= 0:
		queue_free()
