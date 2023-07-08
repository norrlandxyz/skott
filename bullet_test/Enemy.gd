extends CharacterBody2D
@onready var joakim = $"../../Joakim"
@onready var enemy_health_bar = $"../EnemyHealth"
@onready var enemy_node = $".."
var loadBullet = preload("res://bullet_test/enemy/enemy_bullet.tscn")
var health = 100
@onready var gun_point = $gunPoint
@onready var gun_enemy_timer = $gunPoint/gunEnemyTimer

func _ready():
	gun_enemy_timer.start()
	enemy_health_bar.max_value = health
	enemy_health_bar.value = health

func _physics_process(delta):
	look_at(joakim.global_position)


func _on_hitbox_body_entered(body):
	print("Enemy:" + str(body) + " entered enemy space!")
	if body.is_in_group("bullet"):
		body.queue_free()
		take_damage(50)

func take_damage(dmg):
	health -= dmg
	print("Enemy: took " + str(dmg) + " damage;")
	print(str(health) + " health left;")
	if health <= 0:
		print("enemy dead")
		enemy_node.queue_free()
	enemy_health_bar.value = health

func spawn_bullet():
	var bullet = loadBullet.instantiate()
	bullet.position = gun_point.global_position
	bullet.look_at(joakim.global_position)
	get_window().call_deferred("add_child", bullet)


func _on_gun_enemy_timer_timeout():
	spawn_bullet();
	gun_enemy_timer.start()
