
                ifndef _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_SHIFT_LD_
                define _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_SHIFT_LD_

                module LD
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
                DEC SP
                POP BC
                LD L, #FF
                INC H
                AND (HL)
                DEC H
                LD L, B
                OR (HL)
                EXX
                LD (DE), A
                INC E
                JP Shift_OX_oOOO_x
._xXx           ;  2.0 байт
                LD A, (DE)
                EXX
                POP BC
                LD L, #FF
                INC H
                AND (HL)
                DEC H
                LD L, C
                OR (HL)
                EXX
                LD (DE), A
                INC E
                JP Shift_OX_oOO_Xx
._xXXx          ;  3.0 байт
                LD A, (DE)
                EXX
                DEC SP
                POP BC
                LD L, #FF
                INC H
                AND (HL)
                DEC H
                LD L, B
                OR (HL)
                EXX
                LD (DE), A
                INC E
                JP Shift_OX_oO_XXx
Shift_OX_Left:
._x_XXXx        ; -0.5 байт
                EXX
                POP BC
                LD L, C
                EXX
                JP Shift_OX_o_XXXx
._xX_XXx        ; -1.5 байт
                INC SP
._x_XXx         ; -0.5 байт
                EXX
                DEC SP
                POP BC
                LD L, B
                EXX
                JP Shift_OX_oO_XXx
._xXX_Xx        ; -2.5 байт
                INC SP
._xX_Xx         ; -1.5 байт
                INC SP
._x_Xx          ; -0.5 байт
                EXX
                POP BC
                LD L, C
                EXX
                JP Shift_OX_oOO_Xx
._xXXX_x        ; -3.5 байт
                INC SP
._xXX_x         ; -2.5 байт
                INC SP
._xX_x          ; -1.5 байт
                INC SP
._x_x           ; -0.5 байт
                EXX
                DEC SP
                POP BC
                EXX
                JP Shift_OX_oOOO_x
Shift_OX_xXXXx  ;  4.0 байт
                LD A, (DE)
                EXX
                POP BC
                LD L, #FF
                INC H
                AND (HL)
                DEC H
                LD L, C
                OR (HL)
                EXX
                LD (DE), A
                INC E
Shift_OX_o_XXXx EXX
                INC H
                LD A, (HL)
                DEC H
                LD L, B
                OR (HL)
                EXX
                LD (DE), A
                INC E
Shift_OX_oO_XXx EXX
                INC H
                LD A, (HL)
                DEC H
                POP BC
                LD L, C
                OR (HL)
                EXX
                LD (DE), A
                INC E
Shift_OX_oOO_Xx EXX
                INC H
                LD A, (HL)
                DEC H
                LD L, B
                OR (HL)
                EXX
                LD (DE), A
                INC E
Shift_OX_oOOO_x LD A, (DE)
                EXX
                LD L, #FF
                AND (HL)
                INC H
                LD L, B
                OR (HL)
                DEC H
                EXX
                LD (DE), A
NextRow:        ; новая строка
                DEC C
                JP Z, Kernel.Sprite.Draw.Exit                                   ; JR для этого типа вывода
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
._xXX_Xx_       ; +1.5 байт
                INC SP
._xXX_Xx        ; +1.5 байт
._xXX_x         ; +1.5 байт
                LD A, (DE)
                EXX
                DEC SP
                POP BC
                LD L, #FF
                INC H
                AND (HL)
                DEC H
                LD L, B
                OR (HL)
                EXX
                LD (DE), A
                INC E
                JP ._xXX_x_
._xX_XXx_       ; +2.5 байт
                INC SP
._xX_Xx_        ; +1.5 байт
                INC SP
._xX_XXx        ; +2.5 байт
._xX_Xx         ; +1.5 байт
._xX_x          ; +0.5 байт
                LD A, (DE)
                EXX
                POP BC
                LD L, #FF
                INC H
                AND (HL)
                DEC H
                LD L, C
                OR (HL)
                EXX
                LD (DE), A
                INC E
                JP ._xX_x_
._xXXX_x        ; +0.5 байт
                LD A, (DE)
                EXX
                POP BC
                LD L, #FF
                INC H
                AND (HL)
                DEC H
                LD L, C
                OR (HL)
                EXX
                LD (DE), A
                INC E

._xXXX_x_       EXX
                INC H
                LD A, (HL)
                DEC H
                LD L, B
                OR (HL)
                EXX
                LD (DE), A
                INC E

._xXX_x_        EXX
                INC H
                LD A, (HL)
                DEC H
                POP BC
                LD L, C
                OR (HL)
                EXX
                LD (DE), A
                INC E

._xX_x_         EXX
                INC H
                LD A, (HL)
                DEC H
                LD L, B
                OR (HL)
                EXX
                LD (DE), A
                JP NextRow
._x_XXXx_       ; +3.5 байт
                INC SP
._x_XXx_        ; +2.5 байт
                INC SP
._x_Xx_         ; +1.5 байт
                INC SP
._x_x           ; +0.5 байт
._x_Xx          ; +1.5 байт
._x_XXx         ; +2.5 байт
._x_XXXx        ; +3.5 байт
                LD A, (DE)
                EXX
                DEC SP
                POP BC
                LD L, #FF
                INC H
                AND (HL)
                DEC H
                LD L, B
                OR (HL)
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

                DW Shift_OX_Left._xXX_x,    Shift_OX_Left._xXX_x                ; -2.5 байт
                DW Shift_OX_Left._xX_Xx,    Shift_OX_Left._xX_Xx                ; -1.5 байт
                DW Shift_OX_Left._x_XXx,    Shift_OX_Left._x_XXx                ; -0.5 байт
.OX_24          DW Shift_OX._xXXx,          Shift_OX._xXXx                      ;  3.0 байт
                DW Shift_OX_Right._xXX_x,   Shift_OX_Right._xXX_x               ; +0.5 байт
                DW Shift_OX_Right._xX_Xx,   Shift_OX_Right._xX_Xx_              ; +1.5 байт
                DW Shift_OX_Right._x_XXx,   Shift_OX_Right._x_XXx_              ; +2.5 байт

                DW Shift_OX_Left._xXXX_x,   Shift_OX_Left._xXXX_x               ; -3.5 байт
                DW Shift_OX_Left._xXX_Xx,   Shift_OX_Left._xXX_Xx               ; -2.5 байт
                DW Shift_OX_Left._xX_XXx,   Shift_OX_Left._xX_XXx               ; -1.5 байт
                DW Shift_OX_Left._x_XXXx,   Shift_OX_Left._x_XXXx               ; -0.5 байт
.OX_32          DW Shift_OX_xXXXx,          Shift_OX_xXXXx                      ;  4.0 байт
                DW Shift_OX_Right._xXXX_x,  Shift_OX_Right._xXXX_x              ; +0.5 байт
                DW Shift_OX_Right._xXX_Xx,  Shift_OX_Right._xXX_Xx_             ; +1.5 байт
                DW Shift_OX_Right._xX_XXx,  Shift_OX_Right._xX_XXx_             ; +2.5 байт
                DW Shift_OX_Right._x_XXXx,  Shift_OX_Right._x_XXXx_             ; +3.5 байт

                display " - Draw Function 'Shift LD' : \t\t\t", /A, Begin_Shift, " = busy [ ", /D, $ - Begin_Shift, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_SHIFT_LD_
