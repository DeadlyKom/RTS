    
                ifndef _MODULE_INPUT_
                define _MODULE_INPUT_
; -----------------------------------------
; In :
;   A  - virtual code
;   HL - address key last state
;   DE - address key handlerKey
; Out :
;   if the specified key is pressed/released jump yo handler
;   if flag Z is reset, the button is released, otherwise it is pressed
; Corrupt :
;   HL, DE, BC, AF, AF'
; -----------------------------------------
JumpHandlerKey:     CALL Input.CheckKeyState
                    LD A, (HL)
                    JR NZ, .IsReleased
                    OR A
                    JR NZ, .NotProcessed
                    INC (HL)
                    EX DE, HL
                    JP (HL)                             ; pressed
.IsReleased         OR A
                    JR Z, .NotProcessed
                    DEC (HL)
                    EX DE, HL
                    JP (HL)                             ; released
.NotProcessed       SCF
                    RET
; -----------------------------------------
; jump to hendler keys
; In :
;   HL  - address key last state
;   DE' - address array VK
;   B'  - count array keys VK
; Out :
;   if the specified key is pressed/released jump yo handler
;   if flag Z is reset, the button is released, otherwise it is pressed
;   if the handler is processing should return a reset Carry flag
;   C - value
; Corrupt :
;   HL, DE, BC, AF, AF'
; -----------------------------------------
JumpHandlerKeys:    ;
.Loop               LD A, (DE)
                    INC DE
                    EX AF, AF'
                    LD A, (DE)
                    INC DE
                    EXX
                    LD C, A
                    EX AF, AF'
                    PUSH HL
                    PUSH DE
                    CALL JumpHandlerKey
                    POP DE
                    POP HL
                    RET NC
                    INC HL
                    EXX
                    DJNZ .Loop
                    RET
; -----------------------------------------
; обработчик нажатия клавиш по умолчанию
; In :
;   DE - address key handlerKey
; Out :
;   if the specified key is pressed/released jump yo handler
;   if flag Z is reset, the button is released, otherwise it is pressed
;   if the handler is processing should return a reset Carry flag
;   C - value
; Corrupt :
;   HL, DE, BC, AF, AF'
; -----------------------------------------
JumpDefaulKeys: LD HL, .KeyLastState
                EXX
                LD DE, .ArrayVKNum
                LD B, .Num
                JP JumpHandlerKeys
.KeyLastState   DS 5, 0
.ArrayVKNum     DB VK_W,     DEFAULT_UP                                         ; KeyUp     - клавиша по умолчанию "Вверх"
                DB VK_A,     DEFAULT_LEFT                                       ; KeyLeft   - клавиша по умолчанию "Влево"
                DB VK_S,     DEFAULT_DOWN                                       ; KeyDown   - клавиша по умолчанию "Вниз"
                DB VK_D,     DEFAULT_RIGHT                                      ; KeyRight  - клавиша по умолчанию "Вправо"
                DB VK_SPACE, DEFAULT_SELECT                                     ; KeySelect - клавиша по умолчанию "Выбор"
.Num            EQU ($-.ArrayVKNum) / 2

                endif ; ~_MODULE_INPUT_
