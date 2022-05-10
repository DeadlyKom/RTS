
                ifndef _CORE_GAME_LOOP_
                define _CORE_GAME_LOOP_

GameLoop:
                ; JR$
                ; CALL Utils.ChunkArray.Init
                ; LD DE, #0000
                ; CALL Utils.ChunkArray.Insert

                ; add unit
                SET_PAGE_UNITS_ARRAY

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

                LD A, 8
                LD HL, .Array

.LoopSpawn      PUSH AF

                LD C, (HL)
                INC HL
                LD B, (HL)
                INC HL
                LD E, (HL)
                INC HL

                PUSH HL

                LD D, FUSE_RECONNAISSANCE
                CALL Spawn.Unit
                JR .Next

;                 LD A, E
;                 EX AF, AF'
;                 LD D, FUSE_RECONNAISSANCE | FUSF_RENDER
;                 CALL Spawn.Unit
;                 EX AF, AF'
                
;                 CP #FF
;                 JR NZ, .SetIndex
    
;                 CALL Utils.Math.Rand8
;                 OR A
;                 JR Z, $+3
;                 INC A
;                 AND %00000111
; .SetIndex       ADD A, FUTF_VALID_IDX | FUTF_INSERT | FUTF_LOOP
;                 LD C, A
;                 CALL Utils.WaypointsSequencer.AddUnit.UnitAddressToIX

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
                CALL Z, AI.Behavior

                ifdef ENABLE_BEHAVIOR_TREE_STATE
                CheckDebugFlag DRAW_DEBUG_BT_FLAG
                CALL Z, Debug.DrawStateBT
                endif
                
                JP .MainLoop

.Array          

                DW #0906    : DB PLAYER_FACTION | COMPOSITE_UNIT | Tank        ; 0
                DW #0A05    : DB PLAYER_FACTION | COMPOSITE_UNIT | Tank        ; 0
                ; ; DW #0409    : DB PLAYER_FACTION | Infantry    ; 0
                ; DW #080A    : DB ENEMY_FACTION_A   | COMPOSITE_UNIT | Tank        ; 0


                ; DW #0409    : DB PLAYER_FACTION | Infantry    ; 0
                ; DW #0508    : DB PLAYER_FACTION | Infantry    ; 0
                ; DW #0607    : DB PLAYER_FACTION | Infantry    ; 0
                ; DW #0708    : DB PLAYER_FACTION | Infantry    ; 0
                ; DW #0807    : DB PLAYER_FACTION | Infantry    ; 0
                ; DW #090A    : DB PLAYER_FACTION | Infantry    ; 0
                
                ; DW #1217    : DB PLAYER_FACTION | Infantry    ; 0
                ; DW #1317    : DB PLAYER_FACTION | Infantry    ; 0
                ; DW #1417    : DB PLAYER_FACTION | Infantry    ; 0
                ; DW #1517    : DB PLAYER_FACTION | Infantry    ; 0
                ; DW #1617    : DB PLAYER_FACTION | Infantry    ; 0
                ; DW #1717    : DB PLAYER_FACTION | Infantry    ; 0

                DW #0714    : DB ENEMY_FACTION_A   | Infantry    ; 1
                DW #0813    : DB ENEMY_FACTION_A   | Infantry    ; 1
                DW #0815    : DB ENEMY_FACTION_A   | Infantry    ; 1
                DW #0912    : DB ENEMY_FACTION_A   | Infantry    ; 1
                DW #0913    : DB ENEMY_FACTION_A   | Infantry    ; 1
                DW #0A12    : DB ENEMY_FACTION_A   | Infantry    ; 1

                DW #0202    : DB #00    ; 1
                DW #1517    : DB #00    ; 2
                DW #1520    : DB #00    ; 3
                DW #1E20    : DB #00    ; 4
                DW #1E17    : DB #00    ; 5
                DW #1816    : DB #00    ; 6

                DW #1719    : DB #00    ; 7
                DW #171A    : DB #00    ; 8
                DW #171B    : DB #00    ; 9
                DW #171C    : DB #00    ; 10
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

                DW #121A    : DB #FF    ; 61
                DW #102A    : DB #FF    ; 62
                DW #0A0B    : DB #FF    ; 63
                DW #070C    : DB #FF    ; 64
                DW #170D    : DB #FF    ; 65
                DW #070E    : DB #FF    ; 66
                DW #0809    : DB #FF    ; 67
                DW #0810    : DB #FF    ; 68
                DW #102B    : DB #FF    ; 69
                DW #1F0C    : DB #FF    ; 70
                DW #282D    : DB #FF    ; 71
                DW #282F    : DB #FF    ; 72
                DW #2929    : DB #FF    ; 73
                DW #092A    : DB #FF    ; 74
                DW #292B    : DB #FF    ; 75
                DW #292C    : DB #FF    ; 76
                DW #092D    : DB #FF    ; 77
                DW #100E    : DB #FF    ; 78
                DW #1F1F    : DB #FF    ; 79
                DW #2A2A    : DB #FF    ; 80
                DW #3A2B    : DB #FF    ; 81
                DW #3A3C    : DB #FF    ; 82
                DW #2A3D    : DB #FF    ; 83
                DW #2A0E    : DB #FF    ; 84
                DW #3B29    : DB #FF    ; 85
                DW #3B2A    : DB #FF    ; 86
                DW #3B3B    : DB #FF    ; 87
                DW #2B3C    : DB #FF    ; 88
                DW #3B3D    : DB #FF    ; 89
                DW #3B2E    : DB #FF    ; 90
                DW #3C29    : DB #FF    ; 91
                DW #2C0A    : DB #FF    ; 92
                DW #3C3B    : DB #FF    ; 93
                DW #3C0C    : DB #FF    ; 94
                DW #0C0D    : DB #FF    ; 95
                DW #2C0E    : DB #FF    ; 96
                DW #3335    : DB #FF    ; 97
                DW #3732    : DB #FF    ; 98
                DW #2D3B    : DB #FF    ; 99
                DW #0D3C    : DB #FF    ; 100
                DW #2D3D    : DB #FF    ; 101
                DW #2D3E    : DB #FF    ; 102
                DW #2E2C    : DB #FF    ; 103
                DW #2E3C    : DB #FF    ; 104
                DW #323C    : DB #FF    ; 105
                DW #231C    : DB #FF    ; 106
                DW #353C    : DB #FF    ; 107
                DW #362C    : DB #FF    ; 108
                DW #051C    : DB #FF    ; 109
                DW #163C    : DB #FF    ; 110
                DW #2E12    : DB #FF    ; 111
                DW #2E15    : DB #FF    ; 112
                DW #1E31    : DB #FF    ; 113
                DW #1E04    : DB #FF    ; 114
                DW #2E0C    : DB #FF    ; 115
                DW #3F0F    : DB #FF    ; 116

                endif ; ~_CORE_GAME_LOOP_
