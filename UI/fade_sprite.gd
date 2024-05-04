extends AnimatedSprite2D
var delay = 0
var frame_count=sprite_frames.get_frame_count("FadeIn")-1;
@export var fade_out : bool = true;

func _ready():
	if !fade_out:
		frame = frame_count;

func _process(delta):
	delay=max(0,delay-delta)
	
	if delay==0 && !is_playing():
		if fade_out:
			play("FadeIn")
		else:
			play_backwards("FadeIn")
		
	if fade_out:
		if frame==sprite_frames.get_frame_count("FadeIn")-1:
			pause()
	else:
		if frame==0:
			queue_free();
