                        
                        ifndef _MOUSE_GET_KEY_STATE__
                        define _MOUSE_GET_KEY_STATE__

; -----------------------------------------
; In :
;   A - virtual code
; Out :
;   if the mouse button is pressed, Z flag is reset
; Corrupt :
;   BC, E, A
; -----------------------------------------
GetMouseKeyState:       LD BC, #FADF
                        IN E, (C)
                        AND E
                        RET

; -----------------------------------------
; In :
; Out :
;   A - wheel counter
; Corrupt :
;   BC, A
; -----------------------------------------
GetMouseWheelCounter:   LD BC, #FADF
                        IN A, (C)
                        AND #F0
                        RRCA
                        RRCA
                        RRCA
                        RRCA
                        RET

                        endif ; ~_MOUSE_GET_KEY_STATE__
