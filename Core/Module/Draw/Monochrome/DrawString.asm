
                ifndef _CORE_MODULE_DRAW_MONOCHROME_DRAW_STRING_
                define _CORE_MODULE_DRAW_MONOCHROME_DRAW_STRING_

                module Monochrome
; -----------------------------------------
; отображение строки в буфере
; In:
;   HL - адрес текста
; Out:
;   С  - длина строки в пикселах
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
                CALL GetLength
                POP HL

;                 PUSH BC
;                 EXX
;                 POP BC
;                 LD H, HIGH SharedBuffer
;                 LD A, C
;                 RRA
;                 RRA
;                 RRA
;                 AND %0001111
;                 LD L, A
;                 LD C, B
;                 LD A, #08
; .CLS_Column     EX AF, AF'
; .CLS_Row        LD (HL), #00
;                 INC L
;                 DJNZ .CLS_Row
;                 LD B, C
;                 EX AF, AF'
;                 DEC A
;                 JR NZ, .CLS_Column
;                 EXX

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

GetLength:      LD B, #00

.StringLoop     LD A, (HL)
                OR A
                JR NZ, .Next

                LD A, B
                SRL A
                NEG
                ADD A, C
                LD C, A

                ; округление
                LD A, B
                LD B, #00
                RRA
                ADC A, B
                RRA
                ADC A, B
                RRA
                ADC A, B
                AND %00011111
                LD B, A
                RET

.Next           DEC A

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
                LD A, (HL)                                                      ; size (height/width)
                AND #0F
                ADD A, B
                LD B, A
                POP HL
                JR .StringLoop

                display " - Draw String to Buffer : \t", /A, DrawString, " = busy [ ", /D, $ - DrawString, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_MONOCHROME_DRAW_STRING_
