extends CharacterBody3D
 

var color = Config.selected_color
@export var speed = 5.0
@onready var draw_viewport: Viewport = $"/root/Main/DrawViewport"
 
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	var material = $View.get_active_material(0)
	material.albedo_color = color
func set_start_velocity():
	velocity = (global_transform.basis * Vector3.FORWARD).normalized() * speed
 
func _physics_process(delta):
	velocity.y -= gravity * delta
	look_at(position + velocity)
 
	move_and_slide()
	
	if get_slide_collision_count() > 0:
		for i in range(0, get_slide_collision_count()):
			var col = get_slide_collision(i)
			Config.burrow_x = col.get_position().x
			Config.burrow_y = col.get_position().y
			Config.burrow_z = col.get_position().z
			var uv = LevelUvPosition.get_uv_coords(col.get_position(), col.get_normal(), true)
			if uv:
				draw_viewport.paint(uv, color)
		queue_free()
 
