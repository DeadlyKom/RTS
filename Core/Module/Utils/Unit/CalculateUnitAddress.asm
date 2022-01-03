
                ifndef _CORE_MODULE_UTILS_GET_ADDRESS_UNIT_
                define _CORE_MODULE_UTILS_GET_ADDRESS_UNIT_
; -----------------------------------------
; получить адрес 
; In:
;   A  - индекс юнита
; Out:
;   IX - адрес юнита в массиве
; Corrupt:
; Note:
; -----------------------------------------
GetAdrUnit:     ; расчёт смещения по индексу юнита
                OR #80
                CCF
                RRA
                LD IXH, A
                LD A, #00
                RLA
                LD IXL, A
                
                RET

                endif ; ~ _CORE_MODULE_UTILS_GET_ADDRESS_UNIT_