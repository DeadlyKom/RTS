
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


Shift_OX_xx     ;  1.0 байт
                LD A, (DE)
                EXX
                JP Shift_OX_oOO_Xx.R
Shift_OX_x_Xx   ; -0.5 байт
                EXX
                POP BC
                EXX
                JP Shift_OX_oOO_Xx
Shift_OX_xX_x   ; -1.5 байт
                POP AF
Shift_OX_x_x    ; -0.5 байт
                EXX
                POP BC
                EXX
                JP Shift_OX_oOOO_x
Shift_OX_xXx    ;  2.0 байт
                LD A, (DE)
                EXX
                JP Shift_OX_oO_XXx.R
Shift_OX_xXXx   ;  3.0 байт
                LD A, (DE)
                EXX
                JP Shift_OX_o_XXXx.R
Shift_OX_xXXXx  ;  4.0 байт
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
Shift_OX_o_XXXx ;
                LD A, (DE)

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
Shift_OX_oO_XXx ;
                LD A, (DE)

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
Shift_OX_oOO_Xx LD A, (DE)

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
Shift_OX_oOOO_x ; правая половина байта
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
                DW Shift_OX_x_x,    Shift_OX_x_x                                ; -0.5 байт
.OX_8           DW Shift_OX_xx,     Shift_OX_xx                                 ;  1.0 байт
                DW 0, 0

                DW Shift_OX_xX_x,   Shift_OX_xX_x                               ; -1.5 байт
                DW Shift_OX_x_Xx,   Shift_OX_x_Xx                               ; -0.5 байт
.OX_16          DW Shift_OX_xXx,    Shift_OX_xXx                                ;  2.0 байт
                DW 0, 0                                                         ;               OX_2_Xx_x
                DW 0, 0                                                         ;               OX_2_x_xX

                DW 0, 0
                DW 0, 0
                DW 0, 0
.OX_24          DW Shift_OX_xXXx,   Shift_OX_xXXx                               ;  3.0 байт
                DW 0, 0
                DW 0, 0
                DW 0, 0

                DW 0, 0
                DW 0, 0
                DW 0, 0
                DW 0, 0
.OX_32          DW Shift_OX_xXXXx,  Shift_OX_xXXXx                              ;  4.0 байт
                DW 0, 0
                DW 0, 0
                DW 0, 0
                DW 0, 0

                display " - Draw Function 'Shift OR & XOR': \t", /A, Begin_Shift, " = busy [ ", /D, $ - Begin_Shift, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_SHIFT_
