
                ifndef _CORE_MODULE_DRAW_MONOCHROME_DRAW_CHAR_FROM_STRING_
                define _CORE_MODULE_DRAW_MONOCHROME_DRAW_CHAR_FROM_STRING_

                module Monochrome
; -----------------------------------------
; отображение символа из строки на экран
; In:
;   HL - адрес строки
;   DE - координаты в пикселях (D - y, E - x)
;   A' - смещение в строке
; Out:
;   B  - ширина символа
; Corrupt:
; Note:
; -----------------------------------------
DrawCharToScr:  ; добавление смещение к строке
                EX AF, AF'
                LD C, A
                LD B, #00
                ADD HL, BC

                ; чтение символа
                LD A, (HL)
                OR A
                RET Z                                                           ; выход если конец строки

                DEC A

                ; расчёт адреса спрайта символа
                LD C, A
                ADD A, A
                LD L, A
                LD H, B
                ADD HL, BC
                LD BC, ASCII_Info
                ADD HL, BC

                ; чтение данных о символе
                LD B, (HL)                                                      ; size (height/width)
                INC HL

                ; расчёт адреса спрайта символа
                LD A, (HL)                                                      ; high address
                PUSH AF
                INC HL
                LD L, (HL)                                                      ; low address
                OR #C0
                LD H, A

                ; расчёт адреса экрана
                PUSH DE
                ;
                LD A, B
                AND #0F
                INC A
                ADD A, E
                LD E, A
                ;
                EXX
                POP DE
                POP AF
                RLCA
                RLCA
                AND #03
                ADD A, D
                LD D, A
                CALL PixelAddressP                                              ; DE - адрес экрана
                LD C, E                                                         ; сохранение смещения по горизонтали
                RES 7, D                                                        ; коррекция адреса основного экрана
                JP Z, .NotShift                                                 ; нет смещения
                
                LD B, A
                ; расчёт адреса таблицы смещения
                DEC A
                ADD A, A
                ADD A, HIGH ShiftTable
                LD H, A
                LD A, B
                EXX
                LD C, A

                ; A = отрицательная ширина символа
                LD A, B
                AND #0F
                CP #09
                JR C, $+3
                ADD A, A
                ADD A, C
                NEG
                LD C, A

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

                LD A, (DE)
                OR (HL)
                LD (DE), A
                
                DEC H

                EX AF, AF'
                ADD A, #08
                JP P, .NextRow
                EX AF, AF'

                EXX
                INC HL

                JP .RowLoop

.NextRow        LD E, C                                                         ; востановление смещения по горизонтали

                ; classic method "DOWN_DE" 25/59
                INC D
                LD A, D
                AND #07
                JP NZ, $+13
                LD A, E
                SUB #E0
                LD E, A
                LD C, A                                                         ; сохранение смещения по горизонтали
                SBC A, A
                AND #F8
                ADD A, D
                LD D, A

                EXX

                LD A, B
                SUB #10
                RET C
                LD B, A

                INC HL
                LD A, C
                JP .ColumLoop

.NotShift:      EXX
                LD A, B
                AND #0F
                NEG
                LD C, A

.ColumLoopNS    EX AF, AF'

.RowLoopNS      LD A, (HL)
                EXX
                LD L, A
                LD A, (DE)
                OR L
                LD (DE), A

                EX AF, AF'
                ADD A, #08
                JP P, .NextRowNS
                EX AF, AF'

                INC E
                EXX
                INC HL

                JP .RowLoopNS

.NextRowNS      LD E, C                                                         ; востановление смещения по горизонтали

                ; classic method "DOWN_DE" 25/59
                INC D
                LD A, D
                AND #07
                JP NZ, $+13
                LD A, E
                SUB #E0
                LD E, A
                LD C, A                                                         ; сохранение смещения по горизонтали
                SBC A, A
                AND #F8
                ADD A, D
                LD D, A

                EXX

                LD A, B
                SUB #10
                RET C
                LD B, A

                INC HL
                LD A, C
                JP .ColumLoopNS

                display " - Draw Char : \t\t", /A, DrawCharToScr, " = busy [ ", /D, $ - DrawCharToScr, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_MONOCHROME_DRAW_CHAR_FROM_STRING_
