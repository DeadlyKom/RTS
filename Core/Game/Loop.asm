
                ifndef _CORE_GAME_LOOP_
                define _CORE_GAME_LOOP_
GameLoop:       
                ; add unit
                CALL Memory.SetPage1                       ; SeMemoryPage MemoryPage_Tilemap, DRAFT_INIT_ID

                ; JR $

                ;
                CALL Utils.WaypointsSequencer.Create
                JR C, $

                ; 1
                LD DE, #1517
                CALL Utils.WaypointsSequencer.AddWaypoint
                JR NC, $
                ; 2
                LD DE, #1520
                CALL Utils.WaypointsSequencer.AddWaypoint
                JR NC, $
                ; 3
                LD DE, #1E20
                CALL Utils.WaypointsSequencer.AddWaypoint
                JR NC, $
                ; 4
                LD DE, #1E17
                CALL Utils.WaypointsSequencer.AddWaypoint
                JR NC, $
                ; 5
                LD DE, #1914
                CALL Utils.WaypointsSequencer.AddWaypoint
                JR NC, $
                ; 6
                LD DE, #1816
                CALL Utils.WaypointsSequencer.AddWaypoint
                JR NC, $

                ; JR$

                LD A, 60
                LD HL, .Array

.LoopSpawn      PUSH AF

                LD C, (HL)
                INC HL
                LD B, (HL)
                INC HL
                LD A, (HL)
                INC HL

                PUSH HL

                OR A
                JR NZ, $+7
                CALL Spawn.Unit
                JR .Next

                EX AF, AF' 
                CALL Spawn.Unit
                EX AF, AF'

                CP #FF
                JR NZ, .SetIndex
    
                CALL Utils.Math.Rand8
                OR A
                JR Z, $+3
                INC A
                AND %00000111
.SetIndex       ADD A, FUTF_VALID_IDX | FUTF_INSERT | FUTF_LOOP
                LD C, A
                LD A, IXL
                CALL Utils.WaypointsSequencer.AddUnit

.Next           POP HL
                POP AF
                DEC A
                JR NZ, .LoopSpawn

.MainLoop       BEGIN_DEBUG_BORDER_DEF
                
.PauseMenuGame  ; ******* PAUSE MENU GAME *******
                CheckGameplayFlag SHOW_PAUSE_MENU_GAME_FLAG                     ; пропустим если активирована пауза игры
                JR Z, .MainLoop
                ; ~ PAUSE MENU GAME

.PathFinding    ; ********* PATH FINDING *********
                CheckGameplayFlag PATHFINDING_FLAG
                CALL Z, Pathfinding.Begin
                ; ~ PATH FINDING

.RenderBegin    CheckFrameFlag SWAP_SCREENS_FLAG
                JR Z, .MainLoop

.Render         ; ************ RENDER ************

                ; toggle to memory page with tile sprites
                CALL Memory.SetPage7
                SetFrameFlag RENDER_FINISHED

.Tilemap        ; ************ TILEMAP ************
                ; show debug border
                ifdef SHOW_DEBUG_BORDER_TILEMAP
                BEGIN_DEBUG_BORDER_COL RENDER_TILEMAP_COLOR
                endif

                CALL Tilemap.Display

                ; ~ TILEMAP

.Unit           ; ********** DRAW UNITS ***********
                ; show debug border
                ifdef SHOW_DEBUG_BORDER_DRAW_UNITS
                BEGIN_DEBUG_BORDER_COL RENDER_UNITS_COLOR
                endif

                CALL Unit.Handler

                ; ~ DRAW UNITS

                ; ---------------------------------
                ; toggle to memory page with tile sprites
                CALL Memory.SetPage7
                
.FOW            ; ************** FOW **************
                ifdef ENABLE_FOW
                ; show debug border
                ifdef SHOW_DEBUG_BORDER_FOW
                BEGIN_DEBUG_BORDER_COL RENDER_FOW_COLOR
                endif
                
                CALL Tilemap.FOW

                endif
                ; ~ FOW

.SelectionRect  ; ******** SELECTION RECT *********
                CheckInputFlag SELECTION_RECT_FLAG
                CALL Z, DrawRectangle
                ; ~ SELECTION RECT

