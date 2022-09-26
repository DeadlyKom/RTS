
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
                ADC A, H
                SUB L
                LD H, A

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
                ADD A, A
                RL H
                LD L, A

                ; расчёт максимального значения по оси Y (a.maxY)
                LD DE, (IX + FUnit.Position.Y)
                LD (Prepare.PositionY), DE                                      ; сохранение позиции юнита по вертикали
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
                LD (Prepare.PositionX), DE                                      ; сохранение позиции юнита по горизонтали
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
                LD A, (HL)                                                      ; FCompositeSprite.Data.Page
                CALL SetPage
                INC HL
                LD E, (HL)
                INC HL
                LD D, (HL)
                EX DE, HL

.Loop           ; корректировка адреса спрайта, при наличии анимации
                LD C, (HL)                                                      ; FCompositeSpriteInfo.Flags
                INC HL
                LD E, (HL)                                                      ; FCompositeSpriteInfo.Info.Height
                INC HL
                LD A, (HL)                                                      ; FCompositeSpriteInfo.Info.OffsetY
                LD (Prepare.SOy), A
                INC HL
                LD D, (HL)                                                      ; FCompositeSpriteInfo.Info.Width
                LD (Prepare.SpriteSize), DE
                INC HL
                LD A, (HL)                                                      ; FCompositeSpriteInfo.Info.OffsetX
                LD (Prepare.SOx), A
                INC HL

                ; проверка наличия анимации у спрайта
                LD A, CSIF_ANIM_MASK
                AND C
                JR Z, .AnimNone                                                 ; спрайт не анимированный

                ; расчёт номера анимации
                LD E, A
                LD A, (#0000)
                LD D, A
                CALL Math.Div8x8
                AND FUAF_ANIM_DOWN_MASK
                EX AF, AF'                                                      ; сохранение флага Z

                ; расчёт размер спрайта, в зависимости от флагов
                ; обрежется флаг CSIF_MASK_BIT,
                ; т.к. для данного типа спрайта она не допустима
                LD A, CSIF_OR_XOR | CSIF_SIZE_MASK
                AND C
                LD (GameFlags.SpriteFlagRef), A                                 ; сохранение флагов спрайта
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

                ; сохранение адреса следующего спрайта
                EX (SP), HL

.AnimNone       CALL Prepare
                CALL C, Draw

                POP HL
                LD A, (HL)
                OR A
                RET Z
                JR .Loop
.Table
                include "Core/Module/Tables/Sprites/Shuttle/Data.inc"

                display " - Draw Unit Shuttle : \t\t", /A, DrawShuttle, " = busy [ ", /D, $ - DrawShuttle, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_UNIT_SHUTTLE_
