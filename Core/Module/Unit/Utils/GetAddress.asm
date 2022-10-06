
                ifndef _CORE_MODULE_UNIT_UTILS_GET_ADDRESS_UNIT_
                define _CORE_MODULE_UNIT_UTILS_GET_ADDRESS_UNIT_
; -----------------------------------------
; получить адрес юнита
; In:
;   A  - индекс юнита
; Out:
;   IX - адрес юнита в массиве
; Corrupt:
;   HL, AF, IX
; Note:
; -----------------------------------------
GetAddress:     ; расчёт смещения по индексу юнита
                LD HL, .Value
                LD (HL), A
                XOR A
                RLD
                RL (HL)
                ADC A, A
                OR HIGH Adr.Unit.Array
                LD IXH, A
                LD A, (HL)
                LD IXL, A

                RET

.Value          DB #00

; -----------------------------------------
; конверсия индекса юнита в адрес юнита
; In:
;   A   - индекс юнита
; Out:
;   Reg - адрес юнита в массиве + Offset
; Corrupt:
;   AF
; Note:
; -----------------------------------------
UNIT_Address:   macro HReg?, LReg?, Offset?
                SRL A
                LD LReg?, Offset?
                RR LReg?
                RRA
                RR LReg?
                RRA
                RR LReg?
                OR #C0
                LD HReg?, A
                endm

                display " - Get Address Unit by Index : \t\t\t", /A, GetAddress, " = busy [ ", /D, $ - GetAddress, " bytes  ]"

                endif ; ~ _CORE_MODULE_UNIT_UTILS_GET_ADDRESS_UNIT_
