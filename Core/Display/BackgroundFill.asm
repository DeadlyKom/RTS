  
                ifndef _CORE_DISPLAY_BACKGROUND_FILL_
                define _CORE_DISPLAY_BACKGROUND_FILL_

; -----------------------------------------
;
; In:
;   HL - color
; Out:
; Corrupt:
; -----------------------------------------
BackgroundFill: DI
                LD (.ContainerSP), SP
.ContainerHL    EQU $+1
                LD HL, .PaperTable

                LD SP, HL
                POP DE
                
                LD A, E
                RRA
                RRA
                RRA
                AND %00000111
                OUT (#FE), A

                SeMemoryPage MemoryPage_ShadowScreen

                LD SP, #C000 + #1800 + #0300

                rept 384
                PUSH DE
                endr

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

.ContainerSP    EQU $+1
                LD SP, #0000
                EI
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