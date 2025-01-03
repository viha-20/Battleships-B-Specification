Normalised(
THEORY MagicNumberX IS
  MagicNumber(Machine(Battle))==(3.5)
END
&
THEORY UpperLevelX IS
  First_Level(Machine(Battle))==(Machine(Battle));
  Level(Machine(Battle))==(0)
END
&
THEORY LoadedStructureX IS
  Machine(Battle)
END
&
THEORY ListSeesX IS
  List_Sees(Machine(Battle))==(?)
END
&
THEORY ListUsesX IS
  List_Uses(Machine(Battle))==(?)
END
&
THEORY ListIncludesX IS
  Inherited_List_Includes(Machine(Battle))==(?);
  List_Includes(Machine(Battle))==(?)
END
&
THEORY ListPromotesX IS
  List_Promotes(Machine(Battle))==(?)
END
&
THEORY ListExtendsX IS
  List_Extends(Machine(Battle))==(?)
END
&
THEORY ListVariablesX IS
  External_Context_List_Variables(Machine(Battle))==(?);
  Context_List_Variables(Machine(Battle))==(?);
  Abstract_List_Variables(Machine(Battle))==(?);
  Local_List_Variables(Machine(Battle))==(game_state,shots_taken,current_turn,player2_fleet,player1_fleet);
  List_Variables(Machine(Battle))==(game_state,shots_taken,current_turn,player2_fleet,player1_fleet);
  External_List_Variables(Machine(Battle))==(game_state,shots_taken,current_turn,player2_fleet,player1_fleet)
END
&
THEORY ListVisibleVariablesX IS
  Inherited_List_VisibleVariables(Machine(Battle))==(?);
  Abstract_List_VisibleVariables(Machine(Battle))==(?);
  External_List_VisibleVariables(Machine(Battle))==(?);
  Expanded_List_VisibleVariables(Machine(Battle))==(?);
  List_VisibleVariables(Machine(Battle))==(?);
  Internal_List_VisibleVariables(Machine(Battle))==(?)
END
&
THEORY ListInvariantX IS
  Gluing_Seen_List_Invariant(Machine(Battle))==(btrue);
  Gluing_List_Invariant(Machine(Battle))==(btrue);
  Expanded_List_Invariant(Machine(Battle))==(btrue);
  Abstract_List_Invariant(Machine(Battle))==(btrue);
  Context_List_Invariant(Machine(Battle))==(btrue);
  List_Invariant(Machine(Battle))==(player1_fleet <: GRID_POSITIONS & card(player1_fleet)<=FLEET_SIZE & player2_fleet <: GRID_POSITIONS & card(player2_fleet)<=FLEET_SIZE & current_turn: PLAYERS & game_state: GAME_STATE & shots_taken: PLAYERS --> NAT)
END
&
THEORY ListAssertionsX IS
  Expanded_List_Assertions(Machine(Battle))==(btrue);
  Abstract_List_Assertions(Machine(Battle))==(btrue);
  Context_List_Assertions(Machine(Battle))==(btrue);
  List_Assertions(Machine(Battle))==(btrue)
END
&
THEORY ListCoverageX IS
  List_Coverage(Machine(Battle))==(btrue)
END
&
THEORY ListExclusivityX IS
  List_Exclusivity(Machine(Battle))==(btrue)
END
&
THEORY ListInitialisationX IS
  Expanded_List_Initialisation(Machine(Battle))==(player1_fleet,player2_fleet,current_turn,game_state,shots_taken:={},{},Player1,setup,PLAYERS*{0});
  Context_List_Initialisation(Machine(Battle))==(skip);
  List_Initialisation(Machine(Battle))==(player1_fleet:={} || player2_fleet:={} || current_turn:=Player1 || game_state:=setup || shots_taken:=PLAYERS*{0})
END
&
THEORY ListParametersX IS
  List_Parameters(Machine(Battle))==(?)
END
&
THEORY ListInstanciatedParametersX END
&
THEORY ListConstraintsX IS
  List_Context_Constraints(Machine(Battle))==(btrue);
  List_Constraints(Machine(Battle))==(btrue)
END
&
THEORY ListOperationsX IS
  Internal_List_Operations(Machine(Battle))==(deployFleet,playerShoots,shipLocations,shipsLeft,shotsTaken,gameStatus);
  List_Operations(Machine(Battle))==(deployFleet,playerShoots,shipLocations,shipsLeft,shotsTaken,gameStatus)
END
&
THEORY ListInputX IS
  List_Input(Machine(Battle),deployFleet)==(player,positions);
  List_Input(Machine(Battle),playerShoots)==(target);
  List_Input(Machine(Battle),shipLocations)==(player);
  List_Input(Machine(Battle),shipsLeft)==(?);
  List_Input(Machine(Battle),shotsTaken)==(player);
  List_Input(Machine(Battle),gameStatus)==(?)
END
&
THEORY ListOutputX IS
  List_Output(Machine(Battle),deployFleet)==(report);
  List_Output(Machine(Battle),playerShoots)==(report);
  List_Output(Machine(Battle),shipLocations)==(shipsquares);
  List_Output(Machine(Battle),shipsLeft)==(shipCounts);
  List_Output(Machine(Battle),shotsTaken)==(shotCount);
  List_Output(Machine(Battle),gameStatus)==(report)
END
&
THEORY ListHeaderX IS
  List_Header(Machine(Battle),deployFleet)==(report <-- deployFleet(player,positions));
  List_Header(Machine(Battle),playerShoots)==(report <-- playerShoots(target));
  List_Header(Machine(Battle),shipLocations)==(shipsquares <-- shipLocations(player));
  List_Header(Machine(Battle),shipsLeft)==(shipCounts <-- shipsLeft);
  List_Header(Machine(Battle),shotsTaken)==(shotCount <-- shotsTaken(player));
  List_Header(Machine(Battle),gameStatus)==(report <-- gameStatus)
END
&
THEORY ListOperationGuardX END
&
THEORY ListPreconditionX IS
  List_Precondition(Machine(Battle),deployFleet)==(player: PLAYERS & positions <: GRID_POSITIONS & card(positions) = 3 & positions/\(player1_fleet\/player2_fleet) = {});
  List_Precondition(Machine(Battle),playerShoots)==(target: GRID_POSITIONS & current_turn: PLAYERS & game_state = ongoing);
  List_Precondition(Machine(Battle),shipLocations)==(player: PLAYERS);
  List_Precondition(Machine(Battle),shipsLeft)==(btrue);
  List_Precondition(Machine(Battle),shotsTaken)==(player: PLAYERS);
  List_Precondition(Machine(Battle),gameStatus)==(btrue)
END
&
THEORY ListSubstitutionX IS
  Expanded_List_Substitution(Machine(Battle),gameStatus)==(btrue | report:=game_state);
  Expanded_List_Substitution(Machine(Battle),shotsTaken)==(player: PLAYERS | shotCount:=shots_taken(player));
  Expanded_List_Substitution(Machine(Battle),shipsLeft)==(btrue | shipCounts:={Player1|->card(player1_fleet),Player2|->card(player2_fleet)});
  Expanded_List_Substitution(Machine(Battle),shipLocations)==(player: PLAYERS | player = Player1 ==> shipsquares:=player1_fleet [] not(player = Player1) ==> shipsquares:=player2_fleet);
  Expanded_List_Substitution(Machine(Battle),playerShoots)==(target: GRID_POSITIONS & current_turn: PLAYERS & game_state = ongoing | target/:GRID_POSITIONS ==> report:=error [] not(target/:GRID_POSITIONS) ==> (current_turn = Player1 ==> (shots_taken:=shots_taken<+{Player1|->shots_taken(Player1)+1} || (target: player2_fleet ==> (player2_fleet:=player2_fleet-{target} || (card(player2_fleet) = 1 ==> game_state,report:=Player1Wins,Player_1_Win [] not(card(player2_fleet) = 1) ==> report:=Player_1_has_made_a_hit)) [] not(target: player2_fleet) ==> report:=miss) || current_turn:=Player2) [] not(current_turn = Player1) ==> (shots_taken:=shots_taken<+{Player2|->shots_taken(Player2)+1} || (target: player1_fleet ==> (player1_fleet:=player1_fleet-{target} || (card(player1_fleet) = 1 ==> game_state,report:=Player2Wins,Player_2_Win [] not(card(player1_fleet) = 1) ==> report:=Player_2_has_made_a_hit)) [] not(target: player1_fleet) ==> report:=miss) || current_turn:=Player1)));
  Expanded_List_Substitution(Machine(Battle),deployFleet)==(player: PLAYERS & positions <: GRID_POSITIONS & card(positions) = 3 & positions/\(player1_fleet\/player2_fleet) = {} | player = Player1 ==> (player1_fleet = {} ==> (player1_fleet,report:=positions,Player_1_deployed_successfully || (player2_fleet/={} ==> game_state:=ongoing [] not(player2_fleet/={}) ==> current_turn:=Player2)) [] not(player1_fleet = {}) ==> report:=Already_Full_Position) [] not(player = Player1) ==> (player = Player2 ==> (player2_fleet = {} ==> (player2_fleet,report:=positions,Player_2_deployed_successfully || (player1_fleet/={} ==> game_state:=ongoing [] not(player1_fleet/={}) ==> current_turn:=Player1)) [] not(player2_fleet = {}) ==> report:=Already_Full_Position) [] not(player = Player2) ==> skip));
  List_Substitution(Machine(Battle),deployFleet)==(IF player = Player1 THEN IF player1_fleet = {} THEN player1_fleet:=positions || report:=Player_1_deployed_successfully || IF player2_fleet/={} THEN game_state:=ongoing ELSE current_turn:=Player2 END ELSE report:=Already_Full_Position END ELSIF player = Player2 THEN IF player2_fleet = {} THEN player2_fleet:=positions || report:=Player_2_deployed_successfully || IF player1_fleet/={} THEN game_state:=ongoing ELSE current_turn:=Player1 END ELSE report:=Already_Full_Position END END);
  List_Substitution(Machine(Battle),playerShoots)==(IF target/:GRID_POSITIONS THEN report:=error ELSE IF current_turn = Player1 THEN shots_taken(Player1):=shots_taken(Player1)+1 || IF target: player2_fleet THEN player2_fleet:=player2_fleet-{target} || IF card(player2_fleet) = 1 THEN game_state:=Player1Wins || report:=Player_1_Win ELSE report:=Player_1_has_made_a_hit END ELSE report:=miss END || current_turn:=Player2 ELSE shots_taken(Player2):=shots_taken(Player2)+1 || IF target: player1_fleet THEN player1_fleet:=player1_fleet-{target} || IF card(player1_fleet) = 1 THEN game_state:=Player2Wins || report:=Player_2_Win ELSE report:=Player_2_has_made_a_hit END ELSE report:=miss END || current_turn:=Player1 END END);
  List_Substitution(Machine(Battle),shipLocations)==(IF player = Player1 THEN shipsquares:=player1_fleet ELSE shipsquares:=player2_fleet END);
  List_Substitution(Machine(Battle),shipsLeft)==(shipCounts:={Player1|->card(player1_fleet),Player2|->card(player2_fleet)});
  List_Substitution(Machine(Battle),shotsTaken)==(shotCount:=shots_taken(player));
  List_Substitution(Machine(Battle),gameStatus)==(report:=game_state)
END
&
THEORY ListConstantsX IS
  List_Valuable_Constants(Machine(Battle))==(FLEET_SIZE,GRID_POSITIONS);
  Inherited_List_Constants(Machine(Battle))==(?);
  List_Constants(Machine(Battle))==(FLEET_SIZE,GRID_POSITIONS)
END
&
THEORY ListSetsX IS
  Set_Definition(Machine(Battle),PLAYERS)==({Player1,Player2});
  Context_List_Enumerated(Machine(Battle))==(?);
  Context_List_Defered(Machine(Battle))==(?);
  Context_List_Sets(Machine(Battle))==(?);
  List_Valuable_Sets(Machine(Battle))==(?);
  Inherited_List_Enumerated(Machine(Battle))==(?);
  Inherited_List_Defered(Machine(Battle))==(?);
  Inherited_List_Sets(Machine(Battle))==(?);
  List_Enumerated(Machine(Battle))==(PLAYERS,GAME_STATE,REPORT);
  List_Defered(Machine(Battle))==(?);
  List_Sets(Machine(Battle))==(PLAYERS,GAME_STATE,REPORT);
  Set_Definition(Machine(Battle),GAME_STATE)==({ongoing,Player1Wins,Player2Wins,setup});
  Set_Definition(Machine(Battle),REPORT)==({success,hit,miss,Player_1_deployed_successfully,Already_Full_Position,Player_2_deployed_successfully,error,Player_1_Win,Player_1_has_made_a_hit,Player_2_Win,Player_2_has_made_a_hit})
END
&
THEORY ListHiddenConstantsX IS
  Abstract_List_HiddenConstants(Machine(Battle))==(?);
  Expanded_List_HiddenConstants(Machine(Battle))==(?);
  List_HiddenConstants(Machine(Battle))==(?);
  External_List_HiddenConstants(Machine(Battle))==(?)
END
&
THEORY ListPropertiesX IS
  Abstract_List_Properties(Machine(Battle))==(btrue);
  Context_List_Properties(Machine(Battle))==(btrue);
  Inherited_List_Properties(Machine(Battle))==(btrue);
  List_Properties(Machine(Battle))==(FLEET_SIZE = 3 & GRID_POSITIONS = (1..5)*(1..5) & PLAYERS: FIN(INTEGER) & not(PLAYERS = {}) & GAME_STATE: FIN(INTEGER) & not(GAME_STATE = {}) & REPORT: FIN(INTEGER) & not(REPORT = {}))
END
&
THEORY ListSeenInfoX END
&
THEORY ListANYVarX IS
  List_ANY_Var(Machine(Battle),deployFleet)==(?);
  List_ANY_Var(Machine(Battle),playerShoots)==(?);
  List_ANY_Var(Machine(Battle),shipLocations)==(?);
  List_ANY_Var(Machine(Battle),shipsLeft)==(?);
  List_ANY_Var(Machine(Battle),shotsTaken)==(?);
  List_ANY_Var(Machine(Battle),gameStatus)==(?)
END
&
THEORY ListOfIdsX IS
  List_Of_Ids(Machine(Battle)) == (FLEET_SIZE,GRID_POSITIONS,PLAYERS,GAME_STATE,REPORT,Player1,Player2,ongoing,Player1Wins,Player2Wins,setup,success,hit,miss,Player_1_deployed_successfully,Already_Full_Position,Player_2_deployed_successfully,error,Player_1_Win,Player_1_has_made_a_hit,Player_2_Win,Player_2_has_made_a_hit | ? | game_state,shots_taken,current_turn,player2_fleet,player1_fleet | ? | deployFleet,playerShoots,shipLocations,shipsLeft,shotsTaken,gameStatus | ? | ? | ? | Battle);
  List_Of_HiddenCst_Ids(Machine(Battle)) == (? | ?);
  List_Of_VisibleCst_Ids(Machine(Battle)) == (FLEET_SIZE,GRID_POSITIONS);
  List_Of_VisibleVar_Ids(Machine(Battle)) == (? | ?);
  List_Of_Ids_SeenBNU(Machine(Battle)) == (?: ?)
END
&
THEORY SetsEnvX IS
  Sets(Machine(Battle)) == (Type(PLAYERS) == Cst(SetOf(etype(PLAYERS,0,1)));Type(GAME_STATE) == Cst(SetOf(etype(GAME_STATE,0,3)));Type(REPORT) == Cst(SetOf(etype(REPORT,0,10))))
END
&
THEORY ConstantsEnvX IS
  Constants(Machine(Battle)) == (Type(Player1) == Cst(etype(PLAYERS,0,1));Type(Player2) == Cst(etype(PLAYERS,0,1));Type(ongoing) == Cst(etype(GAME_STATE,0,3));Type(Player1Wins) == Cst(etype(GAME_STATE,0,3));Type(Player2Wins) == Cst(etype(GAME_STATE,0,3));Type(setup) == Cst(etype(GAME_STATE,0,3));Type(success) == Cst(etype(REPORT,0,10));Type(hit) == Cst(etype(REPORT,0,10));Type(miss) == Cst(etype(REPORT,0,10));Type(Player_1_deployed_successfully) == Cst(etype(REPORT,0,10));Type(Already_Full_Position) == Cst(etype(REPORT,0,10));Type(Player_2_deployed_successfully) == Cst(etype(REPORT,0,10));Type(error) == Cst(etype(REPORT,0,10));Type(Player_1_Win) == Cst(etype(REPORT,0,10));Type(Player_1_has_made_a_hit) == Cst(etype(REPORT,0,10));Type(Player_2_Win) == Cst(etype(REPORT,0,10));Type(Player_2_has_made_a_hit) == Cst(etype(REPORT,0,10));Type(FLEET_SIZE) == Cst(btype(INTEGER,?,?));Type(GRID_POSITIONS) == Cst(SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?))))
