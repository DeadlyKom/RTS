
                ifndef _BUILDER_KERNEL_MODULE_UNIT_
                define _BUILDER_KERNEL_MODULE_UNIT_
; -----------------------------------------
; спавн юнита
; In:
;   DE - позиция юнита  (D - y, E - x)
;   BC - параметры      (B -  , C - тип юнита)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SpawnUnit:      ; сохранеие текущей страницы
                LD A, (MemoryPageRef)
                LD (.RestoreMemPage), A

                ; инициализация
                PUSH BC
                SET_PAGE_UNIT                                                   ; включить страницу работы с юнитами
                POP BC
                CALL Game.Unit.Spawn.Unit

                ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

                display "\t - Spawn Unit : \t\t", /A, SpawnUnit, " = busy [ ", /D, $ - SpawnUnit, " bytes  ]"

                endif ; ~ _BUILDER_KERNEL_MODULE_UNIT_