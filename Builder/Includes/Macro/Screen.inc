
                ifndef _MACRO_SCREEN_
                define _MACRO_SCREEN_
BORDER          macro Color?
                LD A, Color?
                OUT (#FE), A
                endm
CLS_4000        macro
                LD HL, #4000 + #1800
                LD DE, #0000
                CALL SafeFill_Screen
                endm
ATTR_4000_IP    macro Inc?, Paper?
                LD HL, #4000 + #1800 + #0300
                LD DE, (((Paper? << 3) | Inc?) << 8) | ((Paper? << 3) | Inc?)
                CALL SafeFill_768
                endm
ATTR_4000_IPB   macro Inc?, Paper?,  Bright?
                LD HL, #4000 + #1800 + #0300
                LD DE, ((((0 << 7) | (Bright? << 6) | (Paper? << 3) | Inc?)) << 8) | (((0 << 7) | (Bright? << 6) | (Paper? << 3) | Inc?))
                CALL SafeFill_768
                endm
ATTR_C000_IP    macro Inc?, Paper?
                LD HL, #C000 + #1800 + #0300
                LD DE, (((Paper? << 3) | Inc?) << 8) | ((Paper? << 3) | Inc?)
                CALL SafeFill_768
                endm
ATTR_C000_IPB   macro Inc?, Paper?,  Bright?
                LD HL, #C000 + #1800 + #0300
                LD DE, ((((0 << 7) | (Bright? << 6) | (Paper? << 3) | Inc?)) << 8) | (((0 << 7) | (Bright? << 6) | (Paper? << 3) | Inc?))
                CALL SafeFill_768
                endm
CLS_C000        macro
                LD HL, #C000 + #1800
                LD DE, #0000
                CALL SafeFill_Screen
                endm
ATTR_C000       macro Color?
                LD HL, #C000 + #1800 + #0300
                LD DE, (Color? << 8) | Color?
                CALL SafeFill_768
                endm

DrawSpriteOneATTR  macro Sprite?, X?, Y?, Width?, Height?
                LD HL, Sprite?
                LD DE, (Y? << 8) | X?
                LD BC, (Height? << 8) | Width?
                CALL DrawSpriteOne
                endm
; -----------------------------------------
; расчёт адреса скрытого экрана
; In:
; Out:
;   Reg? - если отображается первый экран равен #С0, иначе #40 
; Corrupt:
;   AF
; Note:
; -----------------------------------------
HiddenScreenAdr macro Reg?
                LD A, (MemoryPageRef)
                AND SCREEN_MASK
                ; LD Reg?, #C0
                LD Reg?, #40
                JR Z, $+4
                ; LD Reg?, #40
                LD Reg?, #C0
                endm
ZX_COLOR_IPBF   macro Inc?, Paper?, Bright?, Flash?
                DB ((Flash? << 7) | (Bright? << 6) | (Paper? << 3) | Inc?)
                endm
ZX_COLOR_IPB    macro Inc?, Paper?, Bright?
                DB ((0 << 7) | (Bright? << 6) | (Paper? << 3) | Inc?)
                endm
ZX_COLOR_IP     macro Inc?, Paper?
                DB ((0 << 7) | (0 << 6) | (Paper? << 3) | Inc?)
                endm

SET_PAGE_VISIBLE_SCREEN macro
                CALL ScrPageToC000
                endm

SET_PAGE_SHADOW_SCREEN macro
                CALL ScrPageToC000_
                endm

                endif ; ~_MACRO_SCREEN_
