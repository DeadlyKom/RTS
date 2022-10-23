
                ifndef _MODULE_GAME_INITIALIZE_INPUT_
                define _MODULE_GAME_INITIALIZE_INPUT_
; -----------------------------------------
; инициализация управления
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Input:          ; настройка обработчика ввода
                LD A, (GameConfig.Options)
                AND INPUT_MASK
                CP INPUT_KEYBOARD
                JR Z, Keyboard
                CP INPUT_KEMPSTON
                JR Z, Kempston
                CP INPUT_KEMPSTON_8
                JR Z, Kempston_8

.IsMouse        ; инициализация управление через мышь
                CALL Mouse.Initialize
                LD HL, GameFlags.Hardware
                JR NC, Mouse                                                    ; переход, если инициализация мыши прошла успешно

                ; ошибка инициализации мыши, переключение на клавиатуру
                SET HW_MOUSE_BIT, (HL)                                          ; установка флага, недоступности кемстон мыши

.SetKeyboard:   ; установка клавиатуры
                LD A, (GameConfig.Options)
                AND INPUT_MASK_INV
                OR INPUT_KEYBOARD
                LD (GameConfig.Options), A
                JR Input

; -----------------------------------------
; инициализация управление клавиатурой
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Keyboard:       ; инициализация клавиш клавиатуры
                LD HL, GameConfig.KeyUp
                LD DE, Input.ArrayKeys

                ; копирование из конфигурации в функцию обработки клавиш
                rept NUMBER_KEYS_ID-1
                LDD
                DEC DE
                endr
                LDD
ResetStateKeys: ; обнуление состояний виртуальных клавиш
                LD H, D
                LD L, E
                DEC DE
                LD (HL), #00
                rept NUMBER_KEYS_ID-1
                LDD
                endr

                RET

; -----------------------------------------
; инициализация управление кемпстон джойстиком + клавиатурой
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Kempston:       JR Keyboard

; -----------------------------------------
; инициализация управление кемпстон джойстиком 8 клавиш
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Kempston_8:     ; инициализация клавиш работы кемпстон джойстика на 8 клавиш
                LD HL, Input.ArrayKeys-8
                LD (HL), VK_KEMPSTON_A                                          ; клавиша "выбор"
                DEC HL
                DEC HL
                LD (HL), VK_KEMPSTON_B                                          ; клавиша "отмена/назад"
                DEC HL
                DEC HL
                LD (HL), VK_KEMPSTON_C                                          ; клавиша "ускорить"
                DEC HL
                DEC HL
                LD (HL), VK_KEMPSTON_START                                      ; клавиша "меню/пауза"
                DEC HL
                EX DE, HL
                JR ResetStateKeys                                               ; обнуление состояний виртуальных клавиш

; -----------------------------------------
; инициализация управление мышью + клавиатура
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Mouse:          ; установка флага, доступности кемстон мыши
                RES HW_MOUSE_BIT, (HL)
                
                ; инициализация клавиш работы мыши и клавиатуры
                LD DE, GameConfig.KeyAcceleration
                LD HL, Input.ArrayKeys-8
                LD (HL), VK_LBUTTON                                             ; клавиша "выбор"
                DEC HL
                DEC HL
                LD (HL), VK_RBUTTON                                             ; клавиша "отмена/назад"
                DEC HL
                DEC HL
                EX DE, HL
                LDD                                                             ; клавиша "ускорить"
                DEC DE
                LDD                                                             ; клавиша "меню/пауза"
                JR ResetStateKeys                                               ; обнуление состояний виртуальных клавиш

                endif ; ~_MODULE_GAME_INITIALIZE_INPUT_
