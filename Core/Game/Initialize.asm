
                        ifndef _CORE_GAME_INITIALIZE_
                        define _CORE_GAME_INITIALIZE_

Initialize:             ; загрузим карту
                        CALL LoadMap

                        ; инициализация переменных
                        SetAllHardwareFlags                     ;
                        ; ResetHardwareFlag KEMPSTON_JOY_BUTTON_3               ; включить джойстик SEGA
                        ; ResetHardwareFlag KEYBOARD_WASD_QAOP                  ; включить WASD управление
                        CALL ChangeKeyboardLayout
                        SetAllFrameFlags                                        ; настройка флагов отрисовки
                        ; ResetFrameFlag DELAY_RENDER_FLAG
                        SetAllGameplayFlags                                     ; настройка игровых флагов
                        SetAllInputFlags                                        ; настройка инпута флагов
                        ; ResetGameplayFlag GAME_PAUSE_MENU_FLAG
                        SetAllTilemapFlags                                      ; настройки флагов тайловой карты
                        SetAllAIFlags                                           ; настройка ИИ флагов
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
                        ; CALL Tilemap.Initialize
                        CALL Utils.Waypoint.Init                                ; initialize array waypoints
                        CALL Utils.WaypointsSequencer.Init                      ; initialize bitmap waypoints
                        CALL Handlers.Input.Initialize
                        CALL Tilemap.SafePrepare
                        
                        ; initialize music
                        ifdef ENABLE_MUSIC

                        ; toggle to memory page with tile sprites
                        CALL Memory.SetPage3
                        LD A, R
                        RRA
                        LD HL, #D11B
                        JR C, $+5
                        LD HL, #C86E
                        CALL #C003

                        endif

                        ; claer screen
                        ifdef ENABLE_CLS
                        CALL Memory.SetPage7
                        CLS_4000
                        CLS_C000
                        endif

                        ; initialize background
                        CALL NextDay

                        ifdef ENABLE_FILL_FOW
                        CALL Tilemap.FillFog
                        CALL AI.Behavior
                        CALL Tilemap.Prepare
                        ResetFrameFlag FORCE_FOW_FLAG
                        endif

                        ifdef ENABLE_DEBUG_NETWORK
                        LD HL, UART.BR_115200
                        CALL UART.Init
                        endif

                        RET

HardwareRestriction:

.Mouse                  ; kempston mouse detected
                        ResetHardwareFlag KEMPSTON_MOUSE_FLAG
                        RET
ChangeKeyboardLayout:   ; 
                        CheckHardwareFlag KEYBOARD_WASD_QAOP
                        LD DE, (VK_S << 8) | VK_W
                        LD BC, (VK_D << 8) | VK_A
                        JR Z, $+8
                        LD DE, (VK_A << 8) | VK_Q
                        LD BC, (VK_P << 8) | VK_O

                        LD HL, VirtualKeysRef
                        LD (HL), E                                              ; Up
                        INC HL
                        LD (HL), D                                              ; Down
                        INC HL
                        LD (HL), C                                              ; Left
                        INC HL
                        LD (HL), B                                              ; Right
                        RET

                        endif ; ~_CORE_GAME_INITIALIZE_
