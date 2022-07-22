
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_TICK_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_TICK_
; -----------------------------------------
; In:
;   IY - указатель на структуру FPrintedTextVFX
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Tick:           LD A, (IY + FDialogVariable.State)
                CP OPEN_DLG
                JR Z, .AnimOpen
                CP PRINTED_MSG
                JR Z, .AnimMessage
                CP WAITING_DOWN
                JR Z, .AnimArrowDown
                CP WAITING_SELECT
                JR Z, .AnimArrowRight
                CP SCROLL_MSG
                JR Z, .AnimScroll
                CP CLOSE_DLG
                JR Z, .AnimClose
                RET
.AnimOpen       ; -----------------------------------------
                ; анимация открытия диалога
                ; -----------------------------------------
                ; уменьшение счётчика
                DEC (IY + FDialogVariable.Fade.Countdown)
                RET NZ

                ; установка обратного счётчика
                LD (IY + FDialogVariable.Fade.Countdown), DURATION_FADE

                ; увеличение количество видимых рядов
                LD A, (IY + FDialogVariable.Fade.RowLength)
                ; CP ROW_LENGTH_CHR - 2
                CP ROW_LENGTH_CHR >> 1
                JP NC, Open
                INC (IY + FDialogVariable.Fade.RowLength)
                JP FadeIn

.AnimMessage    ; -----------------------------------------
                ; анимация вывода сообщения
                ; -----------------------------------------
                
                ; опрос нажатия любой клавиши
                ; CALL Keyboard.AnyKeyPressed
                ; JR NZ, .PressedAnyKey

                ; уменьшение счётчика
                DEC (IY + FDialogVariable.Print.Countdown)
                RET NZ

.PressedAnyKey  ; нажата любая клавиша

                ; установка обратного счётчика
                LD (IY + FDialogVariable.Print.Countdown), DURATION_PRINT
.NextDraw
                ; отобразить символ
                CALL DrawChar
                RET C                                                           ; выход, если конеч строки

                INC (IY + FDialogVariable.Print.MessageOffset)

                ; уменьшение счётчика отображаемого символа
                DEC (IY + FDialogVariable.WordLength)
                CALL Z, NextWord
                RET C                                                           ; выход, если конеч строки

                ; опрос нажатия любой клавиши
                CALL Keyboard.AnyKeyPressed
                JR NZ, .NextDraw
        
                RET

.AnimArrowDown  ; -----------------------------------------
                ; анимация вывода прыгающей стрелки (вниз)
                ; -----------------------------------------

                ; уменьшение счётчика
                DEC (IY + FDialogVariable.Arrow.Countdown)
                RET NZ

                ; установка обратного счётчика
                LD (IY + FDialogVariable.Arrow.Countdown), DURATION_ARROW

                ; отображение стрелки
                CALL Menu.CaptainBridge.CapBridge.EnableInput
                JP DrawArrowDown

.AnimArrowRight ; -----------------------------------------
                ; анимация вывода прыгающей стрелки (вправо)
                ; -----------------------------------------

                ; уменьшение счётчика
                DEC (IY + FDialogVariable.Arrow.Countdown)
                RET NZ

                ; установка обратного счётчика
                LD (IY + FDialogVariable.Arrow.Countdown), DURATION_ARROW

                ; отображение стрелки
                CALL Menu.CaptainBridge.CapBridge.EnableInput
                JP DrawArrowSelect

.AnimScroll     ; -----------------------------------------
                ; анимация скрола
                ; -----------------------------------------
                ; уменьшение счётчика
                DEC (IY + FDialogVariable.Scroll.Countdown)
                RET NZ

                ; установка обратного счётчика
                LD (IY + FDialogVariable.Scroll.Countdown), DURATION_SCROLL

                ; скролл
                CALL Scroll

                DEC (IY + FDialogVariable.Scroll.RowCounter)
                RET NZ

                ; установка обратного счётчика
                LD (IY + FDialogVariable.Scroll.RowCounter), SCROLLABLE_LINES

                JP SetPrinted

.AnimClose      ; -----------------------------------------
                ; анимация закрытия диалога
                ; -----------------------------------------
                JP Close

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_TICK_
