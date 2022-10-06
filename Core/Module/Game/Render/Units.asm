
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

                LD DE, .Buffer
                CALL Functions.VisibleUnits                                     ; получение массив видимых юнитов (отсортерован по вертикали)
                RET C                                                           ; выход, если массив пуст

                LD B, D
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



;                 LD IX, Adr.Unit.Array
;                 ; проверка на наличие юнитов в массиве
;                 LD A, (GameAI.UnitArraySize)
;                 OR A
;                 JR Z, .Exit
; .Loop           LD (.ProcessedUnits), A
;                 CALL DrawUnit
;                 ; следующий элемент
;                 LD DE, UNIT_SIZE
;                 ADD IX, DE
; .ProcessedUnits EQU $+1
;                 LD A, #00
;                 DEC A
;                 JR NZ, .Loop
; .Exit           
                RET

.Buffer         DS 10, 0

                endif ; ~_MODULE_GAME_RENDER_UNITS_
