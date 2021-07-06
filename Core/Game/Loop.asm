
                ifndef _CORE_GAME_LOOP_
                define _CORE_GAME_LOOP_
GameLoop:       

                ; add unit
                SeMemoryPage MemoryPage_Tilemap, DRAFT_INIT_ID
                
                LD BC, #0202
                CALL Spawn.Unit
                ; LD BC, #0204
                ; CALL Spawn.Unit
                ; LD BC, #0206
                ; CALL Spawn.Unit
                ; LD BC, #0208
                ; CALL Spawn.Unit
                ; LD BC, #020A
                ; CALL Spawn.Unit
                ; LD BC, #020C
                ; CALL Spawn.Unit
                ; LD BC, #0402
                ; CALL Spawn.Unit
                ; LD BC, #0404
                ; CALL Spawn.Unit
                ; LD BC, #0406
                ; CALL Spawn.Unit
                ; LD BC, #0408
                ; CALL Spawn.Unit
                ; LD BC, #040A
                ; CALL Spawn.Unit
                ; LD BC, #040C
                ; CALL Spawn.Unit
                ; LD BC, #0602
                ; CALL Spawn.Unit
                ; LD BC, #0604
                ; CALL Spawn.Unit
                ; LD BC, #0606
                ; CALL Spawn.Unit
                ; LD BC, #0608
                ; CALL Spawn.Unit
                ; LD BC, #060A
                ; CALL Spawn.Unit
                ; LD BC, #060C
                ; CALL Spawn.Unit
                ; LD BC, #0802
                ; CALL Spawn.Unit
                ; LD BC, #0804
                ; CALL Spawn.Unit
                ; LD BC, #0806
                ; CALL Spawn.Unit
                ; LD BC, #0808
                ; CALL Spawn.Unit
                ; LD BC, #080A
                ; CALL Spawn.Unit
                ; LD BC, #080C
                ; CALL Spawn.Unit
                ; LD BC, #0A02
                ; CALL Spawn.Unit
                ; LD BC, #0A04
                ; CALL Spawn.Unit
                ; LD BC, #0A06
                ; CALL Spawn.Unit
                ; LD BC, #0A08
                ; CALL Spawn.Unit
                ; LD BC, #0A0A
                ; CALL Spawn.Unit
                ; LD BC, #0A0C
                ; CALL Spawn.Unit

                ; LD BC, #0103
                ; CALL Spawn.Unit
                ; LD BC, #0105
                ; CALL Spawn.Unit
                ; LD BC, #0107
                ; CALL Spawn.Unit
                ; LD BC, #0109
                ; CALL Spawn.Unit
                ; LD BC, #010B
                ; CALL Spawn.Unit
                ; LD BC, #010D
                ; CALL Spawn.Unit
                ; LD BC, #0303
                ; CALL Spawn.Unit
                ; LD BC, #0305
                ; CALL Spawn.Unit
                ; LD BC, #0307
                ; CALL Spawn.Unit
                ; LD BC, #0309
                ; CALL Spawn.Unit
                ; LD BC, #030B
                ; CALL Spawn.Unit
                ; LD BC, #030D
                ; CALL Spawn.Unit
                ; LD BC, #0503
                ; CALL Spawn.Unit
                ; LD BC, #0505
                ; CALL Spawn.Unit
                ; LD BC, #0507
                ; CALL Spawn.Unit
                ; LD BC, #0509
                ; CALL Spawn.Unit
                ; LD BC, #050B
                ; CALL Spawn.Unit
                ; LD BC, #050D
                ; CALL Spawn.Unit
                ; LD BC, #0703
                ; CALL Spawn.Unit
                ; LD BC, #0705
                ; CALL Spawn.Unit
                ; LD BC, #0707
                ; CALL Spawn.Unit
                ; LD BC, #0709
                ; CALL Spawn.Unit
                ; LD BC, #070B
                ; CALL Spawn.Unit
                ; LD BC, #070D
                ; CALL Spawn.Unit
                ; LD BC, #0903
                ; CALL Spawn.Unit
                ; LD BC, #0905
                ; CALL Spawn.Unit
                ; LD BC, #0907
                ; CALL Spawn.Unit
                ; LD BC, #0909
                ; CALL Spawn.Unit
                ; LD BC, #090B
                ; CALL Spawn.Unit
                ; LD BC, #090D
                ; CALL Spawn.Unit

.MainLoop       BEGIN_DEBUG_BORDER_DEF
                
                CheckGamePlayFlag PATHFINDING_FLAG
                CALL Z, Test

                CheckFrameFlag SWAP_SCREENS_FLAG; | DELAY_RENDER_FLAG
                JR Z, .MainLoop

.Render         ; ************ RENDER ************      

                ; toggle to memory page with tile sprites
                SeMemoryPage MemoryPage_ShadowScreen, RENDER_BEGIN_ID
                SetFrameFlag ALLOW_MOVE_TILEMAP

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
                SeMemoryPage MemoryPage_ShadowScreen, RENDER_FOW_BEGIN_ID
                
.FOW            ; ************** FOW **************
                ifdef ENABLE_FOW
                ; show debug border
                ifdef SHOW_DEBUG_BORDER_FOW
                BEGIN_DEBUG_BORDER_COL RENDER_FOW_COLOR
                endif
                
                CALL Tilemap.FOW

                endif
                ; ~ FOW

.CompliteFlags  ; ************* FLAGS *************
                ResetFrameFlag SWAP_SCREENS_FLAG
                ; ~ FLAGS

                ; ~ RENDER

.Logic          ; ************* LOGIC *************
                ; show debug border
                ifdef SHOW_DEBUG_BORDER_DRAFT_LOGIC
                BEGIN_DEBUG_BORDER_COL DRAFT_LOGIC_COLOR
                endif

                CheckAIFlag AI_UPDATE_FLAG | GAME_PAUSE_FLAG
                CALL Z, AI.Handler
                
                JP .MainLoop
Test            JR $
                endif ; ~_CORE_GAME_LOOP_
