
                        ifndef _CORE_GAME_INITIALIZE_
                        define _CORE_GAME_INITIALIZE_

Initialize:             ; reset all flags
                        ResetAllHardwareFlags

                        ; ToDo при смене порядка (ошибки)
                        CALL Tilemap.Initialize
                        CALL Handlers.Input.Initialize
                        CALL Interrupt.Initialize
                        CALL Tilemap.SafePrepare

                        ; DI
                        ; CALL Tilemap.FillFog
                        ; EI

                        ;
                        ; LD HL, RenderBuffer + 0xC0
                        ; LD DE, WORD_RENDER_ALL_FLAGS
                        ; CALL MEMSET.SafeFill_192
                        
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

                        RET

HardwareRestriction:

.Mouse                  ; kempston mouse detected
                        SetHardwareFlag KEMPSTON_MOUSE
                        RET

                        endif ; ~_CORE_GAME_INITIALIZE_
