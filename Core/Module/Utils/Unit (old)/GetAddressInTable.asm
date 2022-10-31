
                ifndef _CORE_MODULE_UTILS_ADD_OFFSET_BY_UNIT_TYPE_
                define _CORE_MODULE_UTILS_ADD_OFFSET_BY_UNIT_TYPE_
; -----------------------------------------
; получить адрес из таблице по типу юнита
; In:
;   IX - указывает на структуру FUnit
;   HL - указывает на таблицу
; Out:
;   HL - значение из таблицы
; Corrupt:
;   HL, DE, AF
; Note:
; -----------------------------------------
GetAdrInTable:  LD A, (IX + FUnit.Type)                                         ; получим тип юнита
                AND IDX_UNIT_TYPE
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A

                ; получение адреса из таблицы
                LD E, (HL)
                INC HL
                LD D, (HL)
                DEC HL
                ADD HL, DE

                RET

                endif ; ~ _CORE_MODULE_UTILS_ADD_OFFSET_BY_UNIT_TYPE_
