
                        ifndef _MACRO_INCLUDE_
                        define _MACRO_INCLUDE_
; -----------------------------------------
;
; In:
; Out:
; Corrupt:
;   BC, AF
; -----------------------------------------
Disable_128k_Basic      macro
                        LD SP, (#5C3D)                                  ; ERR_SP
                        LD HL, #1303                                    ; MAIN_4
                        EX (SP), HL
                        RES 4, (IY + 1)
                        LD BC, PORT_7FFD
                        LD A, %00010000
                        LD (MemoryPageRef), A
                        OUT (C), A
                        endm
; -----------------------------------------
;
; In:
; Out:
; Corrupt:
;   BC, AF
; -----------------------------------------
SeMemoryPage            macro Page?, ID?
                        LD A, (MemoryPageRef)
                        AND %11111000
                        OR Page?
                        LD (MemoryPageRef), A
                        LD BC, PORT_7FFD
                        OUT (C), A
                        ifdef DEBUG_PAGE_ID
                        LD A, ID?
                        LD (MemoryPageIDRef), A
                        endif
                        endm
; -----------------------------------------
;
; In:
;   A - page
; Out:
; Corrupt:
;   BC, AF
; -----------------------------------------
SeMemoryPage_A          macro ID?
                        AND %00000111
                        LD C, A
                        LD A, (MemoryPageRef)
                        AND %11111000
                        OR C
                        LD (MemoryPageRef), A
                        LD BC, PORT_7FFD
                        OUT (C), A
                        ifdef DEBUG_PAGE_ID
                        LD A, ID?
                        LD (MemoryPageIDRef), A
                        endif
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
GetShadowScreen         macro
                        LD A, (MemoryPageRef)
                        CPL
                        AND %00001000
                        endm
AdjustHighScreenByte_A  macro
                        LD A, (MemoryPageRef)
                        CPL
                        AND %00001000
                        RLA
                        RLA
                        RLA
                        RLA
                        endm
AdjustHighScreenByte_H  macro
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
AdjustHighScreenByte_D  macro
                        LD A, (MemoryPageRef)
                        CPL
                        AND %00001000
                        RLA
                        RLA
                        RLA
                        RLA
                        OR D
                        LD D, A
                        endm
CLS_4000                macro
                        LD DE, #0000
                        LD HL, #4000 + #1800
                        CALL MEMSET.SafeFill_Screen
                        endm
CLS_C000                macro
                        LD DE, #0000
                        LD HL, #C000 + #1800
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

                        ; ---------------------------------------------
                        ; frame flags
                        ; ---------------------------------------------
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
SetAllFrameFlags        macro
                        LD A, #FF
                        LD (FrameStateRef), A
                        endm

                        ; ---------------------------------------------
                        ; gameplay flags
                        ; ---------------------------------------------
CheckGameplayFlag       macro Flag?
                        LD A, (GameplayStateRef)
                        AND Flag?
                        endm
SetGameplayFlag         macro Flag?
                        LD A, (GameplayStateRef)
                        OR Flag?
                        LD (GameplayStateRef), A
                        endm
ResetGameplayFlag       macro Flag?
                        LD A, (GameplayStateRef)
                        AND ((~Flag?) & 0xFF)
                        LD (GameplayStateRef), A
                        endm
SwapGameplayFlag        macro Flag?
                        LD A, (GameplayStateRef)
                        XOR Flag?
                        LD (GameplayStateRef), A
                        endm
ResetAllGameplayFlags   macro
                        XOR A
                        LD (GameplayStateRef), A
                        endm
SetAllGameplayFlags     macro
                        LD A, #FF
                        LD (GameplayStateRef), A
                        endm
JumpToGameplayFlag      macro Flag?
                        LD BC, $+13
                        PUSH BC
                        LD A, (GameplayStateRef)
                        AND Flag?
                        JR Z, $+3
                        EX DE, HL
                        JP (HL)
                        endm

                        ; ---------------------------------------------
                        ; tilemap flags
                        ; ---------------------------------------------
CheckTilemapFlag        macro Flag?
                        LD A, (TilemapStateRef)
                        AND Flag?
                        endm
SetTilemapFlag          macro Flag?
                        LD A, (TilemapStateRef)
                        OR Flag?
                        LD (TilemapStateRef), A
                        endm
ResetTilemapFlag        macro Flag?
                        LD A, (TilemapStateRef)
                        AND ((~Flag?) & 0xFF)
                        LD (TilemapStateRef), A
                        endm
JumpToTilemapFlag       macro Flag?
                        LD BC, $+13
                        PUSH BC
                        LD A, (TilemapStateRef)
                        AND Flag?
                        JR Z, $+3
                        EX DE, HL
                        JP (HL)
                        endm
SwapTilemapFlag         macro Flag?
                        LD A, (TilemapStateRef)
                        XOR Flag?
                        LD (TilemapStateRef), A
                        endm
ResetAllTilemapFlags    macro
                        XOR A
                        LD (TilemapStateRef), A
                        endm
SetAllTilemapFlags      macro
                        LD A, #FF
                        LD (TilemapStateRef), A
                        endm

                        ; ---------------------------------------------
                        ; AI flags
                        ; ---------------------------------------------
CheckAIFlag             macro Flag?
                        LD A, (AIStateRef)
                        AND Flag?
                        endm
SetAIFlag               macro Flag?
                        LD A, (AIStateRef)
                        OR Flag?
                        LD (AIStateRef), A
                        endm
ResetAIFlag             macro Flag?
                        LD A, (AIStateRef)
                        AND ((~Flag?) & 0xFF)
                        LD (AIStateRef), A
                        endm
SwapAIFlag              macro Flag?
                        LD A, (AIStateRef)
                        XOR Flag?
                        LD (AIStateRef), A
                        endm
ResetAllAIFlags         macro
                        XOR A
                        LD (AIStateRef), A
                        endm
SetAllAIFlags           macro
                        LD A, #FF
                        LD (AIStateRef), A
                        endm

                        ; ---------------------------------------------
                        ; hardware flags
                        ; ---------------------------------------------
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
SwapHardwareFlag        macro Flag?
                        LD A, (HardwareStateRef)
                        XOR Flag?
                        LD (HardwareStateRef), A
                        endm
ResetAllHardwareFlags   macro
                        XOR A
                        LD (HardwareStateRef), A
                        endm
SetAllHardwareFlags     macro
                        LD A, #FF
                        LD (HardwareStateRef), A
                        endm

                        ; ---------------------------------------------
                        ; debug flags
                        ; ---------------------------------------------
CheckDebugFlag          macro Flag?
                        ifdef DEBUG
                        LD A, (DebugStateRef)
                        AND Flag?
                        endif
                        endm
SetDebugFlag            macro Flag?
                        ifdef DEBUG
                        LD A, (DebugStateRef)
                        OR Flag?
                        LD (DebugStateRef), A
                        endif
                        endm
ResetDebugFlag          macro Flag?
                        ifdef DEBUG
                        LD A, (DebugStateRef)
                        AND ((~Flag?) & 0xFF)
                        LD (DebugStateRef), A
                        endif
                        endm
SwapDebugFlag           macro Flag?
                        ifdef DEBUG
                        LD A, (DebugStateRef)
                        XOR Flag?
                        LD (DebugStateRef), A
                        endif
                        endm
ResetAllDebugFlags      macro
                        ifdef DEBUG
                        XOR A
                        LD (DebugStateRef), A
                        endif
                        endm

                        ; ---------------------------------------------
ToDo                    macro Metod?, Message?
                        ifdef DEBUG
                        display "/*********"
                        display "ToDo : ", Metod?, " - (", Message?, ")"
                        display "**********/"
                        endif
                        endm

                        ; ---------------------------------------------
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

                        ; ---------------------------------------------
BEGIN_DEBUG_BORDER_DEF  macro
                        BEGIN_DEBUG_BORDER_COL DEFAULT_COLOR
                        endm
BEGIN_DEBUG_BORDER_COL  macro Color?
                        ; show debug border
                        ifdef SHOW_DEBUG_BORDER
                        LD A, Color?
                        OUT (#FE), A
                        endif
                        endm
                                             
                        endif ; ~_MACRO_INCLUDE_