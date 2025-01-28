extends Node
func _ready():
	Console.add_command("reset_pos", reset_position,["uoi"],1, "This is a command what did you expect")
func reset_position(param:String):
	%CharacterBody3D.position.x = 0.0
	%CharacterBody3D.position.y = 10.0
	%CharacterBody3D.position.z = 0.0
	Console.print_line(str(param))

	
