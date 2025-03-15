class_name ScoreCalcComponent extends Node
@export var blue_score :=0
@export var red_score :=0
@export var green_score :=0
var thread: Thread
var semaphore: Semaphore
var mutex: Mutex
var exit := false
var paint_texture: ViewportTexture

#signal transf_blue_percent (blue_score)
var plane

#Calculating which colors has the pixel, then give it an score
func _ready():
	paint_texture = $"../../DrawViewport".get_texture()
	
	mutex = Mutex.new()
	semaphore = Semaphore.new()
	thread = Thread.new()
	thread.start(_thread_calculate_score)
	
func recalculate_score():
	await RenderingServer.frame_post_draw
	semaphore.post()
	
func _thread_calculate_score():
	while true:
		semaphore.wait()
		
		mutex.lock()
		var should_exit := exit
		mutex.unlock()
		
		if should_exit:
			break
		
		mutex.lock()
		var image := paint_texture.get_image()
		mutex.unlock()
		
		var size = image.get_size()
		var blue_pixels := 0
		var red_pixels := 0
		var green_pixels := 0
		for y in range(0, size.y):
			for x in range(0, size.x):
				var pixel = image.get_pixel(x, y)
				if pixel.r >= 0.5:
					red_pixels += 1
				if pixel.b >= 0.5:
					blue_pixels += 1
				if pixel.g >= 0.5:
					green_pixels += 1
		mutex.lock()
		blue_score = floor(float(blue_pixels)/1000)
		red_score = floor(float(red_pixels)/1000)
		print ('red: ' + str(red_pixels)+ ', blue: ' + str(blue_pixels)+', green: ' + str(green_pixels))
		Config.trans_blue = blue_score
		Config.trans_red = red_score
		Config.trans_green = green_score
		mutex.unlock()
 
func _exit_tree():
	mutex.lock()
	exit = true
	mutex.unlock()
	
	semaphore.post()
	thread.wait_to_finish()
