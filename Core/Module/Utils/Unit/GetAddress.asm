
                ifndef _CORE_MODULE_UTILS_GET_ADDRESS_UNIT_
                define _CORE_MODULE_UTILS_GET_ADDRESS_UNIT_
; -----------------------------------------
; получить адрес юнита
; In:
;   A  - индекс юнита
; Out:
;   IX - адрес юнита в массиве
; Corrupt:
; Note:
; -----------------------------------------
GetAddress:     ; расчёт смещения по индексу юнита
                LD HL, .Value
                LD (HL), A
                XOR A
                RLD
                RL (HL)
                ADC A, A
                OR #C0
                LD IXH, A
                LD A, (HL)
                LD IXL, A

                ; портит регистр E
                ; OR A
                ; RRA
                ; LD E, #00
                ; RR E
                ; RRA
                ; RR E
                ; RRA
                ; RR E
                ; OR #C0
                ; LD IXH, A
                ; LD A, E
                ; LD IXL, A

                RET

.Value          DB #00

                endif ; ~ _CORE_MODULE_UTILS_GET_ADDRESS_UNIT_