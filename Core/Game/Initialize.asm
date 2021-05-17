
                ifndef _CORE_GAME_INITIALIZE_
                define _CORE_GAME_INITIALIZE_

Initialize:     CALL Tilemap.Initialize
                CALL Handlers.Input.Initialize
                CALL Interrupt.Initialize
                
                ; initialize music
                ifdef ENABLE_MUSIC
                ; toggle to memory page with tile sprites
                SeMemoryPage MemoryPage_Music
                LD A, R
                RRA
                LD HL, #D11B
                JR C, $+5
                LD HL, #C86E
                CALL #C003
                endif

                ; initialize background
                CALL BackgroundFill

                ; EI
                ; HALT
                RET

                endif ; ~_CORE_GAME_INITIALIZE_
