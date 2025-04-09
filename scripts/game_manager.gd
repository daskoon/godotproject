extends Node

# Autoloaded singleton that manages the game state

# Game state constants
enum GameState {
    MAIN_MENU,
    PLAYING,
    PAUSED,
    GAME_OVER
}

# Current game state
var current_state = GameState.MAIN_MENU

# References to important nodes
var metrics: GameMetrics
var dialogue_manager: DialogueManager
var scenario_loader: Node
var current_scenario: Scenario
var current_customer: Character
var player_character: Character

# Time variables
var current_time: int = 0  # in minutes
var shift_duration: int = 240  # 4-hour shift (240 minutes)

# Signal for time updates
signal time_updated(new_time)
signal state_changed(new_state)
signal metrics_updated

func _ready():
    # Initialize game components
    metrics = GameMetrics.new()
    dialogue_manager = DialogueManager.new()
    scenario_loader = Node.new()
    scenario_loader.set_script(load("res://scripts/scenario_loader.gd"))

    add_child(metrics)
    add_child(dialogue_manager)
    add_child(scenario_loader)

    # Initialize player character
    player_character = Character.new("You", Character.CharacterType.PLAYER)

    # Connect signals
    metrics.connect("metrics_changed", self, "_on_metrics_changed")

func start_new_game():
    # Reset game state
    current_time = 0
    metrics.reset_metrics()

    # Change state to playing
    change_state(GameState.PLAYING)

    # Emit signals
    emit_signal("time_updated", current_time)

func change_state(new_state):
    current_state = new_state
    emit_signal("state_changed", new_state)

func advance_time(minutes: int):
    current_time += minutes
    emit_signal("time_updated", current_time)

    # Check if shift is over
    if current_time >= shift_duration:
        end_shift()

func end_shift():
    # Evaluate performance and show results
    change_state(GameState.GAME_OVER)

func select_random_scenario() -> Scenario:
    # Use the scenario loader to get a random scenario
    return scenario_loader.get_random_scenario()

func _on_metrics_changed():
    # Check if any metrics have reached critical levels
    if metrics.check_critical_levels():
        end_shift()

    emit_signal("metrics_updated")

func process_choice_effects(effects: Dictionary):
    metrics.apply_effects(effects)
