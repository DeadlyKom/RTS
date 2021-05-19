
                ifndef _CORE_GAME_LOOP_
                define _CORE_GAME_LOOP_
GameLoop:       ;
                ResetAllFrameFlags
                SetFrameFlag RENDER_ALL_FLAGS

.MainLoop       ;
                ifdef SHOW_DEBUG_BORDER
                LD A, DEFAULT_COLOR
                OUT (#FE), A
                endif

                ;
                CheckFrameFlag RENDER_ALL_FLAGS
                JR Z, .SomeWork

                ; ------------------------------ RENDER ------------------------------

                ; toggle to memory page with tile sprites
                SeMemoryPage MemoryPage_TilSprites

                ;
                CheckFrameFlag RENDER_TILEMAP_FLAG
                CALL NZ, Tilemap.Display
                
                ;
                CheckFrameFlag RENDER_FOW_FLAG
                CALL NZ, Tilemap.FOW

                ;
                SetFrameFlag RENDERED_FLAG
                ResetFrameFlag RENDER_ALL_FLAGS

                ; ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ RENDER ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

.SomeWork       ;
                ifdef SHOW_DEBUG_BORDER
                LD A, DEFAULT_COLOR
                OUT (#FE), A
                endif

                JR .MainLoop

                endif ; ~_CORE_GAME_LOOP_
