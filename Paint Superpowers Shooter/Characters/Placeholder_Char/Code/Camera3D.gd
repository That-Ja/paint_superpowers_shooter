extends Camera3D

var on_touching_walls:bool = false
var myself_positionX_save:float = 0.0
var myself_positionY_save:float = 0.0
var myself_positionZ_save:float = 0.0
var aim_stop:bool = true
var Mouse_Sensitivity:float = Config.Mouse_Sens
var vertical_motion
var Hold_Ver_Mot = 0
signal extra_box_pos()
var extra_box_y:float = 0
var extra_box_x:float = 0
var extra_box_z:float = 0
func _ready():
	# Save the initial position of the camera
	myself_positionX_save = self.position.x
	myself_positionY_save = self.position.y
	myself_positionZ_save = self.position.z
	# Connect the signal for when a body enters or exits
	$"../..".connect("body_entered", Callable(self, "_on_body_entered"))
	$"../..".connect("body_exited", Callable(self, "_on_body_exited"))

# This function is called when another body enters the area
func _on_body_entered(_body):
	on_touching_walls = true
	#print("behind a wall owo!")
	touching_something()

# This function is called when another body exits the area
func _on_body_exited(_body):
	on_touching_walls = false
	# Move the camera when it exits the area
	if not on_touching_walls:
		self.position = Vector3(myself_positionX_save, myself_positionY_save, myself_positionZ_save)
		#print("not wall touching :(")

# Called every frame
func _process(_delta):
	
	# Update the camera's rotation to match the parent's rotation
	rotation = get_parent().rotation
	if Input.is_action_pressed("Aim"):
		if aim_stop == false:
			aiming_zoom()
			#print("aiming")
	if Input.is_action_just_released("Aim"):
		self.position = Vector3(myself_positionX_save, myself_positionY_save, myself_positionZ_save)
		aim_stop = false

func _input(event):
	if event is InputEventMouseMotion:
		vertical_motion = event.relative.y
		clamp(vertical_motion,-10,5)
		if vertical_motion <= 0 and Hold_Ver_Mot <=12:
			extra_box_x = 0
			extra_box_y = 0.06
			extra_box_z = 0.002
			emit_signal("extra_box_pos",extra_box_x,extra_box_y,extra_box_z)
			self.position = Vector3(self.position.x,self.position.y+((0.05+Mouse_Sensitivity)/sqrt(2)), self.position.z)
			Hold_Ver_Mot += 1
			#print("Up "+str(Hold_Ver_Mot))
		if vertical_motion >= 0 and Hold_Ver_Mot >=-4:
			extra_box_x = 0
			extra_box_y = -0.06
			extra_box_z = -0.002
			emit_signal("extra_box_pos",extra_box_x,extra_box_y,extra_box_z)
			self.position = Vector3(self.position.x, self.position.y-((0.05+Mouse_Sensitivity)/sqrt(2)), self.position.z)
			Hold_Ver_Mot -= 1
			clamp(0,-10,10)
			#print("Down "+str(Hold_Ver_Mot))
		if Hold_Ver_Mot > 21 or Hold_Ver_Mot < -10:
			self.position = Vector3(myself_positionX_save, myself_positionY_save, myself_positionZ_save)
			Hold_Ver_Mot = 0
			clamp(0,-10,10)
func touching_something():
	if on_touching_walls:
		await get_tree().create_timer(0.25).timeout
		# Slightly move the camera downward (or modify as needed)
		self.position = Vector3(self.position.x, self.position.y, self.position.z - 1.0)

func aiming_zoom():
	# Slightly move the camera downward (or modify as needed)
	self.position = Vector3(self.position.x+0.5, self.position.y, self.position.z - 1.5)
	aim_stop = true
