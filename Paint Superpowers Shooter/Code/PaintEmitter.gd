extends Node3D
 
@export var paint_scene: PackedScene
@export var speed_variance: float = 1.0
@export var rotation_variance: float = 5.0
@export var pink_col: Color = Color(0.78,0.008,0.329,1)
@export var light_blue_col: Color = Color(0.453,0.718,0.791,0.5)
@export var dark_blue_col:Color = Color(0.192,0.281,0.83,1)
@export var emit := true
 
var rng = RandomNumberGenerator.new()
func _ready():
	Console.add_command("change_ink", calculus_comm,["uoi"],1, "This is a command what did you expect")
func calculus_comm(param:String):
	var material = $View.get_active_material(0)
	if param == "pink_col":
		$View.color = pink_col
		material.albedo_color = $View.color
		Console.print_line(str(param))
func _on_timer_timeout():
	if emit:
		var p = paint_scene.instantiate() as CharacterBody3D
		add_child(p)
		p.speed += rng.randf_range(0.0, speed_variance)
		p.global_position = global_position
		p.global_rotation = global_rotation
		p.rotate_x(deg_to_rad(rng.randf_range(-rotation_variance, rotation_variance)))
		p.rotate_y(deg_to_rad(rng.randf_range(-rotation_variance, rotation_variance)))
		p.set_start_velocity()
