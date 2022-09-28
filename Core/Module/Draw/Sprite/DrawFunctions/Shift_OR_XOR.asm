
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

Shift_OX:
._xx            ;  1.0 байт
                LD A, (DE)
                EXX
                JP Shift_OX_oOO_Xx.R
._xXx           ;  2.0 байт
                LD A, (DE)
                EXX
                JP Shift_OX_oO_XXx.R
._xXXx          ;  3.0 байт
                LD A, (DE)
                EXX
                JP Shift_OX_o_XXXx.R
Shift_OX_Left:
._x_Xx          ; -0.5 байт
                EXX
                POP BC
                EXX
                JP Shift_OX_oOO_Xx
._xX_x          ; -1.5 байт
                POP AF
._x_x           ; -0.5 байт
                EXX
                POP BC
                EXX
                JP Shift_OX_oOOO_x
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

NextRow:        ; новая строка
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

Shift_OX_Right:
._xX_x          ; +0.5 байт
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
                LD A, (DE)

                EXX
                INC H
                LD L, C
                OR (HL)
                LD L, B
                XOR (HL)
                DEC H

                POP BC
                LD L, C 
                OR (HL)
                LD L, B
                XOR (HL)
                EXX

                LD (DE), A

                JP NextRow
._x_Xx_         ; +1.5 байт
                POP AF
._x_x           ; +0.5 байт
._x_Xx          ; +1.5 байт
                LD A, (DE)

                EXX
                POP BC
                LD L, C
                OR (HL)
                LD L, B
                XOR (HL)
                EXX
                
                LD (DE), A
                JP NextRow
TableShift:
                DW Shift_OX_Left._x_x,      Shift_OX_Left._x_x                  ; -0.5 байт
.OX_8           DW Shift_OX._xx,            Shift_OX._xx                        ;  1.0 байт
                DW Shift_OX_Right._x_x,     Shift_OX_Right._x_x                 ; +0.5 байт

                DW Shift_OX_Left._xX_x,     Shift_OX_Left._xX_x                 ; -1.5 байт
                DW Shift_OX_Left._x_Xx,     Shift_OX_Left._x_Xx                 ; -0.5 байт
.OX_16          DW Shift_OX._xXx,           Shift_OX._xXx                       ;  2.0 байт
                DW Shift_OX_Right._xX_x,    Shift_OX_Right._xX_x                ; +0.5 байт
                DW Shift_OX_Right._x_Xx,    Shift_OX_Right._x_Xx_               ; +1.5 байт

                DW 0, 0
                DW 0, 0
                DW 0, 0
.OX_24          DW Shift_OX._xXXx,          Shift_OX._xXXx                      ;  3.0 байт
                DW 0, 0
                DW 0, 0
                DW 0, 0

                DW 0, 0
                DW 0, 0
                DW 0, 0
                DW 0, 0
.OX_32          DW Shift_OX_xXXXx,          Shift_OX_xXXXx                      ;  4.0 байт
                DW 0, 0
                DW 0, 0
                DW 0, 0
                DW 0, 0

                display " - Draw Function 'Shift OR & XOR': \t", /A, Begin_Shift, " = busy [ ", /D, $ - Begin_Shift, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_SHIFT_
