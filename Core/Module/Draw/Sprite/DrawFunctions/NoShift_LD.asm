
                ifndef _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_NO_SHIFT_LD_
                define _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_NO_SHIFT_LD_

                module LD
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

NoShiftLR:
._LD_XXX_X      INC SP
._LD_XX_X       INC SP
._LD_X_X        INC SP
                JP NoShift._LD_X
._LD_XX_XX      INC SP
._LD_X_XX       INC SP
                JP NoShift._LD_XX
._LD_X_XXX      INC SP
                JP NoShift._LD_XXX
NoShift:
._LD_XXXX       DEC SP
                POP AF
                LD (DE), A
                INC E

._LD_XXX        DEC SP
                POP AF
                LD (DE), A
                INC E

._LD_XX         DEC SP
                POP AF
                LD (DE), A
                INC E

._LD_X          DEC SP
                POP AF
                LD (DE), A

; NextRow:        ; новая строка
                DEC C
                JP Z, Kernel.Function.Exit
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
.NextRow        LD E, L                                                         ; восстановление младший байт адреса экрана
                JP (IY)

TableNoShift:
.LD_8           DW NoShift._LD_X,       NoShift._LD_X                           ;  1.0

                DW NoShiftLR._LD_X_X,   NoShiftLR._LD_X_X                       ; -1.0
.LD_16          DW NoShift._LD_XX,      NoShift._LD_XX                          ;  2.0
                DW NoShift._LD_X,       NoShiftLR._LD_X_X                       ; +1.0

                DW NoShiftLR._LD_XX_X,  NoShiftLR._LD_XX_X                      ; -2.0
                DW NoShiftLR._LD_X_XX,  NoShiftLR._LD_X_XX                      ; -1.0
.LD_24          DW NoShift._LD_XXX,     NoShift._LD_XXX
                DW NoShift._LD_XX,      NoShiftLR._LD_X_XX                      ; +1.0
                DW NoShift._LD_X,       NoShiftLR._LD_XX_X                      ; +2.0

                DW NoShiftLR._LD_XXX_X, NoShiftLR._LD_XXX_X                     ; -3.0
                DW NoShiftLR._LD_XX_XX, NoShiftLR._LD_XX_XX                     ; -2.0
                DW NoShiftLR._LD_X_XXX, NoShiftLR._LD_X_XXX                     ; -1.0
.LD_32          DW NoShift._LD_XXXX,    NoShift._LD_XXXX
                DW NoShift._LD_XXX,     NoShiftLR._LD_X_XXX                     ; +1.0
                DW NoShift._LD_XX,      NoShiftLR._LD_XX_XX                     ; +2.0
                DW NoShift._LD_X,       NoShiftLR._LD_XXX_X                     ; +3.0

                display " - Draw Function 'No Shift LD' : \t\t\t", /A, Begin_NoShift, " = busy [ ", /D, $ - Begin_NoShift, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_NO_SHIFT_LD_
