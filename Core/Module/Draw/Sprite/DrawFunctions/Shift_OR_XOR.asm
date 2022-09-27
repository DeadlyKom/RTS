
                ifndef _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_SHIFT_
                define _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_SHIFT_
Begin_Shift:    EQU $
; -----------------------------------------
;
; In:
;   SP  - адрес спрайта
;   HL  - адрес экрана вывода (копия)
;   DE  - адрес экрана вывода
;   B   - количество строк в знакоместе
;   C   - количество отображаемых строк
;   H'  - старший байт адреса таблицы сдвига
; Out:
; Corrupt:
; Note:
; -----------------------------------------

Shift_OX_1_P:   ; подготовка для правого полубайта
                EXX
                POP BC
                EXX
                JP Shift_OX_1_R
Shift_OX_2_P:   ; подготовка для 1 полного байта
                LD A, (DE)
                EXX
                JP Shift_OX_2.R
Shift_OX_3_P:   ; подготовка для 2 полных байтов
                LD A, (DE)
                EXX
                JP Shift_OX_3.R
Shift_OX_4_P:   ; подготовка для 3 полных байтов
                LD A, (DE)
                EXX
                JP Shift_OX_4.R
Shift_OX_5:     ; 4 полных байта
                LD A, (DE)

                EXX
                POP BC
                LD L, C 
                OR (HL)
                LD L, B
                XOR (HL)
                EXX

                LD (DE), A
                INC E
Shift_OX_4:     LD A, (DE)

                EXX
                INC H
                LD L, C
                OR (HL)
                LD L, B
                XOR (HL)
                DEC H

.R              POP BC
                LD L, C 
                OR (HL)
                LD L, B
                XOR (HL)
                EXX

                LD (DE), A
                INC E
Shift_OX_3:     LD A, (DE)

                EXX
                INC H
                LD L, C
                OR (HL)
                LD L, B
                XOR (HL)
                DEC H

.R              POP BC
                LD L, C 
                OR (HL)
                LD L, B
                XOR (HL)
                EXX

                LD (DE), A
                INC E
Shift_OX_2:     LD A, (DE)

                EXX
                INC H
                LD L, C
                OR (HL)
                LD L, B
                XOR (HL)
                DEC H

.R              POP BC
                LD L, C 
                OR (HL)
                LD L, B
                XOR (HL)
                EXX

                LD (DE), A
                INC E
Shift_OX_1_R:   ; правая половина байта
                LD A, (DE)

                EXX
                INC H
                LD L, C
                OR (HL)
                LD L, B
                XOR (HL)
                DEC H
                EXX

                LD (DE), A

; NextRow:      ; новая строка
                DEC C
                JR Z, Kernel.Sprite.Draw.Exit                                   ; JR для этого типа вывода
                INC D
                DJNZ .NextRow

                LD B, #08
                LD A, L
                ADD A, #20
                LD L, A
                JR C, .NextBoundary
                LD D, H                                                         ; восстановление адреса экрана
                LD E, L
                JP (IY)

.NextBoundary   LD H, D                                                         ; сохранение старший байт адреса экрана
.NextRow        LD E, L                                                         ; восстановление младший байт фдреса экрана
                JP (IY)

TableShift:
.OX_8           DW Shift_OX_1_P, Shift_OX_1_P                                   ; правый полубайт
                ; DW общий c OX_8
.OX_16          DW Shift_OX_2_P, Shift_OX_2_P                                   ; 1 полный байт
                DW 0, 0

                DW 0, 0
                DW 0, 0
.OX_24          DW Shift_OX_3_P, Shift_OX_3_P                                   ; 2 полных байта
                DW 0, 0
                DW 0, 0

                DW 0, 0
                DW 0, 0
                DW 0, 0
.OX_32          DW Shift_OX_4_P, Shift_OX_4_P                                   ; 3 полных байта
                DW 0, 0
                DW 0, 0
                DW 0, 0

                DW 0, 0
                DW 0, 0
                DW 0, 0
                DW 0, 0
.OX_40          DW Shift_OX_5, Shift_OX_5                                       ; 4 полных байта
                DW 0, 0
                DW 0, 0
                DW 0, 0
                DW 0, 0

                display " - Draw Function 'Shift OR & XOR': \t", /A, Begin_Shift, " = busy [ ", /D, $ - Begin_Shift, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_SHIFT_
