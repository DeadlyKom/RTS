
                ifndef _CORE_MODULE_UTILS_UNIT_RANK_MACRO_
                define _CORE_MODULE_UTILS_UNIT_RANK_MACRO_
; -----------------------------------------
; получение ранга у объекта
; In:
;   IX - указывает на структуру FUnit
; Out:
; Corrupt:
;   AF
; Note:
; -----------------------------------------
UNIT_Rank:      macro
                LD A, (IX + FUnit.Rank)                                         ; чтение ранга
                AND UNIT_RANK_MASK
                endm

                endif ; ~ _CORE_MODULE_UTILS_UNIT_RANK_MACRO_
