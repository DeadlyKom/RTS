
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
FadeIn:         ; ; отображение выноски
                ; LD HL, SCREEN_CALLOUT
                ; LD B, HIGH CALLOUT_SIZE
                ; LD C, (IY + FDialogVariable.Fade.RowLength)
                ; CALL DrawCallout
                ; RET

                ; расчёт адреса вывода
                LD D, HIGH SCREEN_CALLOUT
                LD A, (IY + FDialogVariable.Fade.RowLength)
                DEC A
                ADD A, A
                ADD A, LOW SCREEN_CALLOUT
                LD E, A
                CALL PixelAttribute
                EX DE, HL
                LD B, NUMBER_ROWS+1
.Loop           LD (HL), BACKGROUND_DLG
                INC L
                LD (HL), BACKGROUND_DLG
                DEC L
                ; переход к нижнему знакоместу
                LD A, L
                ADD A, #20
                LD L, A
                JR NC, $+3
                INC H
                DJNZ .Loop
                RET

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_FADE_
