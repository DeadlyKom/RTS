
                ifndef _BUILDER_KERNEL_MODULE_UNIT_MOVE_BEZIER_CURVE_
                define _BUILDER_KERNEL_MODULE_UNIT_MOVE_BEZIER_CURVE_
; -----------------------------------------
; перемещение юнита
; In:
;   A' - номер юнита
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MoveCurveUnit:  ; сохранеие текущей страницы
                LD A, (MemoryPageRef)
                LD (.RestoreMemPage), A

                ; инициализация
                SET_PAGE_UNIT                                                   ; включить страницу работы с юнитами
                CALL Game.Unit.Initialize.FlyTo
                
                ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

                display "\t - Move Bezier Curve : \t\t", /A, FlyToUnit, " = busy [ ", /D, $ - FlyToUnit, " bytes  ]"

                endif ; ~ _BUILDER_KERNEL_MODULE_UNIT_MOVE_BEZIER_CURVE_
