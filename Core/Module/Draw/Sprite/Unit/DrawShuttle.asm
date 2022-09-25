
                ifndef _CORE_MODULE_DRAW_SPRITE_UNIT_SHUTTLE_
                define _CORE_MODULE_DRAW_SPRITE_UNIT_SHUTTLE_
; -----------------------------------------
; отображение шатла
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawShuttle:    UNIT_IsMove (IX + FUnit.State)
                RET NZ                                                          ; выход, если шаттл не движется

                ; расчёт смещения в таблице
                LD A, (IX + FUnit.Type)                                         ; тип фракции (0 - нейтральная, 1 - враждебная)
                ADD A, A
                LD A, (IX + FUnit.Rank)                                         ; чтение ранга
                ADC A, A
                ADD A, A
                ADD A, A
                AND UNIT_RANK_MASK << 3

                ; результат:
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | 0  | 0  | R1 | R0 | F1 | 0  | 0  | 0  |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   R2-R0   [2..1]  - ранг (младшие 2 бита)
                ;   F1      [0]     - тип фракции (0 - нейтральная, 1 - враждебная)

                ; расчёт адреса информации о спрайте шатла
                LD HL, .Table
                ADD A, L
                LD L, A
                JR NC, $+3
                INC H
                EXX

                ; инициализация
                LD HL, GameVar.TilemapOffset
                LD A, (HL)                                                      ; b.minX
                INC HL
                LD B, (HL)                                                      ; b.minY
                EX AF, AF'

                LD H, #00
                LD C, H                                                         ; обнуление регистра C

                ; -----------------------------------------
                ; a.maxY < b.minY
                ; -----------------------------------------

                ; приведение к форме хранения позиции юнита (12.4)
                EXX
                LD A, (HL)                                                      ; a.maxY
                EXX
                ADD A, A
                ADD A, A
                ADD A, A
                RL H
                LD L, A

                ; расчёт максимального значения по оси Y (a.maxY)
                LD DE, (IX + FUnit.Position.Y)
                ADD HL, DE

                ; сравнение a.maxY, b.minY
                SBC HL, BC
                RET C                                                           ; выход, если a.maxY < b.minY

                ; -----------------------------------------
                ; a.minY > b.maxY
                ; -----------------------------------------

                ; приведение к форме хранения позиции юнита (12.4)
                LD H, C
                EXX
                INC HL
                LD A, (HL)                                                      ; a.minY
                EXX
                ADD A, A
                ADD A, A
                ADD A, A
                RL H
                ADD A, A
                RL H
                LD L, A

                ; расчёт минимального значения по оси Y (a.minY)
                EX DE, HL
                SBC HL, DE

                ; сравнение a.minY, b.maxY
                EX DE, HL
                LD A, SCREEN_TILE_Y
                ADD A, B
                LD H, A
                LD L, C
                SBC HL, DE
                RET C                                                           ; выход, если a.minY > b.maxY

                ; инициализация
                EX AF, AF'
                LD B, A

                ; -----------------------------------------
                ; a.maxX < b.minX
                ; -----------------------------------------

                ; приведение к форме хранения позиции юнита (12.4)
                LD H, C
                EXX
                INC HL
                LD A, (HL)                                                      ; a.maxX
                EXX
                ADD A, A
                ADD A, A
                ADD A, A
                RL H
                ADD A, A
                RL H
                LD L, A

                ; расчёт максимального значения по оси X (a.maxX)
                LD DE, (IX + FUnit.Position.X)
                ADD HL, DE

                ; сравнение a.maxX, b.minX
                SBC HL, BC
                RET C                                                           ; выход, если a.maxX < b.minX

                ; -----------------------------------------
                ; a.minX > b.maxX
                ; -----------------------------------------

                ; приведение к форме хранения позиции юнита (12.4)
                LD H, C
                EXX
                INC HL
                LD A, (HL)                                                      ; a.minX
                EXX
                ADD A, A
                ADD A, A
                ADD A, A
                RL H
                ADD A, A
                RL H
                LD L, A

                ; расчёт минимального значения по оси X (a.minX)
                EX DE, HL
                SBC HL, DE

                ; сравнение a.minX, b.maxX
                EX DE, HL
                LD A, SCREEN_TILE_X
                ADD A, B
                LD H, A
                LD L, C
                SBC HL, DE
                RET C                                                           ; выход, если a.minX > b.maxX

                ; переключение страницы хранения композитного спрайта
                EXX
                INC HL
                LD A, (HL)
                CALL SetPage
                INC HL
                LD E, (HL)
                INC HL
                LD D, (HL)
                EX DE, HL

                ; корректировка адреса спрайта, при наличии анимации
                LD C, (HL)                                                      ; FCompositeSpriteInfo.Flags
                INC HL
                LD E, (HL)                                                      ; FCompositeSpriteInfo.Info.Height
                INC HL
                LD A, (HL)                                                      ; FCompositeSpriteInfo.Info.OffsetY
                INC HL
                LD D, (HL)                                                      ; FCompositeSpriteInfo.Info.Width
                INC HL
                PUSH DE
                LD E, A
                LD D, (HL)                                                      ; FCompositeSpriteInfo.Info.OffsetX
                INC HL
                PUSH DE

                ; D - FCompositeSpriteInfo.Info.OffsetX
                ; E - FCompositeSpriteInfo.Info.OffsetY
                ; B - FCompositeSpriteInfo.Info.Width
                ; C - FCompositeSpriteInfo.Info.Height

                EXX
                POP DE
                POP BC
                EXX

                LD A, CSIF_ANIM_MASK
                AND C
                JR Z, .AnimNone                                                 ; спрайт не анимированный

                ; расчёт номера анимации
                LD E, A
                LD A, (#0000)
                LD D, A
                CALL Math.Div8x8
                ; AND FUAF_ANIM_DOWN_MASK
                EX AF, AF'                                                      ; сохранение флага Z

                ; расчёт размер спрайта, в зависимости от флагов
                LD A, CSIF_OR_XOR | CSIF_SIZE_MASK
                AND C
                ADD A, A
                JR NC, $+5
                ADD A, A
                RL B
                LD C, A

                ; проверка первого кадра анимации
                EX AF, AF'                                                      ; восстановление флага Z
                JR Z, .CalcNextSpr

                ; расчёт адреса отображаемого кадра анимации
.SprLoop        ADD HL, BC
                DEC E
                DEC A
                JR NZ, .SprLoop

.CalcNextSpr    ; расчёт адреса следующего спрайта
                PUSH HL
                LD A, E
.NextSprLoop    ADD HL, BC
                DEC A
                JR NZ, .NextSprLoop

                ; смена адресов
                EX (SP), HL                                                     ; адрес следующего спрайта
                PUSH HL                                                         ; адрес текущего спрайта, с учётом анимации-

.AnimNone       ; инициализация
                LD HL, GameVar.TilemapOffset
                LD C, (HL)                                                      ; X
                INC HL
                LD B, (HL)                                                      ; Y
                
                EXX

                ; D - FCompositeSpriteInfo.Info.OffsetX (SOx)
                ; E - FCompositeSpriteInfo.Info.OffsetY (SOy)
                ; B - FCompositeSpriteInfo.Info.Width   (Sx)
                ; C - FCompositeSpriteInfo.Info.Height  (Sy)

                ; -----------------------------------------
                ; расчёт положения спрайта по вертикали,
                ; относительно верхней границы видимой области
                ; -----------------------------------------

                ; HL = SOy << 4
                LD A, E
                ADD A, A
                SBC A, A
                LD H, A
                LD A, E
                ADD A, A
                ADD A, A
                ADD A, A
                RL H
                ADD A, A
                RL H

                ; HL += FUnit.Position.Y - GameVar.TilemapOffset.Y
                ADD A, (IX + FUnit.Position.Y.Low)                              ; ToDo вкл страница спрайта
                LD L, A
                JR NC, $+3
                INC H
                LD A, H
                ADD A, (IX + FUnit.Position.Y.High)
                ; вычесть положение видимой области по вертикали
                EXX
                SUB B                                                           ; GameVar.TilemapOffset.Y
                EXX
                LD H, A                                                         ; HL - хранит положение спрайта, относительно верхней границы видимой области
                JP P, .BelowTop                                                 ; переход, если спрайт находится ниже верхней границы видимой области

                ; ---------------------------------------------
                ; спрайт выше границы видимой области
                ; ---------------------------------------------

                ; преобразование высоты спрайта в 16-битное число
                LD B, #00
                LD A, C
                ADD A, A
                ADD A, A
                ADD A, A
                RL B
                ADD A, A
                RL B

                ; добавить к относительному расположению спрайта по вертикали,
                ; относительно верхней границы видимой области размер спрайта
                ADD HL, BC
                RET NC                                                          ; выход, если при добавлении размера спрайта по вертикали,
                                                                                ; не произошло переполненеи. значение осталось отрицательным
                                                                                ; и спрайт полностью находится выше видимой области

.ClipTop        ; ---------------------------------------------
                ; спрайт урезан верхней частью видимой области
                ; ---------------------------------------------
        

.BelowTop       ; ---------------------------------------------
                ; спрайт находится ниже верхней границы видимой области
                ; ---------------------------------------------



.ClipBottom     ; ---------------------------------------------
                ; спрайт урезан нижней частью видимой области
                ; ---------------------------------------------



                ; приведение к 8 битному значению по вертикали HL << 4
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL

                ; проверка позиции спрайта в пределах от 0 до 191
                LD A, H
                CP SCREEN_PIXEL_Y
                JR C, .ClipBottom                                               ; переход, если позиция в пределах от 0 до 191

                ; проверка позиции спрайта выше экрана
                NEG
                CP C
                RET NC                                                          ; выход, если спрайт выше экрана



                RET
.Table
                include "Core/Module/Tables/Sprites/Shuttle/Data.inc"

                display " - Draw Unit Shuttle : \t\t", /A, DrawShuttle, " = busy [ ", /D, $ - DrawShuttle, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_UNIT_SHUTTLE_
