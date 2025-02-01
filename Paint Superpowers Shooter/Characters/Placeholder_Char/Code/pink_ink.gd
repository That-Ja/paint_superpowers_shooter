extends Node3D

@export var paint_scene: PackedScene
@export var speed_variance: float = 1.0
@export var rotation_variance: float = 5.0
@export var emit := false
var rng = RandomNumberGenerator.new()
#signal paint_stain_notifier(stain_notification)
var stain_notification:bool = false
func _ready():
	Console.add_command("change_ink", calculus_comm,["uoi"],1, "This is a command what did you expect")
func calculus_comm(param:String):
	if param == "pink_col":
		Config.selected_color = Config.pink_col
		Console.print_line(str(param))
	if param =="light_blue_col":
		Config.selected_color = Config.light_blue_col
		Console.print_line(str(param))
func _on_character_body_3d_shooting_signal(shooting_paint):
	emit = shooting_paint
func _on_timer_timeout():
	if emit:
		var p = paint_scene.instantiate() as CharacterBody3D
		add_child(p)
		p.global_position = $"..".global_position
		p.speed += rng.randf_range(0.0, speed_variance)
		p.global_position = get_parent().global_position
		# Apply random rotation to the projectile
		var random_x_rotation = rng.randf_range(-rotation_variance, rotation_variance)
		var random_y_rotation = rng.randf_range(-rotation_variance, rotation_variance)
		p.rotate_x(deg_to_rad(random_x_rotation))
		p.rotate_y(deg_to_rad(random_y_rotation))
		# Set initial velocity with a downward component
		var forward_vector = -p.global_transform.basis.z  # Forward direction of the projectile
		forward_vector.y = 0  # Ignore the y component for the forward direction
		forward_vector = forward_vector.normalized()  # Normalize the vector
		# Set the downward velocity component
		var downward_velocity = -rng.randf_range(1.0, 3.0)
		# Combine forward movement and downward fall
		var initial_velocity = forward_vector * p.speed + Vector3(0, downward_velocity, 0)
		# Assuming your CharacterBody3D has a velocity property
		p.velocity = initial_velocity  # Set the velocity property
		#await get_tree().create_timer(1).timeout
		#emit_signal("paint_stain_notifier",stain_notification)
