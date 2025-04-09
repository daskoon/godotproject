extends Control

func _ready():
    # Connect button signals
    $VBoxContainer/StartButton.connect("pressed", self, "_on_start_button_pressed")
    $VBoxContainer/QuitButton.connect("pressed", self, "_on_quit_button_pressed")

func _on_start_button_pressed():
    # Change to the main game scene
    get_tree().change_scene("res://scenes/MainGame.tscn")

func _on_quit_button_pressed():
    # Quit the game
    get_tree().quit()
