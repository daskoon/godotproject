extends Node
class_name Character

# Character types
enum CharacterType {
    PLAYER,
    MANAGER,
    CUSTOMER_REGULAR,
    CUSTOMER_KAREN,
    CUSTOMER_ELDERLY,
    CUSTOMER_RUSHED,
    CUSTOMER_SUSPICIOUS
}

# Character properties
var character_name: String
var character_type: int
var expressions: Dictionary = {}
var current_expression: String = "neutral"

# Customer-specific properties
var patience: float = 100.0
var difficulty: int = 1
var value: int = 1

# Signal for expression changes
signal expression_changed(expression_name)

func _init(name: String, type: int):
    character_name = name
    character_type = type

func set_expression(expression_name: String):
    if expressions.has(expression_name):
        current_expression = expression_name
        emit_signal("expression_changed", expression_name)

func get_current_texture() -> Texture:
    if expressions.has(current_expression):
        return expressions[current_expression]
    return null

func load_expressions(base_path: String):
    # Load all expression textures for this character
    var expression_types = ["neutral", "happy", "sad", "angry", "worried", "surprised"]
    
    for expr in expression_types:
        var texture_path = base_path + "_" + expr + ".png"
        if ResourceLoader.exists(texture_path):
            expressions[expr] = load(texture_path)

# Static function to create a customer based on type
static func create_customer(customer_type: int) -> Character:
    var type_names = {
        CharacterType.CUSTOMER_REGULAR: "Regular Customer",
        CharacterType.CUSTOMER_KAREN: "Demanding Customer",
        CharacterType.CUSTOMER_ELDERLY: "Elderly Customer",
        CharacterType.CUSTOMER_RUSHED: "Rushed Customer",
        CharacterType.CUSTOMER_SUSPICIOUS: "Suspicious Customer"
    }
    
    var customer = Character.new(type_names[customer_type], customer_type)
    
    # Set customer-specific attributes based on type
    match customer_type:
        CharacterType.CUSTOMER_REGULAR:
            customer.patience = 80.0
            customer.difficulty = 1
            customer.value = 1
        CharacterType.CUSTOMER_KAREN:
            customer.patience = 40.0
            customer.difficulty = 3
            customer.value = 2
        CharacterType.CUSTOMER_ELDERLY:
            customer.patience = 90.0
            customer.difficulty = 2
            customer.value = 1
        CharacterType.CUSTOMER_RUSHED:
            customer.patience = 30.0
            customer.difficulty = 2
            customer.value = 1
        CharacterType.CUSTOMER_SUSPICIOUS:
            customer.patience = 60.0
            customer.difficulty = 2
            customer.value = 3
    
    # Load expressions
    var base_path = "res://assets/images/customer"
    match customer_type:
        CharacterType.CUSTOMER_REGULAR:
            base_path += "_regular"
        CharacterType.CUSTOMER_KAREN:
            base_path += "_karen"
        CharacterType.CUSTOMER_ELDERLY:
            base_path += "_elderly"
        CharacterType.CUSTOMER_RUSHED:
            base_path += "_rushed"
        CharacterType.CUSTOMER_SUSPICIOUS:
            base_path += "_suspicious"
    
    customer.load_expressions(base_path)
    return customer
