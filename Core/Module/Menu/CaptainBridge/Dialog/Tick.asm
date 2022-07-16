
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
                CP PRINTED_MSG
                JR Z, .AnimMessage
                CP WAITING_INPUT
                JR Z, .AnimArrow
                CP SCROLL_MSG
                JR Z, .AnimScroll
                RET

.AnimMessage    ; -----------------------------------------
                ; анимация вывода сообщения
                ; -----------------------------------------

                ; уменьшение счётчика
                DEC (IY + FDialogVariable.Print.Countdown)
                RET NZ

                ; установка обратного счётчика
                LD A, (IY + FDialogVariable.Print.DurationPrint)
                LD (IY + FDialogVariable.Print.Countdown), A

                ; отобразить символ
                CALL DrawChar
                RET C                                                           ; выход, если конеч строки

                INC (IY + FDialogVariable.Print.MessageOffset)

                ; уменьшение счётчика отображаемого символа
                DEC (IY + FDialogVariable.WordLength)
                JP Z, NextWord

                RET

.AnimArrow      ; -----------------------------------------
                ; анимация вывода прыгающей стрелки
                ; -----------------------------------------

                ; уменьшение счётчика
                DEC (IY + FDialogVariable.Arrow.Countdown)
                RET NZ

                ; установка обратного счётчика
                LD (IY + FDialogVariable.Arrow.Countdown), DURATION_ARROW

                ; отображение стрелки
                CALL Menu.CaptainBridge.CapBridge.EnableInput
                JP DrawArrow

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

                ; ; перенос курсор в начало области вывода
                ; LD (IY + FDialogVariable.Print.CursorPosition.X), START_CUR_POS & 0xFF

                ; ; инициализация доступной области вывода сообщений
                ; LD (IY + FDialogVariable.RowLength), ROW_LENGTH
                ; LD (IY + FDialogVariable.Rows), 1

                JP SetPrinted

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_TICK_
