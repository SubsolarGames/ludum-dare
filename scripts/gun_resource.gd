extends Resource
class_name Gun

@export var frame: int = 1
@export var bullets: int = 1
@export var bullet_spread: float = 0.0
@export var bullet_speed: float = 200.0
@export var fire_rate: float = 0.15
@export var innac: float = 5.0
@export var bullet_scene: PackedScene
@export var bullet_damage: float = 1
@export var weight: float = 50.0

func _init(nframe: int, nbullets: int, nbulllet_spread: float, nbullet_speed: float, nfire_rate: float, ninnac: float, nbullet_scene: PackedScene, nbullet_damage: float, nweight: float) -> void:
    frame = nframe
    bullets = nbullets
    bullet_spread = nbulllet_spread
    bullet_speed = nbullet_speed
    fire_rate = nfire_rate
    innac = ninnac
    bullet_scene = nbullet_scene
    bullet_damage = nbullet_damage
    weight = nweight