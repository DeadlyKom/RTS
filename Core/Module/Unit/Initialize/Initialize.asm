
                ifndef _CORE_MODULE_UNIT_INITIALIZE_CORE_
                define _CORE_MODULE_UNIT_INITIALIZE_CORE_
; -----------------------------------------
; инициализация ядра работы с юнитами
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Core:           ; очистка массива юнитов
                LD HL, Adr.Unit.Array + Size.Unit.Array
                LD DE, #FFFF
                CALL SafeFill.b4096
                
                ; инициализация дополнительных массива
                CALL Game.Unit.Utils.ChunkArray.Initialize
 
                RET

                display " - Initialize Core Units: \t\t\t", /A, Core, " = busy [ ", /D, $ - Core, " bytes  ]"

                endif ; ~ _CORE_MODULE_UNIT_INITIALIZE_CORE_
