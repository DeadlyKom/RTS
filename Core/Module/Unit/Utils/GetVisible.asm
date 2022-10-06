
                ifndef _CORE_MODULE_UNIT_UTILS_GET_VISIBLE_SORTED_
                define _CORE_MODULE_UNIT_UTILS_GET_VISIBLE_SORTED_
; -----------------------------------------
; получить массив отсортированных юнитов по вертикали
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
GetVisible:     RET

                display " - Get Visible Units is Sorted : \t\t\t", /A, GetVisible, " = busy [ ", /D, $ - GetVisible, " bytes  ]"

                endif ; ~ _CORE_MODULE_UNIT_UTILS_GET_VISIBLE_SORTED_
