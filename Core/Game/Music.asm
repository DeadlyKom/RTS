
                ifndef _CORE_GAME_MUSIC_
                define _CORE_GAME_MUSIC_

PlayMusic:      ; show debug border
                ifdef SHOW_DEBUG_BORDER_PLAY_MUSIC
                BEGIN_DEBUG_BORDER_COL MUSIC_COLOR
                endif

                ; toggle to memory page with tile sprites
                SeMemoryPage MemoryPage_Music, MUSIC_PLAY_ID
                CALL #C005

                ; revert old debug border
                ifdef SHOW_DEBUG_BORDER_PLAY_MUSIC
                END_DUBUG_BORDER
                endif

                RET

                endif ; ~_CORE_GAME_MUSIC_
