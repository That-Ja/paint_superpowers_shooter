class_name BurrowingComponent extends Node

@onready var material = %Smoll.material
@export var original_texture: Texture2D  # Reference to the original texture
var should_burw = Config.burrow_affect
var input = Input.is_action_pressed("Burrowing")
var input2 = Input.is_action_pressed("Jump")

func _physics_process(_delta):
	#if not is_multiplayer_authority():
		#return
	if should_burw and Input.is_action_pressed("Burrowing") and is_multiplayer_authority():
		set_alpha_scissor(material)
		print("I'm burrowing")
	elif not should_burw or Input.is_action_pressed("Jump"):
		reset_transparency(material)
func set_alpha_scissor(material_to_change):
	# Function to replace the texture with a transparent one
	material_to_change.transparency = material.TRANSPARENCY_ALPHA_SCISSOR
	print(str(material.transparency))
	#%BigHitbox.disabled = 1
func reset_transparency(material_to_change):
	print(str(material.transparency))
	material_to_change.transparency = 0
	%CharacterBody3D.position.y +10.0
	#%BigHitbox.disabled = 0
	if %CharacterBody3D.position.y < 10.0:
		%CharacterBody3D.position.y +10.0
