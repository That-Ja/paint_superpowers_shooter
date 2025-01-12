extends CharacterBody3D

const Speed:float = 2.0  # Initial lower movement speed
const Max_speed:float = 4.5  # Maximum movement speed
@export var Acceleration:float = sqrt(2)  # Acceleration rate
@export var Jump_Velocity:float = 6.0  # Standard jump velocity
@export var Fall_Slowdown_Rate:float = 0.05 # Rate at which the fall is slowed
@export var Ungravity_time:float = 3.0  # Time for slow fall
@export var Mouse_Sensitivity:float = Config.Mouse_Sens  # Mouse rotation sensitivity
var aim:bool = false
var is_Spawning:bool = true #Check if its spawning to stop users from slow-falling on spawn
var is_mouse_showing:bool = false
@export var ungravity_slow_specs:float = (sqrt(2)/10)
# Get the gravity from the project settings
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
# To store the rotation
var rotation_y = 0.0
var current_speed = Speed  # Start with the lower speed
var is_slow_falling:bool = false  # Track if slow fall is active
signal shooting_signal(shoot_paint:float)
var shoot_paint:bool= false
var stain_notify:bool = false
func _ready():
	# Hide the mouse cursor and capture it
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	# Check if the event is a mouse motion event
	if event is InputEventMouseMotion:
		if is_mouse_showing !=true:
			# Rotate based on mouse movement
			rotation_y -= event.relative.x * Mouse_Sensitivity
			rotation = Vector3(0, rotation_y, 0)

func _physics_process(delta):
	#Burrow
	#if Config.burrow_affect == true and Input.is_action_pressed("Burrowing"):
		#$CollisionShape3D/Char_main_body.transparency = 0
		#$CollisionShape3D/Char_main_body.collision_mask = false
		#$CollisionShape3D/Char_main_body/Aim_Box.visible = true
		
		#print("Im burrowing")
	if Config.burrow_affect == false:
		pass
	 #Slow falling
	if not is_on_floor():
		if Input.is_action_pressed("Ungravity") and is_slow_falling ==true and is_Spawning ==false:
			if is_slow_falling ==true:
				velocity.y = -ungravity_slow_specs
			# Slow fall when jump is pressed and slow fall is active
			gravity = (gravity / Fall_Slowdown_Rate) * delta
			# Start the normal falling
			await get_tree().create_timer(Ungravity_time).timeout
			#print("Your ungravity privileges has ended")
			gravity = 9.8
			velocity.y = gravity*delta
			is_slow_falling = false
		else:
			# Normal fall (with gravity) when not slow falling
			velocity.y -= gravity * delta
# Handle jump reset
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		# Start the jump and enable slow fall
		current_speed = min(current_speed + Acceleration * delta, Max_speed)
		velocity.y = clamp((Jump_Velocity * (current_speed/pow(69, 1.0 / 3.0)))* sqrt(1),Speed,10)
		# Get the input direction and handle movement
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		is_slow_falling = true
		is_Spawning = false
	if direction:
		# Increase speed progressively
		current_speed = min(current_speed + Acceleration * delta, Max_speed)
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		# Decelerate when not moving
		current_speed = max(current_speed - Acceleration * delta, Speed)
		velocity.x = move_toward(velocity.x, 0, Speed)
		velocity.z = move_toward(velocity.z, 0, Speed)
	if Input.is_action_just_released("ui_cancel"):
		if is_mouse_showing != true:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			is_mouse_showing = true
			#print("Moussy Wakie")
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			is_mouse_showing = false
			#print("Mouse Zzz")
	if Input.is_action_just_pressed("Shooting"):
		shoot_paint = true
		emit_signal("shooting_signal",shoot_paint)
		#print("Pew!")
	if Input.is_action_just_released("Shooting"):
		if stain_notify == false:
			shoot_paint = false
			emit_signal("shooting_signal",shoot_paint)
	move_and_slide()
