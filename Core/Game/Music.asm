
                ifndef _CORE_GAME_MUSIC_
                define _CORE_GAME_MUSIC_

PlayMusic:      ; show debug border
                ifdef SHOW_DEBUG_BORDER
                LD A, MUSIC_COLOR
                OUT (#FE), A
                endif

                ; toggle to memory page with tile sprites
                SeMemoryPage MemoryPage_Music
                CALL #C005

                ; show debug border
                ifdef SHOW_DEBUG_BORDER
                LD A, DEFAULT_COLOR
                OUT (#FE), A
                endif

                RET

                endif ; ~_CORE_GAME_MUSIC_
