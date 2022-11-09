
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
DrawShuttle:    ; ToDo организовать более правильную логику работу

                UNIT_IsMove (IX + FUnit.State)
                JR Z, .Landing                                                  ; выход, если шаттл не движется

                ; -----------------------------------------
                ; первая фаза (тень)
                ; -----------------------------------------

                ; разбивка полёта на 4 части
                LD A, (IX + FUnit.Animation)
                SUB #40
                JR C, .FirstQuarter                                             ; первая четверть полёта
                SUB #80
                JR C, .Landing                                                  ; свободный полёт, без тени

.FourthQuarter  ; последняя четверть полёта
                INC A
                NEG

.FirstQuarter   ; первая четверть полёта
                LD L, A
                AND #3F
                LD (GameAnim.OffsetY), A

                ; расчёт кадра анимации шасси
                LD A, L
                RRA
                RRA
                RRA
                AND 7
                ADD A, -5                                                       ; \
                JR NC, $+3                                                      ;  \  max clamp 5
                SBC A, A                                                        ;  /
                ADD A, 5                                                        ; /
                LD (GameAnim.Element_1), A
                
                ; расчёт кадра анимации тени
                SUB 1
                ADC A, #00
                LD (GameAnim.Element_2), A

                ; отображение тени
                LD HL, Shadow
                CALL DrawComposite

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

                ; проверка что шаттл приземлился и виден полностью на экране
                UNIT_IsMove (IX + FUnit.State)
                RET NZ                                                          ; выход, если шаттл движется
                LD A, (GameFlags.SpriteCounter)
                INC A
                ; JR NZ, $														 ; остановка, если шаттл виден полностью и приземлился
                RET


.Table          include "Core/Module/Tables/Graphics/Shuttle/Data.inc"

                display " - Draw Unit Shuttle : \t\t\t\t", /A, DrawShuttle, " = busy [ ", /D, $ - DrawShuttle, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_UNIT_SHUTTLE_
