
                        ifndef _MACRO_INCLUDE_
                        define _MACRO_INCLUDE_

; -----------------------------------------
;
; In:
; Out:
; Corrupt:
;   BC
; -----------------------------------------
SeMemoryPage            macro Page?
                        LD A, Page?
                        LD (MemoryPagePtr), A
                        LD BC, PORT_7FFD
                        OUT (C), A
                        endm
; -----------------------------------------
;
; In:
;   A - page
; Out:
; Corrupt:
;   BC
; -----------------------------------------
SeMemoryPage_A          macro
                        LD (MemoryPagePtr), A
                        LD BC, PORT_7FFD
                        OUT (C), A
                        endm

ZX_COLOR_IPBF           macro Inc?, Paper?, Bright?, Flash?
                        DB ((Flash? << 7) | (Bright? << 6) | (Paper? << 3) | Inc?)
                        endm
ZX_COLOR_IPB            macro Inc?, Paper?, Bright?
                        DB ((0 << 7) | (Bright? << 6) | (Paper? << 3) | Inc?)
                        endm
ZX_COLOR_IP             macro Inc?, Paper?
                        DB ((0 << 7) | (0 << 6) | (Paper? << 3) | Inc?)
                        endm  
                                             
                        endif ; ~_MACRO_INCLUDE_