/*
    NAME   : K.A.H.D. Vihangi Devthilini Jayasekara
    SID    : 20211207
    UoW ID : w1898902
    Module : Formal Method 
*/


MACHINE Battle // // This defines the B machine named "Battle" for the Battleships game.
SETS
    PLAYERS = {Player1, Player2}; // Defines the set of players, Player1 and Player2.
    GAME_STATE = {ongoing, Player1Wins, Player2Wins, setup}; // Defines the different states of the game: setup, ongoing, and win states for each player.
    REPORT = {success, hit, miss,Player_1_deployed_successfully,Already_Full_Position,Player_2_deployed_successfully,error,Player_1_Win,Player_1_has_made_a_hit,Player_2_Win,Player_2_has_made_a_hit} // Defines the set of possible reports or feedback that the game can generate after operations.

CONSTANTS
    FLEET_SIZE, GRID_POSITIONS
PROPERTIES
    FLEET_SIZE = 3 & // FLEET_SIZE specifies the number of ships each player has.
    GRID_POSITIONS = (1..5) * (1..5) // GRID_POSITIONS defines the grid size for the game.

DEFINITIONS
    // Battleships Game Animation Section


ANIMATION_FUNCTION ==
    ({row, column, image | row: (1..5) & column: (1..5) &
        (IF (game_state = Player1Wins & column |-> row : player1_fleet)
         THEN
             image = 3 // Player1's remaining ships highlighted in victory
         ELSE
             IF (game_state = Player2Wins & column |-> row : player2_fleet)
             THEN
                 image = 4 // Player2's remaining ships highlighted in victory
             ELSE
                 IF (column |-> row : player1_fleet)
                 THEN
                     image = 1 // Player1's ship location
                 ELSE
                     IF (column |-> row : player2_fleet)
                     THEN
                         image = 2 // Player2's ship location
                     ELSE
                         image = 0 // Empty grid positions
                     END
                 END
             END
         END
     )});


// Descriptions for images:
// ANIMATION_IMG0 represents empty grid positions.
// ANIMATION_IMG1 represents Player1's ships.
// ANIMATION_IMG2 represents Player2's ships.
// ANIMATION_IMG3 represents Player1's ships in victory state.
// ANIMATION_IMG4 represents Player2's ships in victory state.

ANIMATION_IMG0 == "Images/Empty.gif"; // Empty position
ANIMATION_IMG1 == "Images/Player1_Ship.png"; // Player1 ship
ANIMATION_IMG2 == "Images/Player2_Ship.png"; // Player2 ship
ANIMATION_IMG3 == "Images/Player1_Victory.png"; // Player1 victory
ANIMATION_IMG4 == "Images/Player2_Victory.png"; // Player2 victory




VARIABLES
    player1_fleet, player2_fleet, current_turn, shots_taken, game_state
    /*
    // player1_fleet and player2_fleet store the grid positions of Player1's and Player2's ships, respectively.       
    // current_turn keeps track of which player's turn it is.
    // shots_taken is a mapping that records the number of shots taken by each player.
    // game_state represents the current state of the game.
    */

INVARIANT
    player1_fleet <: GRID_POSITIONS & card(player1_fleet) <= FLEET_SIZE & // Ensures Player1's fleet is a subset of the grid positions and does not exceed the fleet size.
    player2_fleet <: GRID_POSITIONS & card(player2_fleet) <= FLEET_SIZE & // Ensures Player2's fleet is a subset of the grid positions and does not exceed the fleet size.
    current_turn : PLAYERS & // Ensures that the current turn variable always refers to a valid player.
    game_state : GAME_STATE & // Ensures the game state is always a valid value from the GAME_STATE set.
    shots_taken : PLAYERS --> NAT // Ensures the shots_taken variable maps each player to a natural number.

INITIALISATION
    player1_fleet := {} || // Initializes Player1's fleet as empty.
    player2_fleet := {} || // Initializes Player2's fleet as empty.
    current_turn := Player1 || // Sets Player1 as the first player to take a turn.
    game_state := setup || // Sets the initial game state to setup, indicating players need to deploy fleets.
    shots_taken := PLAYERS * {0} // Initializes the number of shots taken by each player to 0.

OPERATIONS

    report <-- deployFleet(player,positions) = 
       PRE
            player : PLAYERS & // Ensures the player parameter is valid (either Player1 or Player2).
            positions <: GRID_POSITIONS & // Ensures the positions provided are within the valid grid positions.
            card(positions)=3  & positions /\ (player1_fleet \/ player2_fleet) = {} // Ensures exactly 3 positions are provided and there is no overlap with already deployed fleets.
            
       THEN
            IF player = Player1 
            THEN
                IF player1_fleet = {} // Checks if Player1 has not already deployed their fleet.
                THEN
                    player1_fleet := positions || report := Player_1_deployed_successfully || // Updates Player1's fleet to the provided positions and sets the report to success.
                    IF player2_fleet /= {} THEN
                        game_state := ongoing // If Player2 has already deployed their fleet, set the game state to ongoing.
                    ELSE
                        current_turn := Player2 // Otherwise, set the next turn to Player2 for their fleet deployment.
                    END
               ELSE
                 report := Already_Full_Position // If Player1 has already deployed their fleet, return an error report.
               END
            ELSIF  player = Player2
            THEN
                IF player2_fleet = {} // Checks if Player2 has not already deployed their fleet.
                THEN
                    player2_fleet := positions || report := Player_2_deployed_successfully || // Updates Player2's fleet to the provided positions and sets the report to success.
                    IF player1_fleet /= {} THEN
                        game_state := ongoing // If Player1 has already deployed their fleet, set the game state to ongoing.
                    ELSE
                        current_turn := Player1 // Otherwise, set the next turn to Player1 for their fleet deployment.
                    END
               ELSE
                 report := Already_Full_Position // If Player2 has already deployed their fleet, return an error report.
               END
             END
         END;    
// Ends the deployFleet operation

report <-- playerShoots(target) =
        PRE
            target : GRID_POSITIONS & // Ensures the target is a valid grid position.
            current_turn : PLAYERS & // Ensures the current turn belongs to a valid player.
            game_state = ongoing // Ensures the game is in the ongoing state before allowing a shot.
        THEN
            IF target /: GRID_POSITIONS THEN
                report := error // If the target is out of the grid, return an error report.
            ELSE IF current_turn = Player1 THEN
                shots_taken(Player1) := shots_taken(Player1) + 1 || // Increment the number of shots taken by Player1.
                IF target : player2_fleet THEN
                    player2_fleet := player2_fleet - {target} || // Remove the hit target from Player2's fleet.
                    IF (card(player2_fleet)=1) THEN
                        game_state := Player1Wins || // If Player2 has no ships left, Player1 wins.
                        report := Player_1_Win
                    ELSE
                        report := Player_1_has_made_a_hit // Otherwise, return a hit report for Player1.
                    END
                ELSE
                    report := miss // If the target is not part of Player2's fleet, return a miss report.
                END ||
                current_turn := Player2 // Switch the turn to Player2.
            ELSE
                shots_taken(Player2) := shots_taken(Player2) + 1 || // Increment the number of shots taken by Player2.
                IF target : player1_fleet THEN
                    player1_fleet := player1_fleet - {target} || // Remove the hit target from Player1's fleet.
                    IF (card(player1_fleet)=1) THEN
                        game_state := Player2Wins || // If Player1 has no ships left, Player2 wins.
                        report := Player_2_Win
                    ELSE
                        report := Player_2_has_made_a_hit // Otherwise, return a hit report for Player2.
                    END
                ELSE
                    report := miss // If the target is not part of Player1's fleet, return a miss report.
                END ||
                current_turn := Player1 // Switch the turn to Player1.
            END
        END
    END;

// Ends the playerShoots operation.




    shipsquares <-- shipLocations(player) =
        PRE
            player : PLAYERS // Ensures the player parameter is valid.
        THEN
            IF player = Player1 THEN
                shipsquares := player1_fleet // Returns the locations of Player1's ships.
            ELSE
                shipsquares := player2_fleet // Returns the locations of Player2's ships.
            END
        END;
// Ends the shipLocations operation.



  shipCounts <-- shipsLeft =
    BEGIN
        shipCounts := {Player1 |-> card(player1_fleet), Player2 |-> card(player2_fleet)} // Returns the number of ships left for both players as a mapping.
    END;

// Ends the shipsLeft operation.



    shotCount <-- shotsTaken(player) =
        PRE
            player : PLAYERS // Ensures the player parameter is valid.
        THEN
            shotCount := shots_taken(player) // Returns the number of shots taken by the specified player.
        END;

// Ends the shotsTaken operation.


    report <-- gameStatus =
        BEGIN
            report := game_state // Returns the current game state (e.g., ongoing, Player1Wins, setup).
        END

// Ends the gameStatus operation.



END
// Ends the B machine.