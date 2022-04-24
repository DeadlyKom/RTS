
                ifndef _DRAW_SPRITE_PIYEL_CLIPPING_
                define _DRAW_SPRITE_PIYEL_CLIPPING_

; -----------------------------------------
; отсечение спрайта экраном (попиксельный)
; In:
;   HL         - указатель на структуру FSprite
;   IX         - указывает на структуру FUnit
;   A'         -  PositionY => [0..13]
;   .PositionX -  PositionX => [0..17]
; Out:
;   если флаг переполнения C установлен, объект вне экрана
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC' AF', IY
; Note:
;   Lx, Ly   - позиция спрайта (в тайлах)
;   Vx, Vy   - позиция видимой области карты (в тайлах)
;   Ox, Oy   - смещение спрайта относительно тайла (в пикселах)
;   Sx, Sy   - размер спрайта (х - в знакоместах, y - в пикселах)
;   SOx, SOy - смещение спрайта (в пикселах)
; -----------------------------------------
PixelClipping:  ; ---------------------------------------------

                ; дефолтная очистка (отсутствие пропуска строк)
                XOR A
                LD (MEMCPY.Sprite.SkipTopRow), A
                LD (MEMCPY.SharedMask.SkipBottomRow), A

                ; ---------------------------------------------
                LD C, (HL)                                                      ; C - высота спрайта в пикселях (Sy)
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
                ; C - высота спрайта в пикселях (Sy)
                ; B - вертикальное смещение в пикселях (SOy)
                ; ---------------------------------------------

                ; (Sy - SOy)
                ADD A, C                                                        ; A += Sy
                SUB B                                                           ; A -= SOy
                
                ; преобразуем резульат (Oy + 8 + Sy - SOy) в 16-битное число
                LD L, A                                                         ; L = Oy + 8 + Sy - SOy
                SBC A, A                                                        ; если было переполнение (отрицательное число), корректируем
                LD H, A

                ; A = PositionY * 16
.PositionY      EQU $+1
                LD A, #00
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
                ; C - высота спрайта в пикселях (Sy)
                ; ---------------------------------------------

                ; OffsetY -= Sy
                LD A, L
                SUB C
                JR C, .ClipTop                                                  ; урезан верхней частью экрана

                ; A - хранит номер верхней линии спрайта
                LD L, A                                                         ; L - хранит номер верхней линии спрайта
                ADD A, (-TilesOnScreenY * 16) &0xFF
                JR C, .Clipped                                                  ; если переполнение, то верхняя линия спрайта больше или равно (TilesOnScreenY * 16)
                                                                                ; спрайт ниже экрана
                NEG                                                             ; А - хранит количество рисуемых строк
                SUB C
                JR C, .ClipBottom                                               ; урезан нижней частью экрана

                ; ---------------------------------------------
                ; спрайт рисуется полностью по вертикали
                ; ---------------------------------------------
                ; L - хранит номер верхней линии спрайта
                ; C - высота спрайта в пикселях (Sy)
                ; ---------------------------------------------

                ; сохраним высоту спрайта
                LD A, C
                LD (Draw.RowOffset), A                                          ; сохраним количество рисуемых строк
                LD (Draw.SpriteHeight), A                                       ; сохраним высоту спрайта

.ScrRowAdr      LD H, HIGH SCR_ADR_TABLE
                LD A, (HL)
                INC H
                LD H, (HL)
                LD L, A

                ; сохраним смещение столбца (в знакоместах)
                LD (Draw.ScreenAdr), HL
                JP .ClipRow

.ClipTop        ; ---------------------------------------------
                ; спрайт урезан верхней частью экрана
                ; ---------------------------------------------
                ; L - номер нижней линии спрайта, т.е. количество рисуемых строк
                ; C - высота спрайта в пикселях (Sy)
                ; А - хранит количество не рисуемых строк со знаком минус
                ; ---------------------------------------------

                ; ToDo перенести в копирование спрайта, т.к. не требуется для
                ; спрайтов с 1 маской
                NEG                                                             ; меняем знак, чтобы получить количество пропускаемых строк
                DEC A                                                           ; пропуск начинается с 1
                LD B, A                                                         ; B = хранит количество пропускаемых строк
                
                EX DE, HL

                EXX
                ; HL = FSprite.Info.Width
                LD A, (HL)                                                      ; A =  Sx (ширина спрайта в знакоместах)
                DEC A                                                           ; пропуск начинается с 1
                EXX
                ADD A, A
                ADD A, A
                ADD A, A
                ADD A, A
                ADD A, A
                OR B
                LD L, A
                LD H, HIGH MultiplySprite
                LD A, (HL)

                ; сохраним количество пропускаемых строк
                LD (MEMCPY.Sprite.SkipTopRow), A

                ; сохраним высоту спрайта
                LD A, E
                LD (Draw.RowOffset), A                                          ; сохраним количество рисуемых строк
                LD (Draw.SpriteHeight), A                                       ; сохраним высоту спрайта

                ; адрес начала экрана, меняется только номер столбца
                LD HL, #C000
                LD (Draw.ScreenAdr), HL
                JP .ClipRow

