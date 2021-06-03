
                        ifndef _MACRO_INCLUDE_
                        define _MACRO_INCLUDE_

; -----------------------------------------
;
; In:
; Out:
; Corrupt:
;   BC, AF
; -----------------------------------------
SeMemoryPage            macro Page?
                        LD A, (MemoryPageRef)
                        AND %11111000
                        OR Page?
                        LD (MemoryPageRef), A
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
                        LD A, (MemoryPageRef)
                        AND %11111000                      
                        OR C
                        LD (MemoryPageRef), A
                        LD BC, PORT_7FFD
                        OUT (C), A
                        endm
SwapScreens             macro
                        LD A, (MemoryPageRef)
                        XOR %00001000
                        LD (MemoryPageRef), A
                        LD BC, PORT_7FFD
                        OUT (C), A
                        endm
GetCurrentScreen        macro
                        LD A, (MemoryPageRef)
                        AND %00001000
                        endm
AdjustHighScreenByte    macro
                        LD A, (MemoryPageRef)
                        CPL
                        AND %00001000
                        RLA
                        RLA
                        RLA
                        RLA
                        OR H
                        LD H, A
                        endm
CLS_0                   macro
                        LD DE, #0000
                        LD HL, #5800
                        CALL MEMSET.SafeFill_Screen
                        endm
CLS_1                   macro
                        LD DE, #0000
                        LD HL, #D800
                        CALL MEMSET.SafeFill_Screen
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
                        LD (Interrupt.Handler.RestoreRegister), A
                        endm
RestoreDE:              macro
                        LD A, #D5
                        LD (Interrupt.Handler.RestoreRegister), A
                        endm
RestoreBC:              macro
                        LD A, #C5
                        LD (Interrupt.Handler.RestoreRegister), A
                        endm

                        ; frame flags
CheckFrameFlag          macro Flag?
                        LD A, (FrameStateRef)
                        AND Flag?
                        endm
SetFrameFlag            macro Flag?
                        LD A, (FrameStateRef)
                        OR Flag?
                        LD (FrameStateRef), A
                        endm
ResetFrameFlag          macro Flag?
                        LD A, (FrameStateRef)
                        AND ((~Flag?) & 0xFF)
                        LD (FrameStateRef), A
                        endm
ResetAllFrameFlags      macro
                        XOR A
                        LD (FrameStateRef), A
                        endm

                        ; hardware flags
CheckHardwareFlag       macro Flag?
                        LD A, (HardwareStateRef)
                        AND Flag?
                        endm
SetHardwareFlag         macro Flag?
                        LD A, (HardwareStateRef)
                        OR Flag?
                        LD (HardwareStateRef), A
                        endm
ResetHardwareFlag       macro Flag?
                        LD A, (HardwareStateRef)
                        AND ((~Flag?) & 0xFF)
                        LD (HardwareStateRef), A
                        endm
ResetAllHardwareFlags   macro
                        XOR A
                        LD (HardwareStateRef), A
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
BEGIN_DEBUG_BORDER_DEF  macro
                        BEGIN_DEBUG_BORDER_COL DEFAULT_COLOR
                        endm
BEGIN_DEBUG_BORDER_COL  macro Color?
                        ; show debug border
                        ifdef SHOW_DEBUG_BORDER
                        LD A, Color?
                        LD (BorderStorageStackRef), A
                        OUT (#FE), A
                        endif
                        endm

END_DUBUG_BORDER        macro
                        ; show debug border
                        ifdef SHOW_DEBUG_BORDER
                        LD A, (BorderStorageStackRef)
                        OUT (#FE), A
                        endif
                        endm
                                             
                        endif ; ~_MACRO_INCLUDE_