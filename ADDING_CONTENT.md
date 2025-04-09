# Adding Content to Big Box Blues

This guide explains how to add new content to your Big Box Blues game in Godot.

## Adding New Scenarios

The easiest way to add new scenarios is by editing the `scenarios.json` file in the `assets` folder.

### Scenario Structure

```json
{
  "scenario_key": {
    "title": "Scenario Title",
    "description": "Brief description of the scenario",
    "customer_type": ["regular", "karen", "elderly", "rushed", "suspicious"],
    "initial_dialogue": "What the customer says first",
    "choices": {
      "choice_key_1": {
        "text": "Button text shown to player",
        "response": "What the player character says",
        "effects": {
          "customer_patience": 10,
          "manager_annoyance": -5,
          "self_boredom": 5,
          "theft_loss": 0
        },
        "leads_to": "next_scene_or_label"
      },
      "choice_key_2": {
        "text": "Another option",
        "response": "Another response",
        "effects": {
          "customer_patience": -10,
          "manager_annoyance": 10,
          "self_boredom": -5,
          "theft_loss": 0
        },
        "leads_to": "different_scene"
      }
    }
  }
}
```

### Effects

Effects modify the game metrics:
- `customer_patience`: How satisfied the customer is (0-100)
- `manager_annoyance`: How annoyed your manager is (0-100)
- `self_boredom`: How bored you are (0-100)
- `theft_loss`: How much theft has occurred (0-100)

Positive values increase the metric, negative values decrease it.

### Example

Here's an example of a new scenario:

```json
"difficult_return": {
  "title": "Difficult Return",
  "description": "Customer wants to return a clearly used and damaged item",
  "customer_type": ["karen", "regular"],
  "initial_dialogue": "I want to return this. It doesn't work right.",
  "choices": {
    "inspect_item": {
      "text": "Inspect the item carefully",
      "response": "I see this item has been damaged. Our policy doesn't cover returns for damaged items.",
      "effects": {"customer_patience": -10, "manager_annoyance": -5, "self_boredom": 5},
      "leads_to": "customer_argument"
    },
    "accept_return": {
      "text": "Accept the return without question",
      "response": "I'll process this return for you right away.",
      "effects": {"customer_patience": 15, "manager_annoyance": 15, "self_boredom": -5},
      "leads_to": "process_return"
    },
    "escalate_to_manager": {
      "text": "Ask a manager to handle this",
      "response": "Let me get a manager to help with this special situation.",
      "effects": {"customer_patience": 5, "manager_annoyance": 10, "self_boredom": 0},
      "leads_to": "manager_decision"
    }
  }
}
```

## Adding New Customer Types

To add a new customer type:

1. Edit the `character.gd` script
2. Add a new type to the `CharacterType` enum:
   ```gdscript
   enum CharacterType {
       PLAYER,
       MANAGER,
       CUSTOMER_REGULAR,
       CUSTOMER_KAREN,
       CUSTOMER_ELDERLY,
       CUSTOMER_RUSHED,
       CUSTOMER_SUSPICIOUS,
       CUSTOMER_NEW_TYPE  # Add your new type here
   }
   ```

3. Add the new type to the `create_customer` function:
   ```gdscript
   static func create_customer(customer_type: int) -> Character:
       var type_names = {
           # ... existing types ...
           CharacterType.CUSTOMER_NEW_TYPE: "New Customer Type"
       }
       
       # ... existing code ...
       
       # Set customer-specific attributes based on type
       match customer_type:
           # ... existing types ...
           CharacterType.CUSTOMER_NEW_TYPE:
               customer.patience = 70.0
               customer.difficulty = 2
               customer.value = 2
       
       # ... existing code ...
       
       # Load expressions
       var base_path = "res://assets/images/customer"
       match customer_type:
           # ... existing types ...
           CharacterType.CUSTOMER_NEW_TYPE:
               base_path += "_new_type"
       
       # ... existing code ...
   ```

4. Add the corresponding images to the `assets/images` folder:
   - `customer_new_type_neutral.png`
   - `customer_new_type_happy.png`
   - `customer_new_type_sad.png`
   - `customer_new_type_angry.png`
   - `customer_new_type_worried.png`
   - `customer_new_type_surprised.png`

## Adding New Scenes

To add a new scene to the game:

1. Create a new scene file in the Godot editor:
   - Go to Scene > New Scene
   - Add a root node (Node2D for 2D scenes, Control for UI scenes)
   - Add child nodes as needed
   - Save the scene to the `scenes` folder

2. Create a script for the scene:
   - Attach a script to the root node
   - Implement the scene's functionality
   - Save the script to the `scripts` folder

3. Connect the scene to the game:
   - Update the game flow to include your new scene
   - For example, to add a new scene after a specific choice:
     ```gdscript
     # In main_game.gd
     func _on_choice_button_pressed(choice_key):
         # ... existing code ...
         
         # Handle next scene based on leads_to
         if choice.leads_to == "your_new_scene":
             get_tree().change_scene("res://scenes/YourNewScene.tscn")
         else:
             # ... existing code ...
     ```

## Adding New Art Assets

1. Create your art assets in your preferred image editor
2. Save them in the appropriate format (PNG recommended)
3. Place them in the `assets/images` folder
4. Use them in your game:
   ```gdscript
   # Load an image
   var texture = load("res://assets/images/your_image.png")
   
   # Assign it to a sprite
   $Sprite.texture = texture
   ```

## Adding New Audio

1. Prepare your audio files (OGG format recommended for best compatibility)
2. Place them in the `assets/audio` folder
3. Use them in your game:
   ```gdscript
   # Play a sound effect
   $AudioStreamPlayer.stream = load("res://assets/audio/your_sound.ogg")
   $AudioStreamPlayer.play()
   ```

## Testing Your Changes

Always test your changes to ensure they work as expected:

1. Run the game in the Godot editor (F5 or the Play button)
2. Test each new scenario or feature
3. Check for any errors in the Godot console
4. Make adjustments as needed
