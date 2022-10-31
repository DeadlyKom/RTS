
                ifndef _CORE_GAME_LOOP_
                define _CORE_GAME_LOOP_

GameLoop:       ; add unit
                SET_PAGE_UNITS_ARRAY                                            ; включить страницу массива юнитов

                ; CALL Utils.ChunkArray.Init
                ; LD A, 1
                ; LD HL, UnitsObjectArrayPtr
                ; LD DE, #0000
                ; CALL Utils.ChunkArray.Insert
                ; LD A, 1
                ; LD HL, UnitsObjectArrayPtr
                ; LD DE, #0001
                ; CALL Utils.ChunkArray.Remove


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
                CALL Z, Jump.AI.Behavior

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

                DW #0202    : DB ENEMY_FACTION_A   | Infantry    ; 1
                DW #1517    : DB ENEMY_FACTION_A   | Infantry    ; 2
                DW #1520    : DB ENEMY_FACTION_A   | Infantry    ; 3
                DW #1E20    : DB ENEMY_FACTION_A   | Infantry    ; 4
                DW #1E17    : DB ENEMY_FACTION_A   | Infantry    ; 5
                DW #1816    : DB ENEMY_FACTION_A   | Infantry    ; 6

                DW #1719    : DB ENEMY_FACTION_A   | Infantry    ; 7
                DW #171A    : DB ENEMY_FACTION_A   | Infantry    ; 8
                DW #171B    : DB ENEMY_FACTION_A   | Infantry    ; 9
                DW #171C    : DB ENEMY_FACTION_A   | Infantry    ; 10
                DW #171D    : DB ENEMY_FACTION_A   | Infantry    ; 11
                DW #171E    : DB ENEMY_FACTION_A   | Infantry    ; 12
                DW #1819    : DB ENEMY_FACTION_A   | Infantry    ; 13
                DW #181A    : DB ENEMY_FACTION_A   | Infantry    ; 14
                DW #181B    : DB ENEMY_FACTION_A   | Infantry    ; 15
                DW #181C    : DB ENEMY_FACTION_A   | Infantry    ; 16
                DW #181D    : DB ENEMY_FACTION_A   | Infantry    ; 17
                DW #181E    : DB ENEMY_FACTION_A   | Infantry    ; 18
                DW #1919    : DB ENEMY_FACTION_A   | Infantry    ; 19
                DW #191A    : DB ENEMY_FACTION_A   | Infantry    ; 20
                DW #191B    : DB ENEMY_FACTION_A   | Infantry    ; 21
                DW #191C    : DB ENEMY_FACTION_A   | Infantry    ; 22
                DW #191D    : DB ENEMY_FACTION_A   | Infantry    ; 23
                DW #191E    : DB ENEMY_FACTION_A   | Infantry    ; 24
                DW #1A19    : DB ENEMY_FACTION_A   | Infantry    ; 25
                DW #1A1A    : DB ENEMY_FACTION_A   | Infantry    ; 26
                DW #1A1B    : DB ENEMY_FACTION_A   | Infantry    ; 27
                DW #1A1C    : DB ENEMY_FACTION_A   | Infantry    ; 28
                DW #1A1D    : DB ENEMY_FACTION_A   | Infantry    ; 29
                DW #1A1E    : DB ENEMY_FACTION_A   | Infantry    ; 30
                DW #1B19    : DB ENEMY_FACTION_A   | Infantry    ; 31
                DW #1B1A    : DB ENEMY_FACTION_A   | Infantry    ; 32
                DW #1B1B    : DB ENEMY_FACTION_A   | Infantry    ; 33
                DW #1B1C    : DB ENEMY_FACTION_A   | Infantry    ; 34
                DW #1B1D    : DB ENEMY_FACTION_A   | Infantry    ; 35
                DW #1B1E    : DB ENEMY_FACTION_A   | Infantry    ; 36
                DW #1C19    : DB ENEMY_FACTION_A   | Infantry    ; 37
                DW #1C1A    : DB ENEMY_FACTION_A   | Infantry    ; 38
                DW #1C1B    : DB ENEMY_FACTION_A   | Infantry    ; 39
                DW #1C1C    : DB ENEMY_FACTION_A   | Infantry    ; 40
                DW #1C1D    : DB ENEMY_FACTION_A   | Infantry    ; 41
                DW #1C1E    : DB ENEMY_FACTION_A   | Infantry    ; 42
                DW #1315    : DB ENEMY_FACTION_A   | Infantry    ; 43
                DW #1722    : DB ENEMY_FACTION_A   | Infantry    ; 44
                DW #1D1B    : DB ENEMY_FACTION_A   | Infantry    ; 45
                DW #1D1C    : DB ENEMY_FACTION_A   | Infantry    ; 46
                DW #1D1D    : DB ENEMY_FACTION_A   | Infantry    ; 47
                DW #1D1E    : DB ENEMY_FACTION_A   | Infantry    ; 48
                DW #2E1C    : DB ENEMY_FACTION_A   | Infantry    ; 49
                DW #1E1C    : DB ENEMY_FACTION_A   | Infantry    ; 50
                DW #321C    : DB ENEMY_FACTION_A   | Infantry    ; 51
                DW #331C    : DB ENEMY_FACTION_A   | Infantry    ; 52
                DW #351C    : DB ENEMY_FACTION_A   | Infantry    ; 53
                DW #361C    : DB ENEMY_FACTION_A   | Infantry    ; 54
                DW #251C    : DB ENEMY_FACTION_A   | Infantry    ; 55
                DW #261C    : DB ENEMY_FACTION_A   | Infantry    ; 56
                DW #3E10    : DB ENEMY_FACTION_A   | Infantry    ; 57
                DW #3E15    : DB ENEMY_FACTION_A   | Infantry    ; 58
                DW #2E11    : DB ENEMY_FACTION_A   | Infantry    ; 59
                DW #1E0C    : DB ENEMY_FACTION_A   | Infantry    ; 60

                DW #121A    : DB ENEMY_FACTION_A   | Infantry    ; 61
                DW #102A    : DB ENEMY_FACTION_A   | Infantry    ; 62
                DW #0A0B    : DB ENEMY_FACTION_A   | Infantry    ; 63
                DW #070C    : DB ENEMY_FACTION_A   | Infantry    ; 64
                DW #170D    : DB ENEMY_FACTION_A   | Infantry    ; 65
                DW #070E    : DB ENEMY_FACTION_A   | Infantry    ; 66
                DW #0809    : DB ENEMY_FACTION_A   | Infantry    ; 67
                DW #0810    : DB ENEMY_FACTION_A   | Infantry    ; 68
                DW #102B    : DB ENEMY_FACTION_A   | Infantry    ; 69
                DW #1F0C    : DB ENEMY_FACTION_A   | Infantry    ; 70
                DW #282D    : DB ENEMY_FACTION_A   | Infantry    ; 71
                DW #282F    : DB ENEMY_FACTION_A   | Infantry    ; 72
                DW #2929    : DB ENEMY_FACTION_A   | Infantry    ; 73
                DW #092A    : DB ENEMY_FACTION_A   | Infantry    ; 74
                DW #292B    : DB ENEMY_FACTION_A   | Infantry    ; 75
                DW #292C    : DB ENEMY_FACTION_A   | Infantry    ; 76
                DW #092D    : DB ENEMY_FACTION_A   | Infantry    ; 77
                DW #100E    : DB ENEMY_FACTION_A   | Infantry    ; 78
                DW #1F1F    : DB ENEMY_FACTION_A   | Infantry    ; 79
                DW #2A2A    : DB ENEMY_FACTION_A   | Infantry    ; 80
                DW #3A2B    : DB ENEMY_FACTION_A   | Infantry    ; 81
                DW #3A3C    : DB ENEMY_FACTION_A   | Infantry    ; 82
                DW #2A3D    : DB ENEMY_FACTION_A   | Infantry    ; 83
                DW #2A0E    : DB ENEMY_FACTION_A   | Infantry    ; 84
                DW #3B29    : DB ENEMY_FACTION_A   | Infantry    ; 85
                DW #3B2A    : DB ENEMY_FACTION_A   | Infantry    ; 86
                DW #3B3B    : DB ENEMY_FACTION_A   | Infantry    ; 87
                DW #2B3C    : DB ENEMY_FACTION_A   | Infantry    ; 88
                DW #3B3D    : DB ENEMY_FACTION_A   | Infantry    ; 89
                DW #3B2E    : DB ENEMY_FACTION_A   | Infantry    ; 90
                DW #3C29    : DB ENEMY_FACTION_A   | Infantry    ; 91
                DW #2C0A    : DB ENEMY_FACTION_A   | Infantry    ; 92
                DW #3C3B    : DB ENEMY_FACTION_A   | Infantry    ; 93
                DW #3C0C    : DB ENEMY_FACTION_A   | Infantry    ; 94
                DW #0C0D    : DB ENEMY_FACTION_A   | Infantry    ; 95
                DW #2C0E    : DB ENEMY_FACTION_A   | Infantry    ; 96
                DW #3335    : DB ENEMY_FACTION_A   | Infantry    ; 97
                DW #3732    : DB ENEMY_FACTION_A   | Infantry    ; 98
                DW #2D3B    : DB ENEMY_FACTION_A   | Infantry    ; 99
                DW #0D3C    : DB ENEMY_FACTION_A   | Infantry    ; 100
                DW #2D3D    : DB ENEMY_FACTION_A   | Infantry    ; 101
                DW #2D3E    : DB ENEMY_FACTION_A   | Infantry    ; 102
                DW #2E2C    : DB ENEMY_FACTION_A   | Infantry    ; 103
                DW #2E3C    : DB ENEMY_FACTION_A   | Infantry    ; 104
                DW #323C    : DB ENEMY_FACTION_A   | Infantry    ; 105
                DW #231C    : DB ENEMY_FACTION_A   | Infantry    ; 106
                DW #353C    : DB ENEMY_FACTION_A   | Infantry    ; 107
                DW #362C    : DB ENEMY_FACTION_A   | Infantry    ; 108
                DW #051C    : DB ENEMY_FACTION_A   | Infantry    ; 109
                DW #163C    : DB ENEMY_FACTION_A   | Infantry    ; 110
                DW #2E12    : DB ENEMY_FACTION_A   | Infantry    ; 111
                DW #2E15    : DB ENEMY_FACTION_A   | Infantry    ; 112
                DW #1E31    : DB ENEMY_FACTION_A   | Infantry    ; 113
                DW #1E04    : DB ENEMY_FACTION_A   | Infantry    ; 114
                DW #2E0C    : DB ENEMY_FACTION_A   | Infantry    ; 115
                DW #3F0F    : DB ENEMY_FACTION_A   | Infantry    ; 116

                endif ; ~_CORE_GAME_LOOP_
