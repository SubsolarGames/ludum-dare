extends Label


func _process(_delta: float) -> void:
    var display: String = str(snapped(Globals.timer, 0.01))
    print(display.length())
    if display.length() == 2 + str(int(Globals.timer)).length():
        display += "0"


    text = str(display)+" sec"