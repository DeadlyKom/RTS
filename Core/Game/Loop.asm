
                ifndef _CORE_GAME_LOOP_
                define _CORE_GAME_LOOP_
GameLoop:       ; initialize
                ResetAllFrameFlags
                SetFrameFlag SWAP_SCREENS_FLAG

                ; add unit
                SeMemoryPage MemoryPage_Tilemap
                LD BC, #0306
                CALL Spawn.Unit
                LD BC, #0C10
                CALL Spawn.Unit
                LD BC, #0608
                CALL Spawn.Unit
                LD BC, #030A
                CALL Spawn.Unit
                LD BC, #0A08
                CALL Spawn.Unit
                LD BC, #0909
                CALL Spawn.Unit
                
.MainLoop       BEGIN_DEBUG_BORDER_DEF

                CheckFrameFlag SWAP_SCREENS_FLAG
                JR NZ, .Logic

.Render         ; ************ RENDER ************      

                ; toggle to memory page with tile sprites
                SeMemoryPage MemoryPage_ShadowScreen
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
                SeMemoryPage MemoryPage_ShadowScreen
                
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

                ; ~ LOGIC

                JP .MainLoop

                endif ; ~_CORE_GAME_LOOP_
