
                            ifndef _MOUSE_UPDATE_STATES_
                            define _MOUSE_UPDATE_STATES_

; -----------------------------------------
; In :
; Out :
; Corrupt :
;   HL, E, BC, AF
; -----------------------------------------
UpdateStatesMouse:          XOR A
                            LD (MousePositionFlag), A
                            
                            CALL GetMouseX                          ; получить текущее значение позиции мыши по оси X
                            LD E, A
                            LD HL, LastValueFromMousePortX
                            SUB (HL)                                ; расчитать разницу значений между текущим и предыдущими значениями
                            LD (HL), E                              ; сохраним текущее значение
                            JR Z, .SkipChangeX                      ; дельта равна 0
                            LD HL, MousePositionX
                            JP P, .PositiveX                        ; разница значений положительная

                            ADD A, (HL)
                            JR C, .SetMouseLocationX                ; проверка на переполнение (курсор достиг левого края экрана)

                            XOR A                                   ; фиксируем значение
                            JR .SetMouseLocationX
.PositiveX                  ADD A, (HL)
                            JR NC, .SetMouseLocationX               ; проверка на переполнение (курсор достих правого края экрана)

                            LD A, #FF                               ; фиксируем значение
.SetMouseLocationX          LD (HL), A                              ; изменить значение положение мыши по оси X
                            LD A, #FF
                            LD (MousePositionFlag), A               ; установка флага изменения позиции мыши

.SkipChangeX                CALL GetMouseY                          ; получить текущее значение позиции мыши по оси Y
                            LD E, A
                            LD HL, LastValueFromMousePortY
                            SUB (HL)                                ; расчитать разницу значений между текущим и предыдущими значениями
                            LD (HL), E                              ; сохраним текущее значение

                            RET Z                                   ; дельта равна 0
                            NEG                                     ; инвертнём значение оси Y
                            LD HL, MousePositionY
                            JP P, .PositiveY                        ; разница значений положительная

                            ADD A, (HL)
                            JR C, .SetMouseLocationY                ; проверка на переполнение (курсор достиг верхнего края экрана)

                            XOR A                                   ; фиксируем значение
                            JR .SetMouseLocationY
.PositiveY                  ADD A, (HL)
                            JR C, .SetMaxLocationY                  ; проверка на переполнение (курсор достих нижнего края экрана)
                            CP #C0
                            JR C, .SetMouseLocationY

.SetMaxLocationY            LD A, #BF                               ; фиксируем значение
.SetMouseLocationY          LD (HL), A
                            LD A, #FF
                            LD (MousePositionFlag), A               ; установка флага изменения позиции мыши
                            RET

MousePosition:              EQU $
MousePositionX:             DB #80
MousePositionY:             DB #60
LastValueFromMousePortX:    DB #80
LastValueFromMousePortY:    DB #60
MousePositionFlag:          DB #FF                                  ; если #FF - поменялась позиция

                            endif ; ~_MOUSE_UPDATE_STATES_