  
                ifndef _CORE_DISPLAY_BACKGROUND_FILL_
                define _CORE_DISPLAY_BACKGROUND_FILL_

; -----------------------------------------
;
; In:
;   HL - color
; Out:
; Corrupt:
; -----------------------------------------
BackgroundFill: ;
.ContainerHL    EQU $+1
                LD HL, .PaperTable

                LD E, (HL)
                INC HL
                LD D, (HL)
                
                LD A, E
                RRA
                RRA
                RRA
                AND %00000111
                OUT (#FE), A

                CALL Memory.SetPage7                       ; SeMemoryPage MemoryPage_ShadowScreen, BACKGROUND_FILL_ID

                LD HL, #C000 + #1800 + #0300
                CALL MEMSET.SafeFill_768

.Check          EQU $+1
                LD DE, .PaperTableEnd
                EX DE, HL
                OR A
                SBC HL, DE
                JR NZ, .SkipRevert
                LD A, (.Next)
                XOR %00001000
                LD (.Next + 0), A
                LD (.Next + 1), A
                BIT 3, A
                LD HL, .PaperTableEnd
                JR Z, $+5
                LD HL, .PaperTable

                LD (.Check), HL

.SkipRevert     EX DE, HL
                
.Next           EQU $
                INC HL
                INC HL

                LD (.ContainerHL), HL

                RET

.PaperTable     ZX_COLOR_IPB BLACK, WHITE, 0    : ZX_COLOR_IPB BLACK, WHITE, 0
                ZX_COLOR_IPB BLACK, YELLOW, 0   : ZX_COLOR_IPB BLACK, YELLOW, 0
                ZX_COLOR_IPB BLACK, YELLOW, 0   : ZX_COLOR_IPB BLACK, YELLOW, 0
                ZX_COLOR_IPB BLACK, CYAN, 0     : ZX_COLOR_IPB BLACK, CYAN, 0
                ZX_COLOR_IPB BLACK, MAGENTA, 0  : ZX_COLOR_IPB BLACK, MAGENTA, 0
                ZX_COLOR_IPB BLACK, BLUE, 0     : ZX_COLOR_IPB BLACK, BLUE, 0
                ZX_COLOR_IPB BLACK, BLUE, 0     : ZX_COLOR_IPB BLACK, BLUE, 0
.PaperTableEnd  EQU $-2

                endif ; ~_CORE_DISPLAY_BACKGROUND_FILL_