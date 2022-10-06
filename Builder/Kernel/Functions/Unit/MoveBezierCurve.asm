
                ifndef _BUILDER_KERNEL_MODULE_UNIT_MOVE_BEZIER_CURVE_
                define _BUILDER_KERNEL_MODULE_UNIT_MOVE_BEZIER_CURVE_
; -----------------------------------------
; перемещение юнитов по кривой Безье
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MoveUnitsCurve: ; сохранеие текущей страницы
                LD A, (MemoryPageRef)
                LD (.RestoreMemPage), A

                ; инициализация
                SET_PAGE_UNIT                                                   ; включить страницу работы с юнитами
                CALL Game.Unit.Move.BezierCurve
                
                ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

                display "\t - Move Units along curve : \t\t\t", /A, MoveUnitsCurve, " = busy [ ", /D, $ - MoveUnitsCurve, " bytes  ]"

                endif ; ~ _BUILDER_KERNEL_MODULE_UNIT_MOVE_BEZIER_CURVE_
