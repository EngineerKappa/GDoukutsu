extends Node2D
class_name Bullet
@export var speed = 400;
@export var sprite : Sprite2D;
@export var dissipate_effect : PackedScene
@export var collision_effect : PackedScene
@export var raycast : Node2D;
var velocity : Vector2 = Vector2(0,0);
var direction : Vector2 = Vector2(0,0);
var damage = 1
var destroyed=false;

func create():
	pass;

func destroy():
	var instance = collision_effect.instantiate()
	
	if raycast is RayCast2D && raycast.is_colliding():
		instance.global_position=raycast.get_collision_point()
	elif raycast is ShapeCast2D && raycast.is_colliding():
		instance.global_position=raycast.get_collision_point(0)
	get_parent().add_child(instance)	
	destroyed=true;
	queue_free()
	pass;

func timeout():
	var instance = dissipate_effect.instantiate()
	instance.global_position=global_position
	get_parent().add_child(instance)	
	destroyed=true
	queue_free();
	pass;

func _ready():
	create();
	velocity = direction * speed
	rotation = velocity.angle();
	set_as_top_level(true);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position+=velocity * delta;
	if raycast is RayCast2D && raycast.is_colliding():
		destroy();
	elif raycast is ShapeCast2D && raycast.is_colliding():
		destroy();
		
	pass

func _on_lifetime_timeout():
	if !destroyed:
		timeout();
	pass # Replace with function body.
