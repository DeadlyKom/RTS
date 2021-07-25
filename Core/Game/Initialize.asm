
                        ifndef _CORE_GAME_INITIALIZE_
                        define _CORE_GAME_INITIALIZE_

Initialize:             ; initialize
                        SetAllHardwareFlags                     ;
                        ResetHardwareFlag KEMPSTON_JOY_BUTTON_3 ; включить джойстик SEGA
                        ResetHardwareFlag KEYBOARD_WASD_QAOP    ; включить WASD управление
                        SetAllFrameFlags                        ; настройка флагов отрисовки
                        ; ResetFrameFlag DELAY_RENDER_FLAG
                        SetAllGameplayFlags                     ; настройка игровых флагов
                        ; ResetGameplayFlag GAME_PAUSE_MENU_FLAG
                        SetAllTilemapFlags                      ; настройки флагов тайловой карты
                        SetAllAIFlags                           ; настройка ИИ флагов
                        ResetAIFlag GAME_PAUSE_FLAG

                        ; initialize cursor speed
                        LD A, MIN_CURSOR_SPEED
                        LD (MinCursorSpeedRef), A
                        LD A, MAX_CURSOR_SPEED
                        LD (MaxCursorSpeedRef), A
                        CALL Input.Cursor.InitAcceleration

                        ; set default values
                        LD A, AI_MAX_UPDATE_FREQ
                        LD (AI_UpdateFrequencyRef), A

                        CALL Interrupt.Initialize
                        CALL Tilemap.Initialize
                        CALL Utils.Waypoint.Init                ; initialize array waypoints
                        CALL Utils.WaypointsSequencer.Init      ; initialize bitmap waypoints
                        CALL Handlers.Input.Initialize
                        CALL Tilemap.SafePrepare
                        
                        ; initialize music
                        ifdef ENABLE_MUSIC

                        ; toggle to memory page with tile sprites
                        CALL Memory.SetPage3                       ; SeMemoryPage MemoryPage_Music, MUSIC_INIT_ID
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
                        CALL Memory.SetPage7                       ; SeMemoryPage MemoryPage_ShadowScreen, CLS_ID
                        CLS_C000
                        endif

                        ; initialize background
                        CALL BackgroundFill

                        ; CALL Tilemap.FillFog
                        ; CALL Tilemap.Prepare

                        RET

HardwareRestriction:

.Mouse                  ; kempston mouse detected
                        ResetHardwareFlag KEMPSTON_MOUSE_FLAG
                        RET

                        endif ; ~_CORE_GAME_INITIALIZE_
