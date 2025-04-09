# Migrating from Ren'Py to Godot

This guide provides information on how to migrate your Ren'Py visual novel to Godot Engine.

## Conceptual Differences

### Ren'Py vs. Godot

| Ren'Py Concept | Godot Equivalent |
|----------------|------------------|
| Labels | Scenes or Functions |
| Menus | UI Buttons with signals |
| Characters | Custom Character class |
| Dialogue | RichTextLabel with custom dialogue system |
| Expressions | Sprite textures or AnimatedSprite |
| Transitions | AnimationPlayer |
| Python code blocks | GDScript functions |
| Screen language | Scene tree with Control nodes |

## Asset Migration

1. **Images**: Ren'Py and Godot both support common image formats (PNG, JPG)
   - Copy your images to the `assets/images/` folder
   - You may need to adjust image paths in your code

2. **Audio**: Ren'Py and Godot both support common audio formats (OGG, WAV, MP3)
   - Copy your audio files to the `assets/audio/` folder
   - You may need to adjust audio paths in your code

3. **Fonts**: Copy your custom fonts to the `assets/fonts/` folder

## Code Migration

### Dialogue System

In Ren'Py:
```renpy
label start:
    "This is narration."
    
    show eileen happy
    
    e "This is dialogue."
    
    menu:
        "Option 1":
            e "You selected option 1."
        "Option 2":
            e "You selected option 2."
```

In Godot:
```gdscript
func start_dialogue():
    dialogue_manager.start_dialogue(narrator, "This is narration.")
    yield(dialogue_manager, "dialogue_ended")
    
    character.set_expression("happy")
    dialogue_manager.start_dialogue(character, "This is dialogue.")
    yield(dialogue_manager, "dialogue_ended")
    
    var choices = {
        "option1": {"text": "Option 1"},
        "option2": {"text": "Option 2"}
    }
    dialogue_manager.present_choices(choices)
    
    var choice = yield(dialogue_manager, "choice_made")
    
    if choice == "option1":
        dialogue_manager.start_dialogue(character, "You selected option 1.")
    else:
        dialogue_manager.start_dialogue(character, "You selected option 2.")
```

### Variables and State

In Ren'Py:
```renpy
$ customer_patience = 100
$ self_boredom = 0

label check_state:
    if customer_patience <= 0:
        jump game_over
    else:
        jump continue_game
```

In Godot:
```gdscript
var customer_patience = 100
var self_boredom = 0

func check_state():
    if customer_patience <= 0:
        game_over()
    else:
        continue_game()
```

## UI Migration

### Dialogue Box

In Ren'Py, dialogue boxes are defined in screens:
```renpy
screen say(who, what):
    style_prefix "say"
    window:
        id "window"
        text what id "what"
        if who:
            text who id "who"
```

In Godot, you create a dialogue box using Control nodes:
```gdscript
# In your scene tree:
# - DialogueBox (Panel)
#   - NameLabel (Label)
#   - TextLabel (RichTextLabel)

func show_dialogue(character, text):
    $DialogueBox/NameLabel.text = character.name
    $DialogueBox/TextLabel.text = text
    $DialogueBox.visible = true
```

### Menu Choices

In Ren'Py:
```renpy
menu:
    "Option 1":
        $ choice = 1
    "Option 2":
        $ choice = 2
```

In Godot:
```gdscript
# In your scene tree:
# - ChoicesContainer (VBoxContainer)

func show_choices(choices):
    # Clear previous choices
    for child in $ChoicesContainer.get_children():
        child.queue_free()
    
    # Add new choices
    for key in choices:
        var button = Button.new()
        button.text = choices[key].text
        button.connect("pressed", self, "_on_choice_selected", [key])
        $ChoicesContainer.add_child(button)
    
    $ChoicesContainer.visible = true

func _on_choice_selected(key):
    $ChoicesContainer.visible = false
    # Process the choice
```

## Tips for a Successful Migration

1. **Start small**: Begin by migrating a small part of your game to get familiar with Godot
2. **Use Godot's strengths**: Take advantage of Godot's scene system and signals
3. **Refactor your code**: Don't try to directly translate Ren'Py code to GDScript
4. **Create reusable components**: Build modular systems that you can reuse
5. **Test frequently**: Test each component as you migrate it

## Resources

- [Godot Documentation](https://docs.godotengine.org/)
- [GDScript Basics](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html)
- [UI System in Godot](https://docs.godotengine.org/en/stable/tutorials/ui/index.html)
- [Signals in Godot](https://docs.godotengine.org/en/stable/tutorials/scripting/signals.html)
