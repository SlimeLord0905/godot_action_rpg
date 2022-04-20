extends Node2D


var noise
var map_size = Vector2(100, 80)
var grass_cap = 0.5
var road_caps = Vector2(0.3,0.05)
var enviroment_caps = Vector3(0.4, 0.3, 0.04)
var ytree
var ybush

export (PackedScene) var grasses: PackedScene= preload("res://World/grass.tscn")
export (PackedScene) var trees: PackedScene= preload("res://World/Tree.tscn")
export (PackedScene) var bushs: PackedScene= preload("res://World/bush.tscn")
export (PackedScene) var bats: PackedScene= preload("res://Enemies/bat.tscn")
export (PackedScene) var slimes: PackedScene= preload("res://Enemies/slime.tscn")
export (PackedScene) var squeleton_mage: PackedScene= preload("res://Enemies/Squeletton_mage/Squeleton_mage.tscn")
export (PackedScene) var background: PackedScene= preload("res://World/nouvelle_map_32x32.tscn")

func _ready():
	$idlemusic.play()
	randomize()
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.octaves = 1.5
	noise.period = 12
	ytree = get_node("YSort/tree")
	ybush = get_node("YSort/bush")
#	noise.persistence = 0.7
	make_road_map()
	make_grass_map()
	make_spawn()
	make_enviroment_map()
	make_enemie()
		
func make_grass_map():
	for x in map_size.x:
		for y in map_size.y:
			var a = noise.get_noise_2d(x,y)
			if a > grass_cap:
				$dirtwall.set_cell(x,y,0)
				$nouvelle_map_32x33.set_cell(x,y,4)
			else:
				a = noise.get_noise_2d(x,y)
				if a < road_caps.x and a > road_caps.y and x != 0 and y != 0 and x != map_size.x and y != map_size.y:
					pass
				else:
					$nouvelle_map_32x33.set_cell(x,y,4)
	for x in map_size.x:
		if x > 5:
			$dirtwall.set_cell(x,0,0)
			$nouvelle_map_32x33.set_cell(x,0,-1)
	for y in map_size.y:
		$dirtwall.set_cell(0,y,0)
		$nouvelle_map_32x33.set_cell(0,y,-1)
	for y in map_size.y:
		for x in map_size.x:
			$dirtwall.set_cell(x,map_size.y,0)
			$nouvelle_map_32x33.set_cell(x,map_size.y,-1)
			$dirtwall.set_cell(map_size.x,y+1,0)
			$nouvelle_map_32x33.set_cell(map_size.x,y+1,-1)
	
	$dirtwall.set_cell(map_size.x,map_size.y - 4,-1);		
	$dirtwall.set_cell(map_size.x,map_size.y - 3,-1);
	$dirtwall.set_cell(map_size.x,map_size.y - 2,-1);
	$dirtwall.update_bitmask_region(Vector2(0.0, 0.0), Vector2(map_size.x, map_size.y))
	$nouvelle_map_32x33.update_bitmask_region(Vector2(0.0, 0.0), Vector2(map_size.x, map_size.y))
	
func make_road_map():
	for x in map_size.x:
		for y in map_size.y:
			var a = noise.get_noise_2d(x,y)
			if a < road_caps.x and a > road_caps.y and x != 0 and y != 0 and x != map_size.x and y != map_size.y:
				$nouvelle_map_32x33.set_cell(x,y,3)
	$nouvelle_map_32x33.update_bitmask_region(Vector2(0.0, 0.0), Vector2(map_size.x, map_size.y))
	
func make_enviroment_map():
	var rng = RandomNumberGenerator.new()
	for z in range(4):
		for x in map_size.x:
			for y in map_size.y:
				var a = noise.get_noise_2d(x,y)
				if a < enviroment_caps.x and a > enviroment_caps.y or a < enviroment_caps.z:
					var chance = randi() % 100
					if chance < 2:
					
						var num = rng.randi_range(0,3)
						if num == 0:
							var tree = trees.instance()
							get_tree().current_scene.add_child(tree)
							tree.global_position = Vector2(x*32,y*32)
						if num == 1:
							var bush = bushs.instance()
							get_tree().current_scene.add_child(bush)
							bush.global_position = Vector2(x*32,y*32)
						if num == 2:
							var grass = grasses.instance()
							get_tree().current_scene.add_child(grass)
							grass.global_position = Vector2(x*32,y*32)
				
				

func make_enemie():
	var rng = RandomNumberGenerator.new()
	for z in range(2):
		for x in map_size.x:
			for y in map_size.y:
				var a = noise.get_noise_2d(x,y)
				if a < enviroment_caps.x and a > enviroment_caps.y or a < enviroment_caps.z:
					var chance = randi() % 100
					if chance < 2:
					
						var num = rng.randi_range(0,2)
						if num == 0:
							var slime = slimes.instance()
							get_tree().current_scene.add_child(slime)
							slime.global_position = Vector2(x*32,y*32)
						if num == 1:
							var bat = bats.instance()
							get_tree().current_scene.add_child(bat)
							bat.global_position = Vector2(x*32,y*32)

func make_spawn():
	for x in range(5):
			for y in range(5):
				$dirtwall.set_cell(x+1,y+1,-1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
