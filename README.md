# Big Box Blues - Godot Implementation

This is a Godot implementation of the "Big Box Blues" game, converted from Ren'Py to Godot Engine.

## Getting Started

1. Download and install Godot Engine 3.5+ from [godotengine.org](https://godotengine.org/download)
2. Open Godot Engine and click "Import"
3. Navigate to this folder and select the `project.godot` file
4. Click "Import & Edit"
5. Once the project is open, click the "Play" button in the top-right corner to run the game

## Project Structure

- `scenes/` - Contains all game scenes
  - `MainMenu.tscn` - The main menu scene
  - `MainGame.tscn` - The main gameplay scene
  - `GameOver.tscn` - The end-of-shift results scene
- `scripts/` - Contains all GDScript code
  - `game_manager.gd` - Main game controller (autoloaded singleton)
  - `game_metrics.gd` - Handles game metrics (patience, boredom, etc.)
  - `character.gd` - Character class for player and NPCs
  - `dialogue_manager.gd` - Handles dialogue and choices
  - `scenario.gd` - Scenario class for customer interactions
  - `main_game.gd` - Main gameplay scene controller
  - `main_menu.gd` - Main menu controller
  - `game_over.gd` - Game over scene controller
- `assets/` - Contains all game assets
  - `images/` - Character sprites and backgrounds
  - `audio/` - Sound effects and music
  - `fonts/` - Custom fonts

## Adding Content

### Adding New Scenarios

To add new scenarios, you can either:

1. Edit the `initialize_placeholder()` method in `scenario.gd` to add more scenarios
2. Create a JSON file in the `assets` folder with scenario data and load it using `Scenario.load_scenarios_from_file()`

### Adding New Characters

To add new character types:

1. Add a new character type to the `CharacterType` enum in `character.gd`
2. Add the character creation logic in the `create_customer()` method
3. Add the character sprites to the `assets/images/` folder

### Customizing UI

The UI is defined in the scene files. You can edit them in the Godot editor to customize the appearance.

## Advantages Over Ren'Py

- More flexible gameplay mechanics
- Better performance
- Full control over UI and animations
- Easier to implement complex game systems
- Cross-platform deployment
- Powerful built-in tools for debugging and profiling

## Next Steps

1. Add placeholder images for characters and backgrounds
2. Implement more scenarios
3. Add sound effects and music
4. Enhance the UI with custom themes
5. Add animations for character expressions and transitions
