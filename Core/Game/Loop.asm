
                ifndef _CORE_GAME_LOOP_
                define _CORE_GAME_LOOP_
GameLoop:       ; initialize
                ResetAllFrameFlags
                SetFrameFlag SWAP_SCREENS_FLAG

                ; add unit
                SeMemoryPage MemoryPage_Tilemap, DRAFT_INIT_ID
                LD BC, #0F09
                CALL Spawn.Unit
                ; LD BC, #0101
                ; CALL Spawn.Unit
                ; LD BC, #0102
                ; CALL Spawn.Unit
                ; LD BC, #0103
                ; CALL Spawn.Unit
                ; LD BC, #0104
                ; CALL Spawn.Unit
                ; LD BC, #0105
                ; CALL Spawn.Unit
                ; LD BC, #0106
                ; CALL Spawn.Unit
                ; LD BC, #0107
                ; CALL Spawn.Unit
                ; LD BC, #0108
                ; CALL Spawn.Unit
                ; LD BC, #0109
                ; CALL Spawn.Unit
                ; LD BC, #010A
                ; CALL Spawn.Unit
                ; LD BC, #010B
                ; CALL Spawn.Unit
                ; LD BC, #010C
                ; CALL Spawn.Unit
                ; LD BC, #010D
                ; CALL Spawn.Unit
                ; LD BC, #010E
                ; CALL Spawn.Unit
                ; LD BC, #010F
                ; CALL Spawn.Unit
                ; LD BC, #0300
                ; CALL Spawn.Unit
                ; LD BC, #0301
                ; CALL Spawn.Unit
                ; LD BC, #0102
                ; CALL Spawn.Unit
                ; LD BC, #0303
                ; CALL Spawn.Unit
                ; LD BC, #0304
                ; CALL Spawn.Unit
                ; LD BC, #0305
                ; CALL Spawn.Unit
                ; LD BC, #0306
                ; CALL Spawn.Unit
                ; LD BC, #0307
                ; CALL Spawn.Unit
                ; LD BC, #0308
                ; CALL Spawn.Unit
                ; LD BC, #0309
                ; CALL Spawn.Unit
                ; LD BC, #030A
                ; CALL Spawn.Unit
                ; LD BC, #040B
                ; CALL Spawn.Unit
                ; LD BC, #030C
                ; CALL Spawn.Unit
                ; LD BC, #040D
                ; CALL Spawn.Unit
                ; LD BC, #050E
                ; CALL Spawn.Unit
                ; LD BC, #020F
                ; CALL Spawn.Unit
                
                ; ;
                ; LD BC, #0600
                ; CALL Spawn.Unit
                ; LD BC, #0601
                ; CALL Spawn.Unit
                ; LD BC, #0602
                ; CALL Spawn.Unit
                ; LD BC, #0603
                ; CALL Spawn.Unit
                ; LD BC, #0604
                ; CALL Spawn.Unit
                ; LD BC, #0605
                ; CALL Spawn.Unit
                ; LD BC, #0606
                ; CALL Spawn.Unit
                ; LD BC, #0607
                ; CALL Spawn.Unit
                ; LD BC, #0608
                ; CALL Spawn.Unit
                ; LD BC, #0609
                ; CALL Spawn.Unit
                ; LD BC, #060A
                ; CALL Spawn.Unit
                ; LD BC, #060B
                ; CALL Spawn.Unit
                ; LD BC, #060C
                ; CALL Spawn.Unit
                ; LD BC, #060D
                ; CALL Spawn.Unit
                ; LD BC, #060E
                ; CALL Spawn.Unit
                ; LD BC, #060F
                ; CALL Spawn.Unit
                ; LD BC, #0900
                ; CALL Spawn.Unit
                ; LD BC, #0901
                ; CALL Spawn.Unit
                ; LD BC, #0902
                ; CALL Spawn.Unit
                ; LD BC, #0903
                ; CALL Spawn.Unit
                ; LD BC, #0904
                ; CALL Spawn.Unit
                ; LD BC, #0905
                ; CALL Spawn.Unit
                ; LD BC, #0906
                ; CALL Spawn.Unit
                ; LD BC, #0907
                ; CALL Spawn.Unit
                ; LD BC, #0908
                ; CALL Spawn.Unit
                ; LD BC, #0909
                ; CALL Spawn.Unit
                ; LD BC, #090A
                ; CALL Spawn.Unit
                ; LD BC, #090B
                ; CALL Spawn.Unit
                ; LD BC, #090C
                ; CALL Spawn.Unit
                ; LD BC, #090D
                ; CALL Spawn.Unit
                ; LD BC, #090E
                ; CALL Spawn.Unit
                ; LD BC, #090F
                ; CALL Spawn.Unit
                
                
