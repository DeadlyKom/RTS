
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
                        LD A, (MemoryPagePtr)
                        AND %11111000
                        OR Page?
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
                        AND %00000111
                        LD C, A
                        LD A, (MemoryPagePtr)
                        AND %11111000                      
                        OR C
                        LD (MemoryPagePtr), A
                        LD BC, PORT_7FFD
                        OUT (C), A
                        endm
SwapScreens             macro
                        LD A, (MemoryPagePtr)
                        XOR %00001000
                        LD (MemoryPagePtr), A
                        LD BC, PORT_7FFD
                        OUT (C), A
                        endm
GetCurrentScreen        macro
                        LD A, (MemoryPagePtr)
                        AND %00001000
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
RestoreHL:              macro
                        LD A, #E5
                        LD (InterruptHandler.RestoreRegister), A
                        endm
RestoreDE:              macro
                        LD A, #D5
                        LD (InterruptHandler.RestoreRegister), A
                        endm
RestoreBC:              macro
                        LD A, #C5
                        LD (InterruptHandler.RestoreRegister), A
                        endm
DOWN_BC                 macro
                        ; classic method "DOWN_BC" 25/59
                        INC B
                        LD A, B
                        AND #07
                        JP NZ, $+12
                        LD A, C
                        SUB #E0
                        LD C, A
                        SBC A
                        AND #F8
                        ADD A, B
                        LD B, A
                        endm
                                             
                        endif ; ~_MACRO_INCLUDE_