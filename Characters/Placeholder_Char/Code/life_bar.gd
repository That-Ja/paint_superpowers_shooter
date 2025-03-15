extends Node2D

var actual_hp := 14.3
var  max_hp := 23.6
var shield_hp := 23.3
var tick_counter = 0
const TICKS_INTERVAL = 62.5  # Execute the function every 5 ticks.

func _ready():
	
	if !is_multiplayer_authority():
		return
	if Config.player_name !="":
		$Name.text = Config.player_name
		return
	var male_random_names :Array = ['Patrick','Danny','Russel','Freddie','Clyde',
	'Wesley','Michael','Todd','Benjamin','Tom','Herbert','Bernand','Matthew','Vicent']
	var female_random_names :Array = ['Janice','Lola','Kelly','Ana Mary','Elisabeth',
	'Alice','Lillian','Karen','Mary','Bethany','Reggala','Eva','Dolores','Mariane',
	'Jacqueline','Cady','Christine','Rose','Error-404']
	var male_or_fem_nm = randi() % 2
	print('Choosen:'+str(male_or_fem_nm))
	var random_index_male = randi() % male_random_names.size()  # Get a random index for male names
	var random_index_female = randi() % female_random_names.size()  # Get a random index for male names
	if male_or_fem_nm == 0:
		$Name.text = male_random_names[random_index_male]
		#print("I'm "+$Name.text)
	if male_or_fem_nm == 1:
		$Name.text = female_random_names[random_index_female]
		#print("I'm "+$Name.text)
func _process(_delta):
	tick_counter += 1
	if tick_counter >= TICKS_INTERVAL:
		tick_counter = 0
		func_bar_update_prwty_pls()
		return
func func_bar_update_prwty_pls():
	actual_hp = Config.total_hp
	max_hp = Config.max_hp
	shield_hp = Config.shield_hp
	#print ("hp is"+ " " + str(actual_hp))
	$ShieldBar.value = shield_hp
	$ShieldBar.max_value = 50.0
	$Life_bar.value = actual_hp
	$Life_bar.max_value = max_hp
	$HpLabel.text = str(actual_hp) + '/' + str(max_hp)
	$ShieldLabel.text = str(shield_hp) + '/' + str(50.0)
	#$Name.text = 
