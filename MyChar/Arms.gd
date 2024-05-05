extends Node2D
@onready var arms_sprite = $ArmsSprite
@onready var char_sprite = $"../Sprite"
@onready var sfx_polar_star_1 = $sfxPolarStar1
@onready var spawn_side = $SpawnSide
@onready var spawn_up = $SpawnUp
@onready var spawn_down = $SpawnDown

const CAR_SHOT_FIRED = preload("res://Caret/CarShotFired.tscn")
var shots_fired : int = 0;
var spawn_position : Vector2 = Vector2(0,0)

func check_fire():
	if Input.is_action_just_pressed("shoot"):
		var instance=CAR_SHOT_FIRED.instantiate()
		instance.position=global_position+spawn_position;
		add_child(instance)
		sfx_polar_star_1.play();

func animate():
	arms_sprite.flip_h=char_sprite.flip_h
	
	match int(owner.facing_direction.y):
		0:
			arms_sprite.frame=0;
			arms_sprite.position=Vector2(4,-8+8)
			spawn_position = spawn_side.position;
		-1:
			arms_sprite.frame=1;
			arms_sprite.position=Vector2(3,-12+8)
			spawn_position = spawn_up.position;
		1:
			arms_sprite.frame=2;
			arms_sprite.position=Vector2(4,-4+8)
			spawn_position = spawn_down.position;
			
	arms_sprite.position.x=abs(arms_sprite.position.x)*owner.facing_direction.x
	spawn_position.x=abs(spawn_position.x)*owner.facing_direction.x
	if char_sprite.frame == 1 or char_sprite.frame == 3:
		arms_sprite.position.y-=1;
