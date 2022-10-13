
                ifndef _MODULE_GAME_RENDER_UNITS_
                define _MODULE_GAME_RENDER_UNITS_
; -----------------------------------------
; отображение юнитов
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawUnits:      ; инициализация
                SET_PAGE_UNIT                                                   ; включить страницу работы с юнитами

.Array          EQU $+1
                LD A, #00
                OR A
                RET Z                                                           ; выход, если массив пуст

                LD HL, SortBuffer
                LD B, A

.Loop           PUSH BC
                LD A, (HL)
                AND %11100000
                LD IXL, A
                INC HL
                LD A, (HL)
                LD IXH, A
                INC HL
                PUSH HL

                CALL DrawUnit
                
                POP HL
                POP BC
                DJNZ .Loop

                RET

                endif ; ~_MODULE_GAME_RENDER_UNITS_
