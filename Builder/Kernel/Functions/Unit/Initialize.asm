
                ifndef _BUILDER_KERNEL_MODULE_UNIT_INITIALIZE_
                define _BUILDER_KERNEL_MODULE_UNIT_INITIALIZE_
; -----------------------------------------
; инициализация ядра работы с юнитами
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
InitializeUnit: ; сохранеие текущей страницы
                LD A, (MemoryPageRef)
                LD (.RestoreMemPage), A

                ; инициализация
                SET_PAGE_UNIT                                                   ; включить страницу работы с юнитами
                CALL Game.Unit.Initialize.Core
                
                ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

                display "\t - Initialize Core Units : \t\t", /A, InitializeUnit, " = busy [ ", /D, $ - InitializeUnit, " bytes  ]"

                endif ; ~ _BUILDER_KERNEL_MODULE_UNIT_INITIALIZE_
