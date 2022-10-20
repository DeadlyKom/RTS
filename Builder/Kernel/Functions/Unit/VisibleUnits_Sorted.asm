
                ifndef _BUILDER_KERNEL_MODULE_UNIT_VISIBLE_UNITS_SORTED_
                define _BUILDER_KERNEL_MODULE_UNIT_VISIBLE_UNITS_SORTED_
; -----------------------------------------
; получение массив видимых юнитов (отсортерован по вертикали)
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
VisibleUnits:   ; сохранеие текущей страницы
                LD A, (MemoryPageRef)
                LD (.RestoreMemPage), A

                ; инициализация
                SET_PAGE_UNIT                                                   ; включить страницу работы с юнитами
                CALL Game.Unit.Utils.GetVisible
                
                ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

                display "\t - Visible Unit (SORTED) : \t\t\t", /A, FlyToUnit, " = busy [ ", /D, $ - FlyToUnit, " bytes  ]"

                endif ; ~ _BUILDER_KERNEL_MODULE_UNIT_VISIBLE_UNITS_SORTED_
