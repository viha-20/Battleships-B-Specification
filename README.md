# Battleships-B-Specification

# Battleships B Specification

This repository contains the B specification for a simplified version of the Battleships board game, developed as coursework for the Formal Methods (6SENG005W) module at the University of Westminster. The project demonstrates the use of the B method to formally specify a system using sets, constants, variables, and operations.


# Objectives

 Develop a formal specification for a two-player strategy game using the B language.
 Define the system state, constraints, and operations in a structured and precise manner.
 Utilize Atelier B and ProB tools to validate and analyze the specification.


# Game Rules and Constraints

 The game is played on a 10x10 grid for each player.
 Each player has exactly 3 warships, each occupying a single square.
 Players alternate turns, attempting to sink their opponent's ships.
 A "hit" results in removing a ship from the opponent’s grid; a "miss" has no effect.
 The game ends when all ships of one player are sunk.
 Warships cannot share grid squares.



# Specification Components

1. Sets and Constants
    Defines key sets and constants required to describe the game, including:

      * Players
      * Grid dimensions
      * Maximum number of ships per player

2. System State
    State variables represent:

      * Each player’s grid and fleet
      * The current game status (ongoing, player win, fleet deployment pending, etc.)
      * The player whose turn it is

3. Operations
    Operations defined in the specification include:

Deployment:
  deployFleet(player, positions): Validates and places a player’s ships on the grid.

Shooting:
  playerShoots(target): Handles a player’s attempt to target an opponent’s ship.

Enquiry Operations:
  shipLocations(player): Returns the locations of all ships for a player.
  shipsLeft(): Returns the number of remaining ships for both players.
  shotsTaken(player): Outputs the total number of shots taken by a player.
  gameStatus(): Provides the current status of the game (e.g., ongoing, player win).


# Tools Used

Atelier B: For developing and verifying the B specification.
ProB: For animation and validation of the specification.


# File Structure
  Battleships.mch: The main B machine file containing the specification.
  README.md: Project overview and details.

# How to Use
  Open the Battleships.mch file in Atelier B.
  Validate the specification to ensure correctness.
  Use ProB to animate the game and explore its functionality.
  Modify and extend the specification as needed.



Author
Vihangi Jayasekara
Undergraduate Student, 
School of Computer Science and EngineeringUniversity of Westminster
