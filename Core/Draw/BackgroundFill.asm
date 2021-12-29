  
                ifndef _CORE_DISPLAY_BACKGROUND_FILL_
                define _CORE_DISPLAY_BACKGROUND_FILL_

; -----------------------------------------
;
; In:
;   HL - color
; Out:
; Corrupt:
; -----------------------------------------
NextDay:        ;
.PostPaper      EQU $+1
                LD HL, .PaperTable
                PUSH HL

                LD E, (HL)
                LD D, E
                
                LD A, E
                RRA
                RRA
                RRA
                AND %00000111
                CP WHITE
                JR NZ, $+4
                LD A, BLACK
                OUT (#FE), A

                ; заполнени 1 экрана
                CALL Memory.SetPage5
                LD HL, #C000 + #1800 + #0300
                CALL MEMSET.SafeFill_768

                ; заполнени 2 экрана
                CALL Memory.SetPage7
                LD HL, #C000 + #1800 + #0300
                CALL MEMSET.SafeFill_768

                POP HL
.Check          EQU $+1
                LD DE, .PaperTableEnd
                EX DE, HL
                OR A
                SBC HL, DE
                JR NZ, .SkipRevert

                LD A, (.Next)
                XOR %00001000
                LD (.Next + 0), A
                BIT 3, A
                LD HL, .PaperTableEnd
                JR Z, $+5
                LD HL, .PaperTable

                LD (.Check), HL

.SkipRevert     EX DE, HL

                LD (RefreshDay.PrePaper), HL
                
.Next           EQU $
                INC HL
                LD (.PostPaper), HL

                RET

.PaperTable     ZX_COLOR_IPB BLACK, WHITE, 0
                ZX_COLOR_IPB BLACK, WHITE, 0
                ZX_COLOR_IPB BLACK, YELLOW, 0
                ZX_COLOR_IPB BLACK, YELLOW, 0
                ZX_COLOR_IPB BLACK, CYAN, 0
                ZX_COLOR_IPB BLACK, MAGENTA, 0
                ZX_COLOR_IPB BLACK, BLUE, 0
                ZX_COLOR_IPB BLACK, BLUE, 0
.PaperTableEnd  EQU $-1

RefreshDay:     ; обновить цвет
.PrePaper       EQU $+1
                LD HL, NextDay.PaperTable
                LD E, (HL)
                LD D, E

                LD A, E
                RRA
                RRA
                RRA
                AND %00000111
                CP WHITE
                JR NZ, $+4
                LD A, BLACK
                OUT (#FE), A

                ; заполнени 1 экрана
                CALL Memory.SetPage5
                LD HL, #C000 + #1800 + #0300
                CALL MEMSET.SafeFill_768

                ; заполнени 2 экрана
                CALL Memory.SetPage7
                LD HL, #C000 + #1800 + #0300
                CALL MEMSET.SafeFill_768

                RET

                endif ; ~_CORE_DISPLAY_BACKGROUND_FILL_