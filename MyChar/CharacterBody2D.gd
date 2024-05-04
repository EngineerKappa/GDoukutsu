extends CharacterBody2D
class_name MyChar

#region Dependencies
@onready var sprite = $Sprite
@onready var sfx_jump = $SFX/sfxJump
@onready var sfx_thud = $SFX/sfxThud
@onready var sfx_walk = $SFX/sfxWalk
@onready var sfx_bonk = $SFX/sfxBonk


#endregion

#region Physics conversion functions

#Movement units in cave story are 512 units larger than each screen pixel.
#The original freeware version also updates at 50hz.
#Delta calculations need to account for (units/512)*50

#This function translates values directly from Cave Story's source code to 
#velocity values for use with move_and_slide()

#If you want the faster timings from the nicalis ports, set the engine timescale to 1.2

func cs_velocity(value):
	return ((value * 50)/512)
func cs_acceleration(value):
	return ((value * 50)/512)*50
#endregion

#region Variable Definitions
#Init timers
var walk_timer : Timer = Timer.new();
var jump_buffer : Timer = Timer.new();

#Inputs
@export var facing_direction = Vector2(1,0)
var input_direction = Vector2(0,0)

#Horizontal Movement
var max_speed:float = cs_velocity(812.00);
var acceleration:float = cs_acceleration(85.3333);
var friction_normal:float = cs_acceleration(51.2);

#Vertical Movement
var jump_velocity : float = cs_velocity(1280);
var gravity_falling : float = cs_acceleration(80)
var gravity_jump : float = cs_acceleration(32)

var max_velocity = Vector2(cs_velocity(1535),cs_velocity(1535))

#Animation 
var sprite_frame:int = 0;
var sprite_frame_progress:float = 0;
var target_animation:String = "";

#FX
var landing_fx_enabled:bool = false;
var on_floor:bool = true;
var back:bool = false;

#endregion

func _ready():
	add_child(walk_timer)
	add_child(jump_buffer)
	walk_timer.wait_time = .2;
	walk_timer.autostart=false;
	walk_timer.timeout.connect(footstep)
	
	jump_buffer.wait_time=.15
	jump_buffer.one_shot=true
	apply_floor_snap()
	move_and_slide()

func _process(_delta):
	input_direction.x = Input.get_axis("move left", "move right")
	input_direction.y = Input.get_axis("aim up", "aim down")

func apply_gravity(delta):
	if is_on_floor():
		if !on_floor:
			on_floor=true
			if landing_fx_enabled:
				sfx_thud.play();
			landing_fx_enabled=true;
	else:
		on_floor=false;
		if Input.is_action_pressed("jump") && velocity.y<0:
			velocity.y += gravity_jump * delta;
		else:
			velocity.y += gravity_falling * delta;
			
	velocity.y=clamp(velocity.y,-max_velocity.y,max_velocity.y)

func jump_check():
	if Input.is_action_just_pressed("jump"):
		jump_buffer.start();
	# Handle jump.
	if !jump_buffer.is_stopped() and is_on_floor():
		velocity.y = -jump_velocity
		sfx_jump.play();
		jump_buffer.stop();
	
	if is_on_ceiling():
		sfx_bonk.play();
		
func aim_check():
	facing_direction.y = input_direction.y;
	if is_on_floor() && facing_direction.y == 1:
		if input_direction.x==0:
			back = true;
		facing_direction.y=0;
	if !on_floor or input_direction.x!=0 or input_direction.y==-1:
		back = false;
		
func move_horizontally(delta):
	if input_direction.x!=0:
		velocity.x = move_toward(velocity.x,max_speed*input_direction.x,acceleration * delta)
		if !Input.is_action_pressed("strafe"):
			facing_direction.x=input_direction.x
		sprite.flip_h = (facing_direction.x<0)
		if walk_timer.is_stopped() && on_floor:
			walk_timer.start()
			footstep();
	else:
		walk_timer.stop();

	velocity.x = move_toward(velocity.x, 0, friction_normal * delta)
	velocity.x=clamp(velocity.x,-max_velocity.x,max_velocity.x)

func footstep():
	if on_floor && !sfx_thud.playing:
		sfx_walk.play();

func animate_normal():
	sprite_frame = sprite.frame
	sprite_frame_progress = sprite.frame_progress
	if facing_direction.y == 0:
		target_animation = "walk_forward"
	if facing_direction.y == -1:
		target_animation = "walk_up"
	elif facing_direction.y == 1:
		target_animation = "aim_down"
	if back:
		target_animation = "back"
	
	if sprite.animation!=target_animation:
		sprite.set_animation(target_animation)
		sprite.set_frame_and_progress(sprite_frame,sprite_frame_progress)
	
	if is_on_floor():
		if abs(velocity.x)>0 && input_direction.x !=0:
			sprite.speed_scale = 1;
		else:
			sprite.speed_scale = 0;
			sprite.frame = 0;
	else:
		sprite.speed_scale = 0;
		if velocity.y<0:
			sprite.frame = 3
		else:
			sprite.frame = 1
