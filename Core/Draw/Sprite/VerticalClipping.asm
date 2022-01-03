
                ifndef _DRAW_SPRITE_VERTICAL_CLIPPING_
                define _DRAW_SPRITE_VERTICAL_CLIPPING_

                module Clipping

; -----------------------------------------
; отсечение спрайта по вертикали
; In:
;   HL - указатель на структуру FSprite
;   IX - указывает на структуру FUnit
; Out:
;   L   - хранит номер верхней линии спрайта
;   C   - высота видимой части спрайта в пикселях (Sy)
;   HL' - указывает на FSprite.Info.Width
;   если флаг переполнения C установлен, объект вне экрана
; Corrupt:
; Note:
;   Lx, Ly   - позиция спрайта (в тайлах)
;   Vx, Vy   - позиция видимой области карты (в тайлах)
;   Ox, Oy   - смещение спрайта относительно тайла (в пикселах)
;   Sx, Sy   - размер спрайта (х - в знакоместах, y - в пикселах)
;   SOx, SOy - смещение спрайта (в пикселах)
; -----------------------------------------
Vertical:       LD C, (HL)                                                      ; C - высота спрайта в пикселях (Sy)
                LD A, C
.AddSizeByPixel EQU $+1
                ADD A, #00
                LD C, A
                INC HL
                LD B, (HL)                                                      ; B - вертикальное смещение в пикселях (SOy)
                INC HL
                PUSH BC

                ; добавить смещение относительно тайла (Oy + 8)
                LD A, (IX + FUnit.Offset.Y)
                ADD A, #08                                                      ; A += 8 (можно объеденить с значением 8 в данных спрайта)

                EXX                                                             ; сохраним 
                                                                                ; HL = FSprite.Info.Width
                                                                                ; DE = FSpriteLocation.OffsetByPixel.Y
                POP BC
                
                ; ---------------------------------------------
                ; вертикальный клипинг
                ; ---------------------------------------------
                ; C - высота спрайта в пикселях                 (Sy)
                ; B - вертикальное смещение в пикселях          (SOy)
                ; ---------------------------------------------

                ; (Sy - SOy)
                ADD A, C                                                        ; A += Sy
                SUB B                                                           ; A -= SOy
.OffsetByPixel  EQU $+1
                SUB #00
                
                ; преобразуем резульат (Oy + 8 + Sy - SOy) в 16-битное число
                LD L, A                                                         ; L = Oy + 8 + Sy - SOy
                SBC A, A                                                        ; если было переполнение (отрицательное число), корректируем
                LD H, A

                ; A = PositionY * 16
; .PositionY      EQU $+1
                ; LD A, #00
                LD A, (Sprite.PixelClipping.PositionY)
                DEC A                   ; A = [-1..12] => PositionY
                ADD A, A
                ADD A, A
                ADD A, A
                ADD A, A

                ; преобразуем результат (PositionY * 16) в 16-битное число
                LD E, A
                SBC A, A
                LD D, A

                ; OffsetY = PositionY * 16 + (Sy - SOy + Oy + 8)
                OR A
                ADC HL, DE                                                      ; необходим для определения знака (16-битного числа)

                ; - если отрицательное или равно нулю, спрайт выше экрана (не видим)
                JP M, .Clipped                                                  ; OffsetY - значение отрицательное
                JR Z, .Clipped                                                  ; OffsetY - значение нулевое

                ; ---------------------------------------------
                ; расчитаем верхнюю часть спрайта
                ; ---------------------------------------------
                ; L - хранит номер нижней линии спрайта
                ; C - высота спрайта в пикселях                 (Sy)
                ; ---------------------------------------------

                ; OffsetY -= Sy
                LD A, L
                SUB C
                JR C, .ClipTop                                                  ; урезан верхней частью экрана

                ; ---------------------------------------------
                ; проверка находится ли верхняя часть спрайта ниже экрана
                ; ---------------------------------------------
                ; A - хранит номер верхней линии спрайта
                ; C - высота спрайта в пикселях                 (Sy)
                ; ---------------------------------------------

                LD L, A                                                         ; L - хранит номер верхней линии спрайта
                ADD A, (-TilesOnScreenY * 16) &0xFF
                ; JR C, .Clipped                                                  ; если переполнение, то верхняя линия спрайта больше или равно (TilesOnScreenY * 16)
                RET C
                                                                                ; спрайт ниже экрана

                ; ---------------------------------------------
                ; проверка находится ли нижняя часть спрайта ниже экрана
                ; ---------------------------------------------
                ; A - хранит количество видимых линий спрайта (со знаком минус)
                ; C - высота спрайта в пикселях                 (Sy)
                ; ---------------------------------------------
                NEG                                                             ; А - хранит количество рисуемых строк
                SUB C
                JR C, .ClipBottom                                               ; урезан нижней частью экрана
                JR Z, .ClipBottom                                               ; урезан нижней частью экрана

                ; ---------------------------------------------
                ; спрайт рисуется полностью по вертикали
                ; ---------------------------------------------
                ; L - хранит номер верхней линии спрайта
                ; C - высота спрайта в пикселях                 (Sy)
                ; ---------------------------------------------
                OR A
                RET

.ClipTop        ; ---------------------------------------------
                ; спрайт урезан верхней частью экрана
                ; ---------------------------------------------
                ; A - хранит количество не видимых линий спрайта (со знаком минус)
                ; L - номер нижней линии спрайта, т.е. количество рисуемых строк
                ; C - высота спрайта в пикселях                 (Sy)
                ; ---------------------------------------------
                ADD A, C
                LD C, A
                LD L, #00
                ; ---------------------------------------------
                ; спрайт урезан экраном по вертикали верхней частью
                ; ---------------------------------------------
                ; L - хранит номер верхней линии спрайта
                ; C - высота видимой части спрайта в пикселях   (Sy)
                ; ---------------------------------------------
                OR A
                RET

.ClipBottom     ; ---------------------------------------------
                ; спрайт урезан нижней частью экрана
                ; ---------------------------------------------
                ; А - хранит количество не рисуемых строк (со знаком минус)
                ; L - хранит номер верхней линии спрайта
                ; C - высота спрайта в пикселях (Sy)
                ; ---------------------------------------------

                ; если нечётное увеличим в большую сторону (портит 32 байта после экранной области!)
                DEC C
                LD B, C
                ADD A, C                                                        ; А - хранит количество пропускаемых строк
                ; RRA
                ; ADC A, #00
                ; RLA
                LD C, A
                ; ---------------------------------------------
                ; спрайт урезан экраном по вертикали нижней частью
                ; ---------------------------------------------
                ; L - хранит номер верхней линии спрайта
                ; C - высота видимой части спрайта в пикселях   (Sy)
                ; ---------------------------------------------
                OR A
                RET

.Clipped        ; ---------------------------------------------
                ; спрайт вне экрана
                ; ---------------------------------------------
                SCF
                RET

                endmodule

                endif ; ~_DRAW_SPRITE_VERTICAL_CLIPPING_
