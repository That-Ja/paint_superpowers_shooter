extends Label

var blue_percent_int : int
var blue_percent_Str : String 
var red_percent_int : int
var red_percent_Str : String 
var green_percent_int : int
var green_percent_Str : String 

func _process(_delta):
	blue_percent_int = Config.trans_blue
	blue_percent_Str = str(blue_percent_int)
	red_percent_int= Config.trans_red
	red_percent_Str = str(red_percent_int)
	green_percent_int= Config.trans_green
	green_percent_Str = str(green_percent_int)
	self.text = ( 'Blue percentage: ' + blue_percent_Str 
	+ ', Red percentage: ' + red_percent_Str
	+ ', Green percentage: ' + green_percent_Str)
