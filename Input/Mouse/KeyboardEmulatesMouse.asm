
                    ifndef _MOUSE_KEYBOARD_
                    define _MOUSE_KEYBOARD_
MoveLeft:           LD HL, MousePositionX
                    LD A, (NegSpeed)
                    SRA A
                    ADD A, (HL)
                    JR C, SetMouseLocationX                 ; проверка на переполнение (курсор достиг левого края экрана)
                    XOR A                                   ; фиксируем значение
                    ; JR SetMouseLocationX

SetMouseLocationX:  LD (HL), A                              ; изменить значение положение мыши по оси X
                    LD A, #FF
                    LD (MousePositionFlag), A               ; установка флага изменения позиции мыши
                    RET
MoveRight:          LD HL, MousePositionX
                    LD A, (Speed)
                    RRA
                    ADD A, (HL)
                    JR NC, SetMouseLocationX                ; проверка на переполнение (курсор достих правого края экрана)
                    LD A, #FF                               ; фиксируем значение
                    JR SetMouseLocationX

MoveUp:             LD HL, MousePositionY
                    LD A, (NegSpeed)
                    SRA A
                    ADD A, (HL)
                    JR C, SetMouseLocationY                 ; проверка на переполнение (курсор достиг верхнего края экрана)
                    XOR A                                   ; фиксируем значение
                    ; JR SetMouseLocationY
SetMouseLocationY:  LD (HL), A
                    LD A, #FF
                    LD (MousePositionFlag), A
                    RET
MoveDown:           LD HL, MousePositionY
                    LD A, (Speed)
                    RRA
                    ADD A, (HL)
                    JR C, .SetMaxLocationY                  ; проверка на переполнение (курсор достих нижнего края экрана)
                    CP #C0
                    JR C, SetMouseLocationY
.SetMaxLocationY    LD A, #BF                               ; фиксируем значение
                    JR SetMouseLocationY

InitAcceleration:   LD A, (MinCursorSpeedRef)
.Set                LD (Speed), A
                    NEG
                    LD (NegSpeed), A
                    RET
AccelerateCursor:   LD HL, MaxCursorSpeedRef
                    LD A, (Speed)
                    INC A
                    CP (HL)
                    RET NC

                    JR InitAcceleration.Set
DecelerateCursor:   LD HL, MinCursorSpeedRef
                    LD A, (Speed)
                    DEC A
                    CP (HL)
                    RET C

                    JR InitAcceleration.Set
Speed:              DB #04
NegSpeed            DB #FC

                endif ; ~_MOUSE_KEYBOARD_