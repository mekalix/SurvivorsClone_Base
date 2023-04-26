extends CharacterBody2D

@export var movement_speed = 20.0
@export var health = 60.0
@export var knockback_recovery = 3.5
var knockback = Vector2.ZERO

@onready var sprite = $Sprite2D
@onready var player = get_tree().get_first_node_in_group("player")
@onready var animationPlayer = $AnimationPlayer

func _ready():
	animationPlayer.play("walk")

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed
	velocity += knockback
	move_and_collide(velocity * delta)

	if direction.x > 0.1:
		sprite.flip_h = true
	elif direction.x < -0.1:
		sprite.flip_h = false


func _on_hurt_box_hurt(damage, angle, knockback_amount):
	health -= damage
	knockback = angle * knockback_amount
	if health <= 0:
		queue_free()
