extends CharacterBody2D


@export var particles: PackedScene
@export var health: float = 10.0
@export var innac: float = 0.0
@export var speed_min: float = 50
@export var speed_max: float = 50
@export var accel: float = 5
@export var friction: float = 8
@export var screenshake_hit: int = 1
@export var screenshake_die: int = 3

@onready var speed: float = randf_range(speed_min, speed_max)
@onready var innac_vector: Vector2 = Vector2(randf_range(-innac, innac), randf_range(-innac, innac))

var dead: bool = false


func _process(delta: float) -> void:
    $anim.play("walk")
    var offset: Vector2 = ((Globals.player.position-position)/100.0) * innac_vector
    velocity = lerp(velocity, ((Globals.player.position+offset)-position).normalized() * speed, 1-(0.5**(accel * delta)))

    move_and_slide()


func damage(amount: int):
    if not dead:
        health -= amount

        if health > 0:
            Globals.screenshake(screenshake_hit, 0.2)

            $sprite.material.set_shader_parameter("active", true)
            get_tree().create_timer(0.15).timeout.connect(func():
                $sprite.material.set_shader_parameter("active", false)
            )
        else:
            dead = true

            Globals.screenshake(screenshake_die, 0.3)

            var inst: CPUParticles2D = particles.instantiate()
            inst.position = position
            inst.rotation = rotation
            get_parent().add_child(inst)

            queue_free()
