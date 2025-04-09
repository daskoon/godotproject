extends Node2D

# UI References
onready var dialogue_box = $UI/DialogueBox
onready var character_portrait = $UI/CharacterPortrait
onready var choices_container = $UI/ChoicesContainer
onready var metrics_display = $UI/MetricsDisplay
onready var time_display = $UI/TimeDisplay
onready var background = $Background

# Current scene state
var current_background: String = "desk"
var is_waiting_for_choice: bool = false

func _ready():
    # Connect to GameManager signals
    GameManager.connect("time_updated", self, "_on_time_updated")
    GameManager.connect("state_changed", self, "_on_state_changed")
    GameManager.connect("metrics_updated", self, "_on_metrics_updated")
    
    # Connect to DialogueManager signals
    GameManager.dialogue_manager.connect("dialogue_started", self, "_on_dialogue_started")
    GameManager.dialogue_manager.connect("dialogue_ended", self, "_on_dialogue_ended")
    GameManager.dialogue_manager.connect("choices_presented", self, "_on_choices_presented")
    
    # Initialize UI
    update_metrics_display()
    update_time_display(GameManager.current_time)
    
    # Start the game if not already started
    if GameManager.current_state != GameManager.GameState.PLAYING:
        GameManager.start_new_game()
        
    # Start first scenario
    _start_next_scenario()

func _start_next_scenario():
    # Get a random scenario
    var scenario = GameManager.select_random_scenario()
    GameManager.current_scenario = scenario
    
    # Create a customer based on scenario
    var customer_type_str = scenario.customer_types[randi() % scenario.customer_types.size()]
    var customer_type = _get_customer_type_from_string(customer_type_str)
    var customer = Character.create_customer(customer_type)
    GameManager.current_customer = customer
    
    # Play door chime sound
    # $AudioPlayers/DoorChime.play()
    
    # Show customer and start dialogue
    _show_character(customer)
    GameManager.dialogue_manager.start_dialogue(customer, scenario.initial_dialogue)

func _on_dialogue_started(character, text):
    # Update dialogue box with character's text
    dialogue_box.text = text
    dialogue_box.visible = true
    
    # If this is the customer's initial dialogue, present choices
    if character == GameManager.current_customer:
        GameManager.dialogue_manager.present_choices(GameManager.current_scenario.choices)

func _on_dialogue_ended():
    dialogue_box.visible = false
    
    # If not waiting for a choice, advance time and go to next scenario
    if not is_waiting_for_choice:
        GameManager.advance_time(5)  # Advance time by 5 minutes
        _start_next_scenario()

func _on_choices_presented(choices):
    is_waiting_for_choice = true
    
    # Clear previous choices
    for child in choices_container.get_children():
        child.queue_free()
    
    # Create buttons for each choice
    for key in choices:
        var choice = choices[key]
        var button = Button.new()
        button.text = choice.text
        button.connect("pressed", self, "_on_choice_button_pressed", [key])
        choices_container.add_child(button)
    
    choices_container.visible = true

func _on_choice_button_pressed(choice_key):
    is_waiting_for_choice = false
    choices_container.visible = false
    
    # Get the choice data
    var choice = GameManager.current_scenario.choices[choice_key]
    
    # Process effects
    GameManager.process_choice_effects(choice.effects)
    
    # Show player response
    _show_character(GameManager.player_character)
    GameManager.dialogue_manager.start_dialogue(GameManager.player_character, choice.response)
    
    # End dialogue after a short delay
    yield(get_tree().create_timer(2.0), "timeout")
    GameManager.dialogue_manager.end_dialogue()
    
    # Handle next scene based on leads_to
    # This would normally jump to a new scene or scenario
    # For now, we'll just advance time and go to next scenario
    GameManager.advance_time(5)
    _start_next_scenario()

func _show_character(character):
    # Update character portrait
    if character and character.get_current_texture():
        character_portrait.texture = character.get_current_texture()
        character_portrait.visible = true
    else:
        character_portrait.visible = false

func _on_time_updated(new_time):
    update_time_display(new_time)

func _on_state_changed(new_state):
    match new_state:
        GameManager.GameState.GAME_OVER:
            # Show game over screen
            print("Game Over!")
            # get_tree().change_scene("res://scenes/GameOver.tscn")

func _on_metrics_updated():
    update_metrics_display()

func update_metrics_display():
    # Update UI with current metrics
    var metrics = GameManager.metrics.get_metrics_data()
    metrics_display.text = "Customer Patience: %d%%\nBoredom: %d%%\nManager Annoyance: %d%%\nTheft Loss: %d%%" % [
        metrics.customer_patience,
        metrics.self_boredom,
        metrics.manager_annoyance,
        metrics.theft_loss
    ]

func update_time_display(time_minutes):
    # Convert minutes to hours and minutes
    var hours = time_minutes / 60
    var minutes = time_minutes % 60
    
    # Format time string
    time_display.text = "%d:%02d" % [hours, minutes]

func _get_customer_type_from_string(type_str: String) -> int:
    match type_str:
        "regular":
            return Character.CharacterType.CUSTOMER_REGULAR
        "karen":
            return Character.CharacterType.CUSTOMER_KAREN
        "elderly":
            return Character.CharacterType.CUSTOMER_ELDERLY
        "rushed":
            return Character.CharacterType.CUSTOMER_RUSHED
        "suspicious":
            return Character.CharacterType.CUSTOMER_SUSPICIOUS
        _:
            return Character.CharacterType.CUSTOMER_REGULAR
