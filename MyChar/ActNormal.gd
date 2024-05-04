extends State
@export var body:CharacterBody2D

func handle_input(_event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(_delta: float) -> void:
	owner.jump_check();
	owner.aim_check();
	owner.apply_gravity(_delta);
	owner.move_horizontally(_delta)
	owner.animate_normal();
	owner.move_and_slide()
	pass

func enter(_msg := {}) -> void:
	pass

func exit() -> void:
	pass
