# Godot Engine Basics

This guide provides a quick introduction to Godot Engine for beginners.

## What is Godot?

Godot is a free and open-source game engine that allows you to create 2D and 3D games. It features a unique node-based architecture and its own scripting language called GDScript (similar to Python).

## Installing Godot

1. Go to [godotengine.org](https://godotengine.org/download)
2. Download the Standard version (not Mono unless you want C# support)
3. Extract the downloaded file - Godot doesn't require installation
4. Run the Godot executable

## Godot Interface

The Godot editor is divided into several areas:

- **Scene Panel**: Shows the hierarchy of nodes in your current scene
- **FileSystem Panel**: Shows your project files and folders
- **Inspector Panel**: Shows properties of the selected node
- **Viewport**: Shows the visual representation of your scene
- **Script Editor**: Where you write code for your game

## Key Concepts

### Nodes

Nodes are the basic building blocks in Godot. Each node has properties, can be transformed, and can have scripts attached.

Common node types:
- **Node2D**: Base for all 2D nodes
- **Sprite**: Displays a texture/image
- **Control**: Base for all UI elements
- **Label**: Displays text
- **Button**: Clickable button
- **AudioStreamPlayer**: Plays audio

### Scenes

A scene is a collection of nodes organized in a tree structure. Scenes can be:
- Saved and loaded
- Instanced multiple times
- Nested inside other scenes

### Scripts

Scripts add behavior to nodes. In GDScript, a basic script looks like:

```gdscript
extends Node2D  # Extends the Node2D class

# Called when the node enters the scene tree
func _ready():
    print("Hello, world!")

# Called every frame
func _process(delta):
    # delta is the time since the last frame
    position.x += 100 * delta  # Move 100 pixels per second
```

### Signals

Signals are Godot's version of the observer pattern. They allow nodes to emit notifications that other nodes can respond to.

```gdscript
# Connecting a signal
$Button.connect("pressed", self, "_on_Button_pressed")

# Signal handler function
func _on_Button_pressed():
    print("Button was pressed!")
```

## Basic GDScript Syntax

### Variables

```gdscript
var my_variable = 5  # Inferred type (int)
var my_string: String = "Hello"  # Explicit type
const SPEED = 300  # Constant
export var health = 100  # Visible in the Inspector
```

### Functions

```gdscript
func my_function():
    print("Called my function")

func add(a, b):
    return a + b
    
func with_default_param(text = "Default"):
    print(text)
```

### Control Flow

```gdscript
# If statement
if condition:
    do_something()
elif other_condition:
    do_something_else()
else:
    do_fallback()

# For loop
for i in range(10):
    print(i)
    
# While loop
while condition:
    do_something()
    
# Match statement (similar to switch)
match value:
    1:
        print("One")
    2:
        print("Two")
    _:
        print("Other")
```

### Classes

```gdscript
class MyClass:
    var property = 0
    
    func _init(initial_value = 0):
        property = initial_value
        
    func method():
        return property * 2

# Usage
var instance = MyClass.new(5)
print(instance.method())  # Outputs: 10
```

## Common Tasks

### Loading Scenes

```gdscript
# Change to a new scene
get_tree().change_scene("res://scenes/OtherScene.tscn")

# Instance a scene
var scene = load("res://scenes/Enemy.tscn")
var instance = scene.instance()
add_child(instance)
```

### Input Handling

```gdscript
func _process(delta):
    # Keyboard input
    if Input.is_action_pressed("ui_right"):
        position.x += speed * delta
        
    # Mouse input
    if Input.is_action_just_pressed("ui_select"):  # Left mouse button
        shoot()
```

### UI Interaction

```gdscript
# Connect a button signal
$Button.connect("pressed", self, "_on_Button_pressed")

# Update a label
$Label.text = "Score: " + str(score)

# Show/hide UI elements
$Panel.visible = true  # Show
$Panel.visible = false  # Hide
```

## Resources

- [Official Godot Documentation](https://docs.godotengine.org/)
- [Godot Tutorial Series on YouTube](https://www.youtube.com/c/GDQuest)
- [Godot Recipes](https://kidscancode.org/godot_recipes/)
- [Godot Asset Library](https://godotengine.org/asset-library/asset)

## Tips for Beginners

1. Start with small projects to learn the basics
2. Use the built-in documentation (Help > Search)
3. Join the Godot community (Discord, Reddit, Forums)
4. Follow tutorials but try to understand the code
5. Experiment and have fun!
