                        
                    ifndef _MOUSE_GET_KEY_STATE__
                    define _MOUSE_GET_KEY_STATE__

; -----------------------------------------
; In :
;   A - virtual code
;   HL - return address
; Out :
;   if the mouse button is pressed, Z flag is reset
; Corrupt :
;   BC, AF
; -----------------------------------------
CheckKeyState:      LD BC, #FADF
                    IN C, (C)
                    AND C
                    JP (HL)

; -----------------------------------------
; In :
; Out :
;   A - wheel counter
; Corrupt :
;   BC, AF
; -----------------------------------------
MouseWheelCounter:  LD BC, #FADF
                    IN A, (C)
                    AND #F0
                    RRCA
                    RRCA
                    RRCA
                    RRCA
                    RET

                    endif ; ~_MOUSE_GET_KEY_STATE__
