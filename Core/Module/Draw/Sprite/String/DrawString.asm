
                ifndef _CORE_MODULE_DRAW_STRING_
                define _CORE_MODULE_DRAW_STRING_

                module Monochrome
; -----------------------------------------
; отображение строки в буфер (Требует ОПТИМИЗАЦИИ)
; In:
;   HL - адрес строки
; Out:
;   С  - длина строки в пикселях
; Corrupt:
; Note:
; -----------------------------------------
DrawString:     ; очистка общего буфера
                EXX
                LD HL, SharedBuffer + 0x100
                LD DE, #0000
                CALL SafeFill_256
                EXX

                ; смещение в буфере (попиксельно)
                LD C, #00

.Custom         ;
                LD A, C
                OR A
                JR Z, .NotAlign

                PUSH HL
                CALL StringLength
                POP HL

.NotAlign       ; вывод строки без очистки буфера + задаётся своё смещение в регистре C
                EXX
                LD D, HIGH SharedBuffer
                EXX

.StringLoop     LD A, (HL)
                OR A
                RET Z

                DEC A

                INC HL
                PUSH HL

.AddChar        ; расчёт адреса спрайта символа
                LD E, A
                ADD A, A
                LD L, A
                LD H, #00
                LD D, H
                ADD HL, DE
                LD DE, ASCII_Info
                ADD HL, DE

                ; чтение данных о символе
                LD B, (HL)                                                      ; size (height/width)
                INC HL

                ; расчёт адреса спрайта символа
                LD E, (HL)                                                      ; high address
                INC HL
                LD L, (HL)                                                      ; low address
                LD A, E
                OR #C0
                LD H, A

                ; расчёт адреса в буфере
                LD A, C
                RRA
                RRA
                RRA
                SRL E
                XOR E
                AND %00011111
                XOR E
                EXX
                LD E, A
                LD C, A
                EXX

                ; перенос спрайта в буфер
                LD A, C
                AND #07
                LD E, A
                JP Z, NotShift                                                  ; нет смещения

                ; расчёт адреса таблицы смещения
                EXX
                DEC A
                ADD A, A
                ADD A, HIGH ShiftTable
                LD H, A
                EXX

                LD A, B
                AND #0F
                CP #09
                JR C, $+3
                ADD A, A
                ADD A, E
                NEG
                LD E, A

.ColumLoop      EX AF, AF'

.RowLoop        LD A, (HL)
                EXX
                LD L, A
                LD A, (DE)
                OR (HL)
                LD (DE), A

                EX AF, AF'
                ADD A, #08
                JP P, .NextRow
                EX AF, AF'

                INC H
                INC E

                ; LD A, (DE)
                ; OR (HL)
                LD A, (HL)
                LD (DE), A

                DEC H

                EX AF, AF'
                ADD A, #08
                JP P, .NextRow
                EX AF, AF'

                EXX
                INC HL

                JP .RowLoop

.NextRow        LD A, C
                ADD A, #20
                LD C, A
                LD E, A
                EXX

                LD A, B
                SUB #10
                JR C, .RET
                LD B, A

                INC HL
                LD A, E
                JP .ColumLoop

.RET            POP HL

                LD A, B
                ADD A, C
                LD C, A
                INC C   ; 1 пиксель между символами
                JP .StringLoop
NotShift:       LD A, B
                AND #0F
                ADD A, E
                NEG
                LD E, A

.ColumLoop      EX AF, AF'

.RowLoop        LD A, (HL)
                EXX
                LD L, A
                LD A, (DE)
                OR L
                LD (DE), A

                EX AF, AF'
                ADD A, #08
                JP P, .NextRow
                EX AF, AF'

                INC E
                EXX
                INC HL

                JP .RowLoop

.NextRow        LD A, C
                ADD A, #20
                LD C, A
                LD E, A
                EXX

                LD A, B
                SUB #10
                JP C, DrawString.RET
                LD B, A

                INC HL
                LD A, E
                JP .ColumLoop

                display " - Draw String to Buffer : \t\t", /A, DrawString, " = busy [ ", /D, $ - DrawString, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_STRING_
