
                ifndef _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_NO_SHIFT_
                define _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_NO_SHIFT_
Begin_NoShift:  EQU $
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

NoShift_OX_X_X  POP AF
                JP NoShift_OX_X

NoShift_OX_4    LD A, (DE)

                EXX
                POP BC
                OR C
                XOR B
                EXX

                LD (DE), A
                INC E
NoShift_OX_3    LD A, (DE)

                EXX
                POP BC
                OR C
                XOR B
                EXX

                LD (DE), A
                INC E
NoShift_OX_XX   LD A, (DE)

                EXX
                POP BC
                OR C
                XOR B
                EXX

                LD (DE), A
                INC E
NoShift_OX_X    LD A, (DE)

                EXX
                POP BC
                OR C
                XOR B
                EXX

                LD (DE), A


; NextRow:      ; новая строка
                DEC C
                JP Z, Kernel.Sprite.Draw.Exit                                   ; JP для этого типа вывода
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

TableNoShift:
.OX_8           DW NoShift_OX_X,    NoShift_OX_X                                ;  1.0

                DW NoShift_OX_X_X,  NoShift_OX_X_X                              ; -1.0
.OX_16          DW NoShift_OX_XX,   NoShift_OX_XX                               ;  2.0
                DW NoShift_OX_X,    NoShift_OX_X_X                              ; +1.0

                DW 0, 0
                DW 0, 0
.OX_24          DW NoShift_OX_3, NoShift_OX_3
                DW 0, 0
                DW 0, 0

                DW 0, 0
                DW 0, 0
                DW 0, 0
.OX_32          DW NoShift_OX_4, NoShift_OX_4
                DW 0, 0
                DW 0, 0
                DW 0, 0

                display " - Draw Function 'No Shift OR & XOR':\t", /A, Begin_NoShift, " = busy [ ", /D, $ - Begin_NoShift, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_NO_SHIFT_
