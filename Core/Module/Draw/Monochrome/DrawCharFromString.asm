
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

                ; -----------------------------------------
                ; расчёт адреса спрайта символа
                ; -----------------------------------------
                LD A, (HL)                                                      ; high address
                PUSH AF
                INC HL
                LD L, (HL)                                                      ; low address
                OR #C0
                LD H, A

                ; -----------------------------------------
                ; корректировка символа по высоте
                ; -----------------------------------------
                POP AF
                RLCA
                RLCA
                AND #03
                ADD A, D
                LD D, A

                ;
                LD A, B
                AND #0F
                LD C, A
                PUSH AF
                LD A, B
                RRA
                RRA
                RRA
                RRA
                AND #0F
                INC A
                LD B, A
                

                ; -----------------------------------------
                ; отрисовка спрайта без атрибутами
                ; In:
                ;   HL - адрес спрайта
                ;   DE - координаты в пикселях (D - y, E - x)
                ;   BC - размер (B - y, C - x)
                ; Out:
                ; Corrupt:
                ; Note:
                ; -----------------------------------------
                CALL DrawSpriteMono
                POP BC
                RET

                display " - Draw Char : \t\t", /A, DrawCharToScr, " = busy [ ", /D, $ - DrawCharToScr, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_MONOCHROME_DRAW_CHAR_FROM_STRING_
