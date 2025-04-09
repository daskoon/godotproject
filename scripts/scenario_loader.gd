extends Node

# Path to the scenarios JSON file
const SCENARIOS_PATH = "res://assets/scenarios.json"

# Dictionary to store loaded scenarios
var scenarios = {}

func _ready():
    # Load scenarios when the node is ready
    load_scenarios()

func load_scenarios():
    # Load scenarios from the JSON file
    scenarios = Scenario.load_scenarios_from_file(SCENARIOS_PATH)
    
    # If no scenarios were loaded, create a placeholder
    if scenarios.empty():
        print("Warning: No scenarios loaded from file. Using placeholder.")
        var placeholder = Scenario.new()
        placeholder.initialize_placeholder()
        scenarios["placeholder"] = placeholder

func get_random_scenario() -> Scenario:
    # Return a random scenario from the loaded scenarios
    if scenarios.empty():
        print("Error: No scenarios available.")
        var placeholder = Scenario.new()
        placeholder.initialize_placeholder()
        return placeholder
    
    var keys = scenarios.keys()
    var random_key = keys[randi() % keys.size()]
    return scenarios[random_key]

func get_scenario(key: String) -> Scenario:
    # Return a specific scenario by key
    if scenarios.has(key):
        return scenarios[key]
    
    print("Warning: Scenario '%s' not found. Using placeholder." % key)
    var placeholder = Scenario.new()
    placeholder.initialize_placeholder()
    return placeholder
