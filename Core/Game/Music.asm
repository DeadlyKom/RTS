
                ifndef _CORE_GAME_MUSIC_
                define _CORE_GAME_MUSIC_

PlayMusic:      ; toggle to memory page with tile sprites
                SeMemoryPage MemoryPage_Music
                CALL #C005
                RET

                endif ; ~_CORE_GAME_MUSIC_
