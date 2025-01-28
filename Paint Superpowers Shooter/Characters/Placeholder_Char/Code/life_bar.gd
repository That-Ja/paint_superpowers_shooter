extends Node2D

var actual_hp := 14.3
var  max_hp := 23.6
var shield_hp := 23.3
var tick_counter = 0
const TICKS_INTERVAL = 62.5  # Execute the function every 5 ticks.
func _process(delta):
	tick_counter += 1
	if tick_counter >= TICKS_INTERVAL:
		tick_counter = 0
		func_bar_update_prwty_pls()
		return
func func_bar_update_prwty_pls():
	actual_hp = Config.total_hp
	max_hp = Config.max_hp
	shield_hp = Config.shield_hp
	await get_tree().create_timer(3.3).timeout
	#print ("hp is"+ " " + str(actual_hp))
	$ShieldBar.value = shield_hp
	$ShieldBar.max_value = 50.0
	$Life_bar.value = actual_hp
	$Life_bar.max_value = max_hp
	$HpLabel.text = str(actual_hp) + '/' + str(max_hp)
	$ShieldLabel.text = str(shield_hp) + '/' + str(50.0)
	#$Name.text = 
