extends TextureProgressBar


var ticker: float = 5

func _process(delta: float) -> void:
	visible = Globals.player.gun != Globals.player.pistol

	if Globals.player.gun != Globals.player.pistol:
		ticker -= delta

		value = (ticker/5) * 100
	else:
		ticker = 5