.CompliteFlags  ; ************* FLAGS *************
                CheckGameplayFlag PATHFINDING_FLAG                              ; пропустим если необходимо посчитать путь
                JR Z, .Logic
                CheckGameplayFlag SHOW_PAUSE_MENU_GAME_FLAG                     ; пропустим если активирована пауза игры
                JR Z, .Logic
                ; CheckFrameFlag DELAY_RENDER_FLAG
                ; JR Z, .Logic
                ResetFrameFlag SWAP_SCREENS_FLAG
                ; ~ FLAGS

                ; ~ RENDER

.Logic          ; ************* LOGIC *************
                ; show debug border
                ifdef SHOW_DEBUG_BORDER_DRAFT_LOGIC
                BEGIN_DEBUG_BORDER_COL DRAFT_LOGIC_COLOR
                endif

                CheckAIFlag (AI_UPDATE_FLAG | GAME_PAUSE_FLAG)
                CALL Z, AI.Handler
                
                JP .MainLoop

.Array          
                DW #0202    : DB #00    ; 1
                DW #1517    : DB #06    ; 2
                DW #1520    : DB #05    ; 3
                DW #1E20    : DB #04    ; 4
                DW #1E17    : DB #03    ; 5
                DW #1816    : DB #02    ; 6

                DW #1719    : DB #FF    ; 7
                DW #171A    : DB #FF    ; 8
                DW #171B    : DB #FF    ; 9
                DW #171C    : DB #FF    ; 10
                DW #171D    : DB #FF    ; 11
                DW #171E    : DB #FF    ; 12
                DW #1819    : DB #FF    ; 13
                DW #181A    : DB #FF    ; 14
                DW #181B    : DB #FF    ; 15
                DW #181C    : DB #FF    ; 16
                DW #181D    : DB #FF    ; 17
                DW #181E    : DB #FF    ; 18
                DW #1919    : DB #FF    ; 19
                DW #191A    : DB #FF    ; 20
                DW #191B    : DB #FF    ; 21
                DW #191C    : DB #FF    ; 22
                DW #191D    : DB #FF    ; 23
                DW #191E    : DB #FF    ; 24
                DW #1A19    : DB #FF    ; 25
                DW #1A1A    : DB #FF    ; 26
                DW #1A1B    : DB #FF    ; 27
                DW #1A1C    : DB #FF    ; 28
                DW #1A1D    : DB #FF    ; 29
                DW #1A1E    : DB #FF    ; 30
                DW #1B19    : DB #FF    ; 31
                DW #1B1A    : DB #FF    ; 32
                DW #1B1B    : DB #FF    ; 33
                DW #1B1C    : DB #FF    ; 34
                DW #1B1D    : DB #FF    ; 35
                DW #1B1E    : DB #FF    ; 36
                DW #1C19    : DB #FF    ; 37
                DW #1C1A    : DB #FF    ; 38
                DW #1C1B    : DB #FF    ; 39
                DW #1C1C    : DB #FF    ; 40
                DW #1C1D    : DB #FF    ; 41
                DW #1C1E    : DB #FF    ; 42
                DW #1315    : DB #FF    ; 43
                DW #1722    : DB #FF    ; 44
                DW #1D1B    : DB #FF    ; 45
                DW #1D1C    : DB #FF    ; 46
                DW #1D1D    : DB #FF    ; 47
                DW #1D1E    : DB #FF    ; 48
                DW #2E1C    : DB #FF    ; 49
                DW #1E1C    : DB #FF    ; 50
                DW #321C    : DB #FF    ; 51
                DW #331C    : DB #FF    ; 52
                DW #351C    : DB #FF    ; 53
                DW #361C    : DB #FF    ; 54
                DW #251C    : DB #FF    ; 55
                DW #261C    : DB #FF    ; 56
                DW #3E10    : DB #FF    ; 57
                DW #3E15    : DB #FF    ; 58
                DW #2E11    : DB #FF    ; 59
                DW #1E0C    : DB #FF    ; 60

                endif ; ~_CORE_GAME_LOOP_
