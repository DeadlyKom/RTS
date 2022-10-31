
                ifndef _CORE_GAME_MUSIC_
                define _CORE_GAME_MUSIC_

PlayMusic:      ; show debug border
                ifdef SHOW_DEBUG_BORDER_PLAY_MUSIC
                BEGIN_DEBUG_BORDER_COL MUSIC_COLOR
                endif

                ; toggle to memory page with tile sprites
                CALL Memory.SetPage3
                CALL #C005

                RET

                endif ; ~_CORE_GAME_MUSIC_