END
&
THEORY VariablesEnvX IS
  Variables(Machine(Battle)) == (Type(game_state) == Mvl(etype(GAME_STATE,?,?));Type(shots_taken) == Mvl(SetOf(etype(PLAYERS,0,1)*btype(INTEGER,0,MAXINT)));Type(current_turn) == Mvl(etype(PLAYERS,?,?));Type(player2_fleet) == Mvl(SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?)));Type(player1_fleet) == Mvl(SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?))))
END
&
THEORY OperationsEnvX IS
  Operations(Machine(Battle)) == (Type(gameStatus) == Cst(etype(GAME_STATE,?,?),No_type);Type(shotsTaken) == Cst(btype(INTEGER,?,?),etype(PLAYERS,?,?));Type(shipsLeft) == Cst(SetOf(etype(PLAYERS,?,?)*btype(INTEGER,?,?)),No_type);Type(shipLocations) == Cst(SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?)),etype(PLAYERS,?,?));Type(playerShoots) == Cst(etype(REPORT,?,?),btype(INTEGER,?,?)*btype(INTEGER,?,?));Type(deployFleet) == Cst(etype(REPORT,?,?),etype(PLAYERS,?,?)*SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?))));
  Observers(Machine(Battle)) == (Type(gameStatus) == Cst(etype(GAME_STATE,?,?),No_type);Type(shotsTaken) == Cst(btype(INTEGER,?,?),etype(PLAYERS,?,?));Type(shipsLeft) == Cst(SetOf(etype(PLAYERS,?,?)*btype(INTEGER,?,?)),No_type);Type(shipLocations) == Cst(SetOf(btype(INTEGER,?,?)*btype(INTEGER,?,?)),etype(PLAYERS,?,?)))
END
&
THEORY TCIntRdX IS
  predB0 == OK;
  extended_sees == KO;
  B0check_tab == KO;
  local_op == OK;
  abstract_constants_visible_in_values == KO;
  project_type == SOFTWARE_TYPE;
  event_b_deadlockfreeness == KO;
  variant_clause_mandatory == KO;
  event_b_coverage == KO;
  event_b_exclusivity == KO;
  genFeasibilityPO == KO
END
)
