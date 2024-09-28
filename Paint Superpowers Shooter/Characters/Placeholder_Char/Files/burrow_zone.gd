extends Area3D
var burrow_x = Config.burrow_x
var burrow_y = Config.burrow_y
var burrow_z =  Config.burrow_z
var total_burrow= (burrow_x+burrow_y+burrow_z)
var cloning:bool = false
func _ready():
	$Burrow_Box_app.start()

func burrow_recharge():
	await get_tree().create_timer(0.5).timeout
	total_burrow = Vector3(burrow_x,burrow_y,burrow_z)
	if total_burrow >= Vector3(0, 0, 0):
		cloning = true
		print("Please work")
func _on_burrow_box_app_timeout():
	burrow_x = Config.burrow_x
	burrow_y = Config.burrow_y
	burrow_z =  Config.burrow_z
	burrow_recharge()
	$Burrow_Box_app.start()

func _on_body_entered(body):
	print("im connecting")
