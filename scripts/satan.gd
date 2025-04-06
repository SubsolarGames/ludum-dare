extends enemy_parent


enum STATES {
    none,
    move,
    handgun,
    slam,
    pitchfork
}

var state: STATES = STATES.none


func _ready() -> void:
    get_tree().create_timer(4.0).timeout.connect(func():
        choose_state()
    )


func _process(delta: float) -> void:
    if state == STATES.move:
        super._process(delta)
        
    

func choose_state() -> void:
    state = [STATES.move].pick_random()