.MainLoop       BEGIN_DEBUG_BORDER_DEF

                CheckFrameFlag SWAP_SCREENS_FLAG
                JR NZ, .Logic

.Render         ; ************ RENDER ************      

                ; toggle to memory page with tile sprites
                SeMemoryPage MemoryPage_ShadowScreen, RENDER_BEGIN_ID
                ResetFrameFlag ALLOW_MOVE_TILEMAP

.Tilemap        ; ************ TILEMAP ************
                ; show debug border
                ifdef SHOW_DEBUG_BORDER_TILEMAP
                BEGIN_DEBUG_BORDER_COL RENDER_TILEMAP_COLOR
                endif

                CALL Tilemap.Display

                ; revert old debug border
                ifdef SHOW_DEBUG_BORDER_TILEMAP
                END_DUBUG_BORDER
                endif
                ; ~ TILEMAP

.Unit           ; ********** DRAW UNITS ***********
                ; show debug border
                ifdef SHOW_DEBUG_BORDER_DRAW_UNITS
                BEGIN_DEBUG_BORDER_COL RENDER_UNITS_COLOR
                endif

                CALL Unit.Handler

                ; revert old debug border
                ifdef SHOW_DEBUG_BORDER_DRAW_UNITS
                END_DUBUG_BORDER
                endif
                ; ~ DRAW UNITS

                ; ---------------------------------
                ; toggle to memory page with tile sprites
                SeMemoryPage MemoryPage_ShadowScreen, RENDER_FOW_BEGIN_ID
                
.FOW            ; ************** FOW **************
                ifdef ENABLE_FOW
                ; show debug border
                ifdef SHOW_DEBUG_BORDER_FOW
                BEGIN_DEBUG_BORDER_COL RENDER_FOW_COLOR
                endif
                
                CALL Tilemap.FOW

                ; revert old debug border
                ifdef SHOW_DEBUG_BORDER_TILEMAP
                END_DUBUG_BORDER
                endif
                endif
                ; ~ FOW

.CompliteFlags  ; ************* FLAGS *************
                SetFrameFlag SWAP_SCREENS_FLAG
                ; ~ FLAGS

                ; ~ RENDER

.Logic          ; ************* LOGIC *************
                END_DUBUG_BORDER

                JP .MainLoop

Test:           LD HL, (TickCounterRef)
                LD A, (.AA)
                XOR L
                RRA
                RRA
                RRA
                ; RRA
                ; RRA
                ; RRA
                JR NC, .Skip

                LD A, L
                LD (.AA), A

                ; JP .MainLoop

                XOR A
                CALL Unit.RefUnitOnScr

                ; включить страницу
                SeMemoryPage MemoryPage_Tilemap, DRAFT_ROTATE_ID
                
                LD HL, MapStructure + FMap.UnitsArray
                LD E, (HL)
                INC L
                LD D, (HL)
                EX DE, HL

                INC L
                
                LD A, (HL)
                ADD A, #08
                AND %00111000
                LD (HL), A
                
.Skip           RET
                ; ~ LOGIC

                ; JP .MainLoop

.AA             DB #00

                endif ; ~_CORE_GAME_LOOP_
