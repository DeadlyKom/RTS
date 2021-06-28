
                ifndef _CORE_GAME_LOOP_
                define _CORE_GAME_LOOP_
GameLoop:       ; initialize
                ResetAllFrameFlags
                SetFrameFlag SWAP_SCREENS_FLAG

                ; add unit
                SeMemoryPage MemoryPage_Tilemap, DRAFT_INIT_ID
                LD BC, #0204
                CALL Spawn.Unit
                ; LD BC, #0206
                ; CALL Spawn.Unit
                ; LD BC, #0208
                ; CALL Spawn.Unit
                ; LD BC, #020A
                ; CALL Spawn.Unit
                ; LD BC, #0404
                ; CALL Spawn.Unit
                ; LD BC, #0406
                ; CALL Spawn.Unit
                ; LD BC, #0408
                ; CALL Spawn.Unit
                ; LD BC, #040A
                ; CALL Spawn.Unit
                ; LD BC, #0604
                ; CALL Spawn.Unit
                ; LD BC, #0606
                ; CALL Spawn.Unit
                ; LD BC, #0608
                ; CALL Spawn.Unit
                ; LD BC, #060A
                ; CALL Spawn.Unit
                ; LD BC, #0804
                ; CALL Spawn.Unit
                ; LD BC, #0806
                ; CALL Spawn.Unit
                ; LD BC, #0808
                ; CALL Spawn.Unit
                ; LD BC, #080A
                ; CALL Spawn.Unit
                ; LD BC, #0A04
                ; CALL Spawn.Unit
                ; LD BC, #0A06
                ; CALL Spawn.Unit
                ; LD BC, #0A08
                ; CALL Spawn.Unit
                ; LD BC, #0A0A
                ; CALL Spawn.Unit

.MainLoop       BEGIN_DEBUG_BORDER_DEF

                CheckFrameFlag SWAP_SCREENS_FLAG
                JR NZ, .MainLoop

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
                SetFrameFlag SWAP_SCREENS_FLAG
                ; ~ FLAGS

                ; ~ RENDER

.Logic          ; ************* LOGIC *************
                ; show debug border
                ifdef SHOW_DEBUG_BORDER_DRAFT_LOGIC
                BEGIN_DEBUG_BORDER_COL DRAFT_LOGIC_COLOR
                endif

                CheckAIFlag AI_UPDATE_FLAG
                CALL NZ, AI.Handler
                
                JP .MainLoop

                endif ; ~_CORE_GAME_LOOP_
