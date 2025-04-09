extends Node
class_name DialogueManager

# Signals
signal dialogue_started(character, text)
signal dialogue_ended
signal choices_presented(choices)
signal choice_made(choice_key)

# Current dialogue state
var is_dialogue_active: bool = false
var current_character: Character
var current_choices: Dictionary = {}

func start_dialogue(character: Character, text: String):
    current_character = character
    is_dialogue_active = true
    emit_signal("dialogue_started", character, text)

func end_dialogue():
    is_dialogue_active = false
    emit_signal("dialogue_ended")

func present_choices(choices: Dictionary):
    current_choices = choices
    emit_signal("choices_presented", choices)

func make_choice(choice_key: String):
    if current_choices.has(choice_key):
        emit_signal("choice_made", choice_key)
        return current_choices[choice_key]
    return null

# Helper function to format dialogue text with variables
func format_dialogue(text: String, variables: Dictionary) -> String:
    var formatted_text = text
    
    for key in variables:
        formatted_text = formatted_text.replace("{" + key + "}", str(variables[key]))
    
    return formatted_text

# Load dialogue from a JSON file
func load_dialogue_from_file(file_path: String) -> Dictionary:
    var file = File.new()
    if file.file_exists(file_path):
        file.open(file_path, File.READ)
        var json_text = file.get_as_text()
        file.close()
        
        var json_result = JSON.parse(json_text)
        if json_result.error == OK:
            return json_result.result
    
    # Return empty dictionary if file doesn't exist or has errors
    return {}
