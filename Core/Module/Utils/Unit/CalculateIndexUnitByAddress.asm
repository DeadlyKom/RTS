
                ifndef _CORE_MODULE_UTILS_GET_INDEX_UNIT_BY_ADDRESS_
                define _CORE_MODULE_UTILS_GET_INDEX_UNIT_BY_ADDRESS_
; -----------------------------------------
; получить индекс юнита используя адрес 
; In:
;   IX - адрес юнита в массиве
; Out:
;   A  - индекс юнита
; Corrupt:
; Note:
; -----------------------------------------
GetIdxUnit:     EXX
                ; расчёт индекса по адресу юнита
                LD HL, GetAdrUnit.Value
                LD A, IXL
                LD (HL), A
                LD A, IXH
                RRD
                LD A, (HL)
                SRL A
                EXX

                RET

                endif ; ~ _CORE_MODULE_UTILS_GET_INDEX_UNIT_BY_ADDRESS_
