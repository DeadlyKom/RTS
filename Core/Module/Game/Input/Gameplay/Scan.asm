
                ifndef _MODULE_GAME_INPUT_GAMEPLAY_SCAN_
                define _MODULE_GAME_INPUT_GAMEPLAY_SCAN_
; -----------------------------------------
; сканирование устроиств ввода
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Scan:           ; опрос виртуальных клавиш
                LD DE, InputHandler
                CALL Input.JumpKeys

                ; проверка необходимости опроса мыши
                LD A, (GameConfig.Options)
                AND INPUT_MASK
                CP INPUT_MOUSE
                RET NZ                                                          ; выход, если мышь не оправшивается

                ; проверка HardWare ограничения мыши
                LD HL, GameFlags.Hardware
                BIT HW_MOUSE_BIT, (HL)
                CALL Z, Mouse.UpdateCursor                                      ; обновить положение курсора, если мышь доступна
                
                RET

                endif ; ~_MODULE_GAME_INPUT_GAMEPLAY_SCAN_
