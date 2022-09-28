                        
                ifndef _INPUT_MOUSE_GET_CURSOR_POSITION_
                define _INPUT_MOUSE_GET_CURSOR_POSITION_
                        
; -----------------------------------------
; In :
; Out :
;   A - the counter value of the X coordinate of the positionmouse
; Corrupt :
;   BC, A
; -----------------------------------------
GetMouseX:      LD BC, #FBDF
                IN A, (C)
                RET
; -----------------------------------------
; In :
; Out :
;   A - the counter value of the Y coordinate of the positionmouse
; Corrupt :
;   BC, A
; -----------------------------------------
GetMouseY:      LD BC, #FFDF
                IN A, (C)
                RET

; -----------------------------------------
; In :
; Out :
;   E - the counter value of the X coordinate of the positionmouse
;   D - the counter value of the Y coordinate of the positionmouse
; Corrupt :
;   BC, DE
; -----------------------------------------
GetMouseXY:     LD BC, #FBDF
                IN E, (C)
                LD B, #FF
                IN D, (C)
                RET

                endif ; ~_INPUT_MOUSE_GET_CURSOR_POSITION_