.Clipped        ; ---------------------------------------------
                ; спрайт вне экрана
                ; ---------------------------------------------
                SCF
                RET

.ClipBottom     ; ---------------------------------------------
                ; спрайт урезан нижней частью экрана
                ; ---------------------------------------------
                ; L - хранит номер верхней линии спрайта
                ; C - высота спрайта в пикселях (Sy)
                ; А - хранит количество не рисуемых строк со знаком минус
                ; ---------------------------------------------

                ; если не чётное увеличим в большую сторону (портит 32 байта после экранной области!)
                ADD A, C                                                        ; А - хранит количество пропускаемых строк
                RRA
                ADC A, #00
                RLA

                ; сохраним высоту спрайта
                LD (Draw.RowOffset), A                                          ; сохраним количество рисуемых строк
                LD (Draw.SpriteHeight), A                                       ; сохраним высоту спрайта

                ; - костыль для спрайтов с 1 маской (требуется только для него)
                ; ToDo перенести его в копирование спрайта
                NEG
                ADD A, C
                JR Z, .Set                                                      ; полное копирование (т.к. не видим 1 срока, но значение округлилось)
                DEC A                                                           ; пропуск начинается с 1
                LD B, A                                                         ; B = хранит количество пропускаемых строк
                
                EXX
                ; HL = FSprite.Info.Width
                LD A, (HL)                                                      ; A =  Sx (ширина спрайта в знакоместах)
                DEC A                                                           ; пропуск начинается с 1
                EXX
                LD C, L
                ADD A, A
                ADD A, A
                ADD A, A
                ADD A, A
                ADD A, A
                OR B
                LD L, A
                LD H, HIGH MultiplySprite
                LD A, (HL)
                RRA
                LD L, C

.Set            ; сохраним количество пропускаемых строк
                LD (MEMCPY.SharedMask.SkipBottomRow), A
                
                JP .ScrRowAdr

.ClipRow        ; ---------------------------------------------
                ; горизонтальный клипинг
                ; ---------------------------------------------

                EXX                                                             ; востановим 
                                                                                ; HL = FSprite.Info.Width
                                                                                ; DE = FSpriteLocation.OffsetByPixel.Y

                LD C, (HL)                                                      ; C - ширина спрайта в знакоместах (Sx)
                INC HL
                LD B, (HL)                                                      ; B - горизонтальное смещение в пикселях (SOx)
                INC HL
                PUSH BC

                ; (Ox + 8) добавить смещение относительно тайла
                LD A, (IX + FUnit.Offset.X)
                ADD A, #08                                                      ; A += 8 (можно объеденить с значением 8 в данных спрайта)

                EXX                                                             ; сохраним 
                                                                                ; HL = FSprite.Dummy
                                                                                ; DE = FSpriteLocation.OffsetByPixel.X
                POP BC

                EX AF, AF'                                                      ; сохраним (Ox + 8)
                ; сохраним ширину спрайта
                LD A, C
                LD (Draw.SpriteWidth), A

                ; ширину спрайта конвертируем в пиксели
                ADD A, A
                ADD A, A
                ADD A, A
                LD E, A
                EX AF, AF'                                                      ; востановим (Ox + 8)

                ; (Ox + 8 + Sx - SOx)
                ADD A, E                                                        ; A += Sx
                SUB B                                                           ; A -= SOx
                LD B, E

                ; ---------------------------------------------
                ; B - ширина спрайта (Sx)       в пикселах 
                ; C - ширина спрайта (Sx)       в знакоместах
                ; ---------------------------------------------

                ; преобразуем резульат (Ox + 8 + Sx - SOx) в 16-битное число
                LD E, A                                                         ; E = Ox + 8 + Sx - SOx
                SBC A, A                                                        ; если было переполнение (отрицательное число), корректируем
                LD D, A

                ; A = PositionX * 16
.PositionX      EQU $+1
                LD A, #00
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

                ; ---------------------------------------------
                ; спрайт рисуется полностью
                ; ---------------------------------------------
                ; L - левый край спрайта (в пикселах)
                ; ---------------------------------------------

                LD B, L                                                         ; сохраним L

                ; конвертируем пикселы в знакоместа ((L >> 3) & 0x1F)
                LD A, L
                RRA
                RRA
                RRA
                AND %00011111

.SpriteNotShift ; сохраним смещение столбца (в знакоместах)
                LD HL, Draw.ScreenAdr
                ADD A, (HL)
                LD (HL), A

                ; расчёт смещения в знакоместе
                LD A, B
                AND %00000111
                LD HL, TableJumpDraw
                JR Z, .CalcJumpAdr                                              ; если ноль, спрайт рисуется полность, без сдвига

                ; ---------------------------------------------
                ; спрайт рисуется полность, со сдвигом
                ; ---------------------------------------------
                ; calculate address of shift table
                ; ---------------------------------------------

                EXX
                DEC A
                ADD A, A
                ADD A, HIGH ShiftTable
                LD D, A                                                         ; D - больше не требуется, в дальнейшем загрузится в H
                EXX

                LD HL, TableShiftJumpDraw

