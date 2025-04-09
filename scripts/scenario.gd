extends Node
class_name Scenario

# Scenario properties
var title: String
var description: String
var customer_types: Array = []
var initial_dialogue: String
var choices: Dictionary = {}

# Choice structure
class Choice:
    var text: String
    var response: String
    var effects: Dictionary
    var leads_to: String
    
    func _init(t: String, r: String, e: Dictionary, l: String):
        text = t
        response = r
        effects = e
        leads_to = l

func _init():
    pass

func initialize_from_dict(data: Dictionary):
    title = data.get("title", "")
    description = data.get("description", "")
    
    # Parse customer types
    if data.has("customer_type") and data["customer_type"] is Array:
        customer_types = data["customer_type"]
    
    initial_dialogue = data.get("initial_dialogue", "")
    
    # Parse choices
    if data.has("choices") and data["choices"] is Dictionary:
        for key in data["choices"]:
            var choice_data = data["choices"][key]
            choices[key] = Choice.new(
                choice_data.get("text", ""),
                choice_data.get("response", ""),
                choice_data.get("effects", {}),
                choice_data.get("leads_to", "")
            )

func initialize_placeholder():
    # Create a placeholder scenario for testing
    title = "Price Match Request"
    description = "Customer shows you a competitor's advertisement with a lower price"
    customer_types = ["regular", "karen"]
    initial_dialogue = "I found this same item cheaper at CompetitorMart. Can you match their price?"
    
    # Add choices
    choices["check_policy"] = Choice.new(
        "Let me check our price match policy",
        "Our policy states we can match verified competitor prices. Let me verify this for you.",
        {"customer_patience": 10, "manager_annoyance": -5, "self_boredom": 5},
        "verify_advertisement"
    )
    
    choices["immediate_deny"] = Choice.new(
        "Sorry, we don't price match",
        "I apologize, but we don't offer price matching.",
        {"customer_patience": -20, "manager_annoyance": 10, "self_boredom": -5},
        "customer_escalation"
    )
    
    choices["call_manager"] = Choice.new(
        "Let me get a manager for you",
        "I'll call a manager to assist you with this request.",
        {"customer_patience": 5, "manager_annoyance": 15, "self_boredom": 0},
        "manager_handling"
    )

# Load scenarios from a JSON file
static func load_scenarios_from_file(file_path: String) -> Dictionary:
    var file = File.new()
    if file.file_exists(file_path):
        file.open(file_path, File.READ)
        var json_text = file.get_as_text()
        file.close()
        
        var json_result = JSON.parse(json_text)
        if json_result.error == OK:
            var scenarios = {}
            var data = json_result.result
            
            for key in data:
                var scenario = Scenario.new()
                scenario.initialize_from_dict(data[key])
                scenarios[key] = scenario
            
            return scenarios
    
    # Return empty dictionary if file doesn't exist or has errors
    return {}
