extends Node2D
 
@export var texture: Texture2D
@export var brush_size: int = 75
 
@onready var calc = $"../../Global_Config/ScoreCalculator"
 
var brush_queue = []
 
func queue_brush(brush_position: Vector2, colour: Color):
	brush_queue.push_back([brush_position, colour])
	queue_redraw()
 
func _draw():
	for b in brush_queue:
		draw_texture_rect(texture, Rect2(b[0].x - float(brush_size) / 2, b[0].y - float(brush_size) / 2, brush_size, brush_size), false, b[1])
		brush_queue = []
	
	calc.recalculate_score()
 
