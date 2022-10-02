
                ifndef _BUILDER_KERNEL_MODULE_UNIT_FLY_TO_
                define _BUILDER_KERNEL_MODULE_UNIT_FLY_TO_
; -----------------------------------------
; инициализация полёта юнита
; In:
;   HL - начальная позици (H - y, L - x)
;   DE - конечная позиция (D - y, E - x)
;   A' - номер юнита
; Out:
; Corrupt:
; Note:
; -----------------------------------------
FlyToUnit:      ; сохранеие текущей страницы
                LD A, (MemoryPageRef)
                LD (.RestoreMemPage), A

                ; инициализация
                SET_PAGE_UNIT                                                   ; включить страницу работы с юнитами
                CALL Game.Unit.Initialize.FlyTo
                
                ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

                display "\t - FlyTo Unit : \t\t", /A, FlyToUnit, " = busy [ ", /D, $ - FlyToUnit, " bytes  ]"

                endif ; ~ _BUILDER_KERNEL_MODULE_UNIT_FLY_TO_
