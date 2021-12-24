
                ifndef _DRAW_SPRITE_HORIZONTAL_CLIPPING_
                define _DRAW_SPRITE_HORIZONTAL_CLIPPING_

                module Clipping

; -----------------------------------------
; отсечение спрайта по горизонтали
; In:
;   HL' - указатель на структуру FSprite.Info.Width
;   DE' - указывает на структуру FSpriteLocation.OffsetByPixel.Y
; Out:
;   если флаг переполнения C установлен, объект вне экрана
; Corrupt:
; Note:
;   Lx, Ly   - позиция спрайта (в тайлах)
;   Vx, Vy   - позиция видимой области карты (в тайлах)
;   Ox, Oy   - смещение спрайта относительно тайла (в пикселах)
;   Sx, Sy   - размер спрайта (х - в знакоместах, y - в пикселах)
;   SOx, SOy - смещение спрайта (в пикселах)
; -----------------------------------------
Horizontal:     EXX                                                             ; востановим 
                                                                                ; HL = FSprite.Info.Width
                                                                                ; DE = FSpriteLocation.OffsetByPixel.Y

                LD C, (HL)                                                      ; C - ширина спрайта в знакоместах (Sx)
                INC HL
                LD B, (HL)                                                      ; B - горизонтальное смещение в пикселях (SOx)
                INC HL
                PUSH BC

                ; (Ox + 8) добавить смещение относительно тайла
                DEC E                                                           ; DE = FSpriteLocation.OffsetByPixel.X
                LD A, (DE)                                                      ; A = FSpriteLocation.OffsetByPixel.X (Oy)
                ADD A, #08                                                      ; A += 8 (можно объеденить с значением 8 в данных спрайта)

                EXX                                                             ; сохраним 
                                                                                ; HL = FSprite.Dummy
                                                                                ; DE = FSpriteLocation.OffsetByPixel.X
                POP BC
                
                ; ; ширину спрайта конвертируем в пиксели
                ; EX AF, AF'                                                      ; сохраним (Ox + 8)
                ; LD A, C
                ; ADD A, A
                ; ADD A, A
                ; ADD A, A
                ; LD E, A
                ; EX AF, AF'                                                      ; востановим (Ox + 8)

                ; ; (Ox + 8 + Sx - SOx)
                ; ADD A, E                                                        ; A += Sx
                ; SUB B                                                           ; A -= SOx
                ; LD B, E

                ; ---------------------------------------------
                ; перенос на пиксели
                ; (Ox + 8 + Sx - SOx)
                ADD A, C                                                        ; A += Sx
                SUB B                                                           ; A -= SOx
                LD B, C
                ; ---------------------------------------------

                ; ---------------------------------------------
                ; B - ширина спрайта (Sx)           (в пикселах)
                ; C - ширина спрайта (Sx)           (в знакоместах)
                ; ---------------------------------------------

                ; преобразуем резульат (Ox + 8 + Sx - SOx) в 16-битное число
                LD E, A                                                         ; E = Ox + 8 + Sx - SOx
                SBC A, A                                                        ; если было переполнение (отрицательное число), корректируем
                LD D, A

                ; A = PositionX * 16
; .PositionX      EQU $+1
;                 LD A, #00
                LD A, (Sprite.PixelClipping.PositionX)
                DEC A                                                           ; A = [-1..16] - PositionX
                ADD A, A
                ADD A, A
                ADD A, A

                ; преобразуем результат (PositionX * 16) в 16-битное число
                LD L, A
                SBC A, A
                LD H, A
                ADD HL, HL

                ; OffsetX = PositionX * 16 + (Sx - SOx + Ox + 8)
                OR A
                ADC HL, DE                                                      ; необходим для определения знака (16-битного числа)
                ; - если отрицательное или равно нулю, спрайт левее экрана (не видим)
                JP M, .Clipped                                                  ; OffsetX - значение отрицательное
                JR Z, .Clipped                                                  ; OffsetX - значение нулевое

                ; OffsetX -= Sx (расчитаем левую часть спрайта)
                XOR A
                LD D, A
                LD E, B
                SBC HL, DE

                JR Z, .SpriteNotShift                                           ; на краю экрана ???????????????
                JR C, .ClipLeft                                                 ; урезан левой частью экрана
                OR H
                JR NZ, .Clipped                                                 ; левая часть спрайта за правой частью экрана
                LD A, L
                NEG
                SUB B
                JR C, .ClipRight                                                ; урезан правой частью экрана

.SpriteNotShift ; ---------------------------------------------
                ; спрайт рисуется полностью
                ; ---------------------------------------------
                ; L - левый край спрайта            (в пикселах)
                ; B - ширина спрайта (Sx)           (в пикселах)
                ; C - ширина спрайта (Sx)           (в знакоместах)
                ; ---------------------------------------------
                
                DEC B
                LD C, B

                ; ---------------------------------------------
                ; L - левый край спрайта            (в пикселах)
                ; C - ширина видимой части спрайта  (в пикселах)
                ; ---------------------------------------------

                OR A
                RET

.ClipLeft       ; ---------------------------------------------
                ; спрайт урезан левой частью экрана
                ; ---------------------------------------------
                ; L - номер левой части спрайта    (в пикселах)
                ; B - ширина спрайта (Sx)           (в пикселах)
                ; C - ширина спрайта (Sx)           (в знакоместах) - значение некорректное
                ; ---------------------------------------------

                LD A, L
                ADD A, B
                LD C, A
                LD L, #00

                ; ---------------------------------------------
                ; L - левый край спрайта            (в пикселах)
                ; C - ширина видимой части спрайта  (в пикселах)
                ; ---------------------------------------------
               
                OR A
                RET

.ClipRight      ; ---------------------------------------------
                ; спрайт урезан правой частью экрана
                ; ---------------------------------------------
                ; L - номер правой части спрайта    (в пикселах)
                ; A - количество пропускаемых пикселей спрайта
                ; B - ширина спрайта (Sx)           (в пикселах)
                ; C - ширина спрайта (Sx)           (в знакоместах)
                ; ---------------------------------------------
                
                DEC A
                ADD A, B
                LD C, A

                ; ---------------------------------------------
                ; L - левый край спрайта            (в пикселах)
                ; C - ширина видимой части спрайта  (в пикселах)
                ; ---------------------------------------------

                OR A
                RET

.Clipped        ; ---------------------------------------------
                ; спрайт вне экрана
                ; ---------------------------------------------
                SCF
                RET

                endmodule

                endif ; ~_DRAW_SPRITE_HORIZONTAL_CLIPPING_
