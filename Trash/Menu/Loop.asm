
                ifndef _CORE_MENU_LOOP_
                define _CORE_MENU_LOOP_
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MenuLoop:       
.MainLoop
                JP .MainLoop

                endif ; ~_CORE_MENU_LOOP_