.CalcJumpAdr    ; расчёт адреса в таблице по длине спрайта
                ; ---------------------------------------------
                ; C - ширина спрайта (Sx)       в знакоместах
                ; ---------------------------------------------

                LD A, C
                DEC A
                ADD A, A     
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H

                ; получим адрес метода отрисовки
                LD A, (HL)
                LD IYL, A
                INC L
                LD A, (HL)
                LD IYH, A

                OR A
                RET

.ClipLeft       ; ---------------------------------------------
                ; спрайт урезан левой частью экрана
                ; ---------------------------------------------
                ; L - номер правой части спрайта (в пикселах)
                ; B - ширина спрайта в пикселах (Sx)
                ; C - ширина спрайта в знакоместах (Sx)
                ; ---------------------------------------------

                ; расчёт смещения в знакоместе
                LD A, L
                AND %00000111
                LD B, A                                                         ; спрайт выровнен, смещение в таблице отсутствует
                JR Z, .CalcJumpAdr_L                                            ; если ноль, спрайт урезан левой частью экрана, без сдвига

                ; ---------------------------------------------
                ; спрайт урезан левой частью экрана, со сдвига
                ; ---------------------------------------------
                ; calculate address of shift table
                ; ---------------------------------------------

                EXX
                DEC A
                ADD A, A
                ADD A, HIGH ShiftTable
                INC A                                                           ; пропуск левой части значений смещений
                LD D, A                                                         ; D - больше не требуется, в дальнейшем загрузится в H
                EXX

                LD B, #0C                                                       ; спрайт не выровнен, смещение в таблице

.CalcJumpAdr_L  ; ---------------------------------------------
                ; L - номер правой части спрайта (в пикселах)
                ; B - ширина спрайта в пикселах (Sx)
                ; C - ширина спрайта в знакоместах (Sx)
                ; ---------------------------------------------

                ; расчёт адреса в таблице по длине спрайта
                LD A, L
                NEG
                RRA
                RRA
                RRA
                AND %00011111
                ADD A, A    ; x2
                ADD A, A    ; x4

                ; смещение в таблице, если байт выравнен
                ADD A, B    ; если спрайт выровнен, смещение в таблице отсутствует
                DEC C
                ADD A, C    ; + смещение (байтовое)
                ADD A, A    ; x2 (адрес)

                ; расчёт адреса обработчика
                LD HL, TableLSJumpDraw
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                
                ; получим адрес метода отрисовки
                LD A, (HL)
                LD IYL, A
                INC L
                LD A, (HL)
                LD IYH, A
                
                OR A
                RET

.ClipRight      ; ---------------------------------------------
                ; спрайт урезан правой частью экрана
                ; ---------------------------------------------
                ; L - номер правой части спрайта (в пикселах)
                ; A - количество пропускаемых пикселей спрайта
                ; B - ширина спрайта в пикселах (Sx)
                ; C - ширина спрайта в знакоместах (Sx)
                ; ---------------------------------------------

                EX AF, AF'                                                      ; сохраним количество пропускаемых пикселей спрайта

                ; расчёт смещения в знакоместе
                LD A, L
                AND %00000111
                LD B, A                                                         ; спрайт выровнен, смещение в таблице отсутствует
                JR Z, .CalcJumpAdr_R                                            ; если ноль, спрайт урезан правой частью экрана, без сдвига

                ; ---------------------------------------------
                ; спрайт урезан правой частью экрана, со сдвига
                ; ---------------------------------------------
                ; calculate address of shift table
                EXX
                DEC A
                ADD A, A
                ADD A, HIGH ShiftTable
                LD D, A                                                         ; D - больше не требуется, в дальнейшем загрузится в H
                EXX

                LD B, #0C   ; спрайт не выровнен, смещение в таблице
.CalcJumpAdr_R  ; ---------------------------------------------
                ; L - номер правой части спрайта (в пикселах)

                ; расчёт знакоместа
                LD A, L
                RRA
                RRA
                RRA
                AND %00011111

                ; сохраним смещение столбца (в знакоместах)
                LD HL, Draw.ScreenAdr
                ADD A, (HL)
                LD (HL), A

                ; расчёт адреса в таблице по длине спрайта
                EX AF, AF'                                                      ; востановим количество пропускаемых пикселей спрайта
                NEG
                RRA
                RRA
                RRA
                AND %00011111
                ADD A, A    ; x2
                ADD A, A    ; x4

                ; смещение в таблице, если байт выравнен
                ADD A, B    ; если спрайт выровнен, смещение в таблице отсутствует
                DEC C
                ADD A, C    ; + смещение (байтовое)
                ADD A, A    ; x2 (адрес)

                ; расчёт адреса обработчика
                LD HL, TableRSJumpDraw
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H

                ; получим адрес метода отрисовки
                LD A, (HL)
                LD IYL, A
                INC L
                LD A, (HL)
                LD IYH, A

                OR A
                RET

                endif ; ~_DRAW_SPRITE_PIYEL_CLIPPING_
