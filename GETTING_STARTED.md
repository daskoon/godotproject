# Getting Started with Big Box Blues in Godot

Welcome to the Godot version of Big Box Blues! This document will help you get started with your new game project.

## Project Overview

Big Box Blues is a dialogue-driven simulation/management game where you play as a disgraced field tech working at a big-box electronics store. The game simulates a work shift with customer interactions, random events, and dialogue choices that affect your performance metrics.

## Prerequisites

Before you begin, make sure you have:

1. [Godot Engine](https://godotengine.org/download) (version 3.5 or newer)
2. Basic understanding of GDScript (similar to Python)
3. Image editing software for creating/editing sprites (optional)

## Opening the Project

1. Download and install Godot Engine
2. Open Godot Engine
3. Click "Import" on the Project Manager screen
4. Navigate to the `godot_project` folder and select the `project.godot` file
5. Click "Import & Edit"

## Project Structure

The project is organized as follows:

- `scenes/` - Contains all game scenes
  - `MainMenu.tscn` - The main menu
  - `MainGame.tscn` - The main gameplay scene
  - `GameOver.tscn` - The end-of-shift results scene
- `scripts/` - Contains all GDScript code
  - `game_manager.gd` - Main game controller
  - `game_metrics.gd` - Handles game metrics
  - `character.gd` - Character class
  - `dialogue_manager.gd` - Dialogue system
  - `scenario.gd` - Scenario class
  - `scenario_loader.gd` - Loads scenarios from JSON
  - `main_game.gd` - Main gameplay controller
  - `main_menu.gd` - Main menu controller
  - `game_over.gd` - Game over scene controller
- `assets/` - Contains all game assets
  - `images/` - Character sprites and backgrounds
  - `audio/` - Sound effects and music
  - `fonts/` - Custom fonts
  - `scenarios.json` - Scenario data

## Running the Game

1. In the Godot editor, click the "Play" button in the top-right corner
2. Alternatively, press F5 on your keyboard
3. The game will start from the main scene defined in the project settings

## Making Changes

### Editing Scenarios

The easiest way to add or modify scenarios is by editing the `assets/scenarios.json` file. See `ADDING_CONTENT.md` for details on the scenario format.

### Adding Characters

To add new character types, edit the `scripts/character.gd` file. See `ADDING_CONTENT.md` for instructions.

### Modifying UI

The UI is defined in the scene files. You can edit them in the Godot editor:

1. Open a scene file (e.g., `scenes/MainGame.tscn`)
2. Select UI elements in the Scene panel
3. Modify their properties in the Inspector panel
4. Save the scene (Ctrl+S)

### Scripting

To modify game behavior:

1. Open a script file (e.g., `scripts/main_game.gd`)
2. Edit the code
3. Save the script (Ctrl+S)
4. Run the game to test your changes

## Additional Resources

This project includes several helpful documents:

- `README.md` - General project information
- `MIGRATION_GUIDE.md` - Guide for migrating from Ren'Py to Godot
- `ADDING_CONTENT.md` - Instructions for adding new content
- `GODOT_BASICS.md` - Introduction to Godot Engine basics

## Next Steps

1. Add placeholder images for characters and backgrounds
   - Create simple PNG files for each character and expression
   - Place them in the `assets/images/` folder
2. Implement more scenarios in the `scenarios.json` file
3. Add sound effects and music to the `assets/audio/` folder
4. Enhance the UI with custom themes
5. Add animations for character expressions and transitions

## Getting Help

If you need help with Godot:

- [Official Godot Documentation](https://docs.godotengine.org/)
- [Godot Q&A](https://godotengine.org/qa/)
- [Godot Discord](https://discord.gg/4JBkykG)
- [Godot Reddit](https://www.reddit.com/r/godot/)

Happy game development!
