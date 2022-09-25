
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_FADE_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_FADE_
BACKGROUND_DLG  EQU ((0 << 7) | (0 << 6) | (BLACK << 3) | BLACK)
; -----------------------------------------
; появление выноски
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Fadein:         ; расчёт адреса вывода
                LD D, HIGH SCREEN_CALLOUT
                LD A, (IY + FDialogVariable.Fade.RowLength)
                DEC A
                ADD A, LOW SCREEN_CALLOUT
                LD E, A
                CALL PixelAttribute
                EX DE, HL
                LD B, NUMBER_ROWS+1
.Loop           LD (HL), BACKGROUND_DLG

                ; переход к нижнему знакоместу
                LD A, L
                ADD A, #20
                LD L, A
                ADC A, H
                SUB L
                LD H, A
                DJNZ .Loop
                RET

; -----------------------------------------
; скрытие выноски (копирование с теневого экрана)
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Fadeout:        ; расчёт адреса вывода
                LD D, HIGH SCREEN_CALLOUT
                LD A, (IY + FDialogVariable.Fade.RowLength)
                DEC A
                ADD A, LOW SCREEN_CALLOUT
                LD E, A

                LD B, NUMBER_ROWS+1
    
.Loop           LD C, 8
                PUSH DE

                ; копироавние графики с теневого экрана
.RowLoop        SET 7, D
                LD A, (DE)
                RES 7, D
                LD (DE), A
                INC D
                DEC C
                JR NZ, .RowLoop

                ; копирование атрибута
                DEC D
                CALL PixelAttribute
                SET 7, D
                LD A, (DE)
                RES 7, D
                LD (DE), A
                POP DE

                ; переход к нижнему знакоместу
                LD A, E
                ADD A, #20
                LD E, A

                DJNZ .Loop
                RET

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_FADE_
