extends Node

var total_hp = 100
var max_hp = 100
var shield_hp = 50
var Mouse_Sens = 0.01
var burrow_affect = true
@export var pink_col: Color = Color(0.78,0.008,0.329,1)
@export var light_blue_col: Color = Color(0.169,0.718,0.82,1)
@export var dark_blue_col:Color = Color(0.129,0.192,0.638,1)
@export var yell_col:Color = Color(1,0.863,0.118,1)
#@export var walter:Color = Color(0.988,0.961,0.965,1)
@export var scheele_green:Color = Color(0.216,0.773,0.337,1)
@export var orange_col:Color = Color(1,0.383,0,1)
@export var red_col:Color = Color(1,0.047,0.145,1)
var selected_color = pink_col
var burrow_x = -999.0
var burrow_y = -999.0
var burrow_z = -9999.0
