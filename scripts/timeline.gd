extends TextureProgressBar

@export var marker: PackedScene
var insts: Array[Sprite2D]
var counter: int = 0
var fin: bool =false

func _ready() -> void:
	Globals.shooter_start.connect(place_markers)

func _process(_delta: float) -> void:
	visible = not Globals.platformer
	value = Globals.timer * (100.0/Globals.end_time)

	if len(Globals.powerups) > 0 and not Globals.platformer:
		if Globals.timer > Globals.powerups[0]:

			get_parent().get_node("sound").p()
			insts[counter].use()
			counter += 1

			Globals.last_checkpoint = Globals.timer
			print(Globals.last_checkpoint)
			Globals.powerups.pop_front()
			Globals.blue_flash = 0.5
			get_tree().create_timer(0.15).timeout.connect(func():
				Globals.blue_flash = false)

			var guns = [Globals.player.shotgun, Globals.player.minigun,Globals.player.sniper,Globals.player.wand,Globals.player.clawgun]
			if Globals.player.gun in guns:
				guns.erase(Globals.player.gun)

			Globals.player.gun = guns.pick_random()
			get_tree().create_timer(5).timeout.connect(func():
				if Globals.player != null:
					Globals.player.gun = Globals.player.pistol)

	if not Globals.platformer:
		if Globals.timer > Globals.end_time and not fin:
			fin =true
			Globals.finished.emit()

func place_markers() -> void:
	var inst: Sprite2D
	for i in Globals.powerups:
		inst = marker.instantiate()
		inst.prog = i/Globals.end_time
		get_parent().add_child(inst)
		insts.append(inst)
