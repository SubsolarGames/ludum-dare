extends Sprite2D



var prog: float = 0.0

func _ready() -> void:
    $Sprite2D.visible = false
    position = Vector2((242 * prog) + 7, 20)
   

func use() -> void:
    $Sprite2D.visible = true