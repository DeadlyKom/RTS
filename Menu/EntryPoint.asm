
                ifndef _CORE_MENU_ENTRY_POINT_
                define _CORE_MENU_ENTRY_POINT_
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
EntryPoint:     CALL Initialize
                JP MenuLoop

                endif ; ~_CORE_MENU_ENTRY_POINT_
