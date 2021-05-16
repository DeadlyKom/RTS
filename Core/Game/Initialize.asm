
                ifndef _CORE_GAME_INITIALIZE_
                define _CORE_GAME_INITIALIZE_

Initialize:     CALL Tilemap.Initialize
                CALL Mouse.Initialzie
                CALL Interrupt.Initialize
                ; initialize music
                ; toggle to memory page with tile sprites
                SeMemoryPage MemoryPage_Music
                LD A, R
                RRA
                LD HL, #D11B
                JR C, $+5
                LD HL, #C86E
                CALL #C003
                EI

                ; initialize background
                ; CALL MemoryPage_2.BackgroundFill

                RET

                endif ; ~_CORE_GAME_INITIALIZE_
