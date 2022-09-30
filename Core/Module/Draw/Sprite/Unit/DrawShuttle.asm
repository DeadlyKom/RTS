
                ifndef _CORE_MODULE_DRAW_SPRITE_UNIT_SHUTTLE_
                define _CORE_MODULE_DRAW_SPRITE_UNIT_SHUTTLE_
; -----------------------------------------
; отображение шаттла
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawShuttle:    UNIT_IsMove (IX + FUnit.State)
                RET NZ                                                          ; выход, если шаттл не движется

                ; -----------------------------------------
                ; первая фаза (тень)
                ; -----------------------------------------

                

                LD DE, (IX + FUnit.Position.Y)
                LD HL, #0700                                                    ; LD A, (IX + FUnit.Target)
                OR A
                DEC HL
                SBC HL, DE
                JR C, .Landing

                ; ограничение анимации (слишком высоко)
                LD A, #04
                LD (GameAnim.Element_1), A

                ; проверка фазы раскрытия посдочных лап
                LD A, H
                CP #05
                JR NC, .Landing

                ; кламп 0
                LD A, H
                SUB 1
                ADC A, #00
                LD (GameAnim.Element_1), A
                LD (GameAnim.Element_2), A

                ; дополнительное смещение тени
                ADD HL, HL
                LD A, H
                AND #0F
                ADD A, A
                ADD A, A
                SUB 31
                ADC A, 30
                AND #F8
                LD (GameAnim.OffsetY), A

                LD HL, Shadow
                CALL DrawComposite                                              ; отображение шаттла

.Landing        ; -----------------------------------------
                ; вторая фаза (посадка)
                ; -----------------------------------------

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

                ; расчёт адреса информации о спрайте шаттла FCompositeSprite
                LD HL, .Table
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A

                ; смена кадра анимации шаттла
                LD A, (TickCounterRef)
                RRA
                RRA
                AND 1
                LD (GameAnim.Element_0), A

                ; обнуление смещения
                XOR A
                LD (GameAnim.OffsetY), A

                CALL DrawComposite                                              ; отображение шаттла

                RET
.Table
                include "Core/Module/Tables/Sprites/Shuttle/Data.inc"

                display " - Draw Unit Shuttle : \t\t", /A, DrawShuttle, " = busy [ ", /D, $ - DrawShuttle, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_UNIT_SHUTTLE_
