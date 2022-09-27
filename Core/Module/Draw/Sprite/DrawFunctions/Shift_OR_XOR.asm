
                ifndef _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_SHIFT_
                define _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_SHIFT_
Begin_Shift:    EQU $
; -----------------------------------------
;
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
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

Shift_OX_4      LD A, (DE)

                EXX
                POP BC
                OR C
                XOR B
                EXX

                LD (DE), A
                INC E
hift_OX_3       LD A, (DE)

                EXX
                POP BC
                OR C
                XOR B
                EXX

                LD (DE), A
                INC E
Shift_OX_2      LD A, (DE)

                EXX
                POP BC
                OR C
                XOR B
                EXX

                LD (DE), A
                INC E
Shift_OX_1      LD A, (DE)

                EXX
                POP BC
                OR C
                XOR B
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

                display " - Draw Function 'Shift OR & XOR': \t", /A, Begin_Shift, " = busy [ ", /D, $ - Begin_Shift, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_SPRITE_DRAW_FUNCTION_SHIFT_
