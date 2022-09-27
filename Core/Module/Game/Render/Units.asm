
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
                LD IX, Adr.Unit

                ; проверка на наличие юнитов в массиве
                LD A, (GameAI.UnitArraySize)
                OR A
                JR Z, .Exit
                
.Loop           LD (.ProcessedUnits), A
                CALL DrawUnit

.ProcessedUnits EQU $+1
                LD A, #00
                DEC A
                JR NZ, .Loop

.Exit           RET

                endif ; ~_MODULE_GAME_RENDER_UNITS_
