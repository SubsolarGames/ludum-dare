extends enemy_parent


enum STATES {
	none,
	move,
	handgun,
	slam,
	pitchfork
}

var bullet_scene: PackedScene = load("res://scenes/enemy_bullet.tscn")
var pitchfork: PackedScene = load("res://scenes/pitchfork.tscn")
var gun_scale: Vector2 = Vector2.ZERO
var state: STATES = STATES.none

func _ready() -> void:
	get_tree().create_timer(4.0).timeout.connect(func():
		choose_state()
	)


func _process(delta: float) -> void:
	Globals.satan_pos = position
	$Hand1.visible = false
	$Hand2.visible= false
	$gun.visible= false

	gun_scale = Vector2.ZERO
	if state == STATES.move:
		super._process(delta)
	if state == STATES.handgun:
		$gun.visible= true
		gun_scale = Vector2.ONE

		var save_rot = $gun.rotation
		$gun.look_at(Globals.player.position)
		var target_rot = $gun.rotation_degrees
		$gun.rotation = save_rot

		$gun.rotation_degrees = lerp($gun.rotation_degrees, target_rot, 1-(0.5**(8 * delta)))
		if $firerate.time_left == 0.0:
			$gun/Circle.visible = true
			get_tree().create_timer(0.05).timeout.connect(func():
				$gun/Circle.visible = false)

			$firerate.start()

			$gun/anim.play("shoot")

			var inst: Node2D = bullet_scene.instantiate()
			inst.position = $gun/Circle.global_position
			inst.damage = 1
			inst.rotation = $gun.rotation
			inst.velocity = Vector2(100, 0).rotated($gun.rotation)
			get_parent().add_child(inst)

		
	if state == STATES.slam:
		$Hand1.visible = true
		$Hand2.visible= true

		if $slamrate.time_left == 0.0:
			$slam.p()
			$slamrate.start()

			$attack_anim.play("slam")
			Globals.screenshake(4, 0.3)

			for i in range(20):
				var angle = deg_to_rad(i * (360.0/20.0))
				var inst: Node2D = bullet_scene.instantiate()
				inst.position = global_position
				inst.damage = 1
				inst.rotation = angle
				inst.velocity = Vector2(50, 0).rotated(angle)
				get_parent().add_child(inst)
		

	$gun.scale = lerp($gun.scale, gun_scale, 1-(0.5**(10 * delta)))
	

func choose_state() -> void:
	state = [STATES.move, STATES.handgun, STATES.slam, STATES.pitchfork].pick_random()
	if state == STATES.move:
		get_tree().create_timer(randf_range(2, 4)).timeout.connect(func():
			choose_state())
	if state == STATES.handgun:
		get_tree().create_timer(randf_range(4, 5)).timeout.connect(func():
			choose_state())
	if state == STATES.slam:
		get_tree().create_timer(randf_range(2, 3)).timeout.connect(func():
			choose_state())
	if state == STATES.pitchfork:
		get_tree().create_timer(1).timeout.connect(func():
			choose_state())

		var inst: CharacterBody2D = pitchfork.instantiate()
		inst.position = position
		get_parent().add_child(inst)

		

func other_stuff() -> void:
	Globals.slowdown(0.05, 1)
	Globals.game_won.emit()
