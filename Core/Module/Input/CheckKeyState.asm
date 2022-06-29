
                    ifndef _INPUT_CHECK_KEY_STATE_
                    define _INPUT_CHECK_KEY_STATE_

; -----------------------------------------
; проверить состояние виртуальной клавиши
; In :
;   A  - virtual code
; Out :
;   флаг Z сброшен, если кнопка отжата
; Corrupt :
;   BC, AF
; -----------------------------------------
CheckKeyState:      PUSH HL
                    LD HL, .RET
                    LD (.VK), A
                    OR A
                    JP M, Mouse.CheckKeyState
                    JP P, .IsJoystick
.VK                 EQU $+1
.RET                LD A, #00
                    POP HL
                    RET

.IsJoystick         BIT VK_KEMPSTON, A
                    JP Z, Keyboard.CheckKeyState
                    JP Kempston.CheckKeyState

                    endif ; ~_INPUT_CHECK_KEY_STATE_