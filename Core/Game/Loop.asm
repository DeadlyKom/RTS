
                ifndef _CORE_GAME_LOOP_
                define _CORE_GAME_LOOP_
GameLoop:       ; initialize
                
                ResetAllFrameFlags
                SetFrameFlag SWAP_SCREENS_FLAG
                
.MainLoop       ;
                ifdef SHOW_DEBUG_BORDER
                LD A, DEFAULT_COLOR
                OUT (#FE), A
                endif

                CheckFrameFlag SWAP_SCREENS_FLAG
                JR NZ, .Logic

.Render         ; ************ RENDER ************      

                ; toggle to memory page with tile sprites
                SeMemoryPage MemoryPage_TilSprites
                ResetFrameFlag ALLOW_MOVE_TILEMAP

.Tilemap        ; ************ TILEMAP ************
                ; show debug border
                ifdef SHOW_DEBUG_BORDER_TILEMAP
                LD A, RENDER_TILEMAP_COLOR
                OUT (#FE), A
                endif

                CheckFrameFlag RENDER_TILEMAP_FLAG
                CALL Tilemap.Display
                ; ~ TILEMAP
                
.FOW            ; ************** FOW **************
                ; show debug border
                ifdef SHOW_DEBUG_BORDER_FOW
                LD A, RENDER_FOW_COLOR
                OUT (#FE), A
                endif
                
                CheckFrameFlag RENDER_FOW_FLAG
                CALL Tilemap.FOW
                ; ~ FOW

.CompliteFlags  ; ************* FLAGS *************
                SetFrameFlag SWAP_SCREENS_FLAG
                ; ~ FLAGS

                ; ~ RENDER

.Logic          ; ************* LOGIC *************
                ifdef SHOW_DEBUG_BORDER
                LD A, DEFAULT_COLOR
                OUT (#FE), A
                endif

                ; ~ LOGIC

                JR .MainLoop

                endif ; ~_CORE_GAME_LOOP_
