extends TextureProgressBar

@export var marker: PackedScene


func _ready() -> void:
	Globals.shooter_start.connect(place_markers)

func _process(_delta: float) -> void:
	visible = not Globals.platformer
	value = Globals.timer * (100.0/Globals.end_time)

	if len(Globals.powerups) > 0 and not Globals.platformer:
		if Globals.timer > Globals.powerups[0]:
			Globals.powerups.pop_front()
			Globals.blue_flash = 0.5
			get_tree().create_timer(0.15).timeout.connect(func():
				Globals.blue_flash = false)

			Globals.player.gun = [Globals.player.shotgun, Globals.player.minigun,Globals.player.sniper,Globals.player.wand,Globals.player.clawgun].pick_random()


func place_markers() -> void:
	var inst: Sprite2D
	for i in Globals.powerups:
		inst = marker.instantiate()
		inst.prog = i/Globals.end_time
		get_parent().add_child(inst)
