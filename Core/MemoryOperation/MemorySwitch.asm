
                    ifndef _MEMORY_SWITCH_
                    define _MEMORY_SWITCH_

; -----------------------------------------
; In:
;   A - page
; Corrupt:
;   BC, AF, AF'
; -----------------------------------------
SetPage:            EX AF, AF'
                    LD BC, PORT_7FFD
                    LD A, (BC)
                    LD C, A
                    EX AF, AF'
                    XOR C
                    AND %00000111
                    XOR C
                    LD C, LOW PORT_7FFD
                    LD (BC), A
                    OUT (C), A
                    RET
; MemoryPage_Sprites_0
SetPage0:           LD BC, PORT_7FFD
                    LD A, (BC)
                    AND %11111000
                    LD (BC), A
                    OUT (C), A
                    RET
; MemoryPage_Tilemap
SetPage1:           LD BC, PORT_7FFD
                    LD A, (BC)
                    AND %11111000
                    INC A
                    LD (BC), A
                    OUT (C), A
                    RET
; MemoryPage_Music
SetPage3:           LD BC, PORT_7FFD
                    LD A, (BC)
                    AND %11111000
                    OR #03
                    LD (BC), A
                    OUT (C), A
                    RET
SetPage4:           LD BC, PORT_7FFD
                    LD A, (BC)
                    AND %11111000
                    OR #04
                    LD (BC), A
                    OUT (C), A
                    RET
SetPage6:           LD BC, PORT_7FFD
                    LD A, (BC)
                    AND %11111000
                    OR #06
                    LD (BC), A
                    OUT (C), A
                    RET
; MemoryPage_ShadowScreen
SetPage7:           LD BC, PORT_7FFD
                    LD A, (BC)
                    AND %11111000
                    OR #07
                    LD (BC), A
                    OUT (C), A
                    RET

                    endif ; ~_MEMORY_SWITCH_