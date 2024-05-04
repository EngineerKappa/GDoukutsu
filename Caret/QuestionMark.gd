extends Sprite2D
@onready var lifetime = $"../Lifetime"

func _process(delta):
	if lifetime.wait_time-lifetime.time_left < 0.12:
		position+=owner.velocity * delta;
	pass
