
                    ifndef _MOUSE_KEYBOARD_
                    define _MOUSE_KEYBOARD_
MoveLeft:           LD HL, MousePositionX
                    LD A, (NegSpeed)
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
                    ADD A, (HL)
                    JR NC, SetMouseLocationX                ; проверка на переполнение (курсор достих правого края экрана)
                    LD A, #FF                               ; фиксируем значение
                    JR SetMouseLocationX

MoveUp:             LD HL, MousePositionY
                    LD A, (NegSpeed)
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
                    ADD A, (HL)
                    JR C, .SetMaxLocationY                  ; проверка на переполнение (курсор достих нижнего края экрана)
                    CP #C0
                    JR C, SetMouseLocationY
.SetMaxLocationY    LD A, #BF                               ; фиксируем значение
                    JR SetMouseLocationY
Speed:              DB #04
NegSpeed            DB #FC

                endif ; ~_MOUSE_KEYBOARD_