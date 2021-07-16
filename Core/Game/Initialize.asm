
                        ifndef _CORE_GAME_INITIALIZE_
                        define _CORE_GAME_INITIALIZE_

Initialize:             ; initialize
                        SetAllHardwareFlags                     ;
                        SetAllFrameFlags                        ; настройка флагов отрисовки
                        ; ResetFrameFlag DELAY_RENDER_FLAG
                        SetAllGameplayFlags                     ; настройка игровых флагов
                        SetAllAIFlags                           ; настройка ИИ флагов
                        ResetAIFlag GAME_PAUSE_FLAG

                        ; set default values
                        LD A, AI_MAX_UPDATE_FREQ
                        LD (AI_UpdateFrequencyRef), A

                        CALL Interrupt.Initialize
                        CALL Tilemap.Initialize
                        CALL Handlers.Input.Initialize
                        CALL Tilemap.SafePrepare
                        
                        ; initialize music
                        ifdef ENABLE_MUSIC

                        ; toggle to memory page with tile sprites
                        SeMemoryPage MemoryPage_Music, MUSIC_INIT_ID
                        LD A, R
                        RRA
                        LD HL, #D11B
                        JR C, $+5
                        LD HL, #C86E
                        CALL #C003

                        endif

                        ; claer screen
                        ifdef ENABLE_CLS
                        CLS_4000
                        SeMemoryPage MemoryPage_ShadowScreen, CLS_ID
                        CLS_C000
                        endif

                        ; initialize background
                        CALL BackgroundFill

                        RET

HardwareRestriction:

.Mouse                  ; kempston mouse detected
                        ResetHardwareFlag KEMPSTON_MOUSE_FLAG
                        RET

                        endif ; ~_CORE_GAME_INITIALIZE_
