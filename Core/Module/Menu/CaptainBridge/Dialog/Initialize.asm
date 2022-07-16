
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_INITIALIZE_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_INITIALIZE_
; -----------------------------------------
; инициализация диалога
; In:
;   HL - адрес диалога
;   DE - адрес таблици локализации
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Initialize:     LD (LocalizationRef), DE

                ; адрес переменных работы с диалогом
                LD IY, Variables

                LD (IY + FDialogVariable.State), PRINTED_MSG

                ; инициализация доступной области вывода сообщений
                LD (IY + FDialogVariable.RowLength), ROW_LENGTH
                LD (IY + FDialogVariable.Rows), NUMBER_ROWS

                ; инициализация диалога
                LD C, (HL)                                                      ; /*length*/
                LD A, FLAGS_MASK
                AND C
                LD (IY + FDialogVariable.DlgFlags), A
                LD A, FLAGS_MASK_INV
                AND C
                LD (IY + FDialogVariable.NumberMsgID), A
                INC HL                                                          ; /*indexes*/
                LD (IY + FDialogVariable.Dialog), HL
                LD B, #00
                LD C, A
                LD A, (HL)
                ADD HL, BC                                                      ; /*offset*/
                LD (IY + FDialogVariable.Payload), HL
                LD (IY + FDialogVariable.Print.MessageID), A

                ; инициализация позиции вывода диалога
                LD DE, START_CUR_POS
                LD (IY + FDialogVariable.Print.CursorPosition), DE

                ; инициализация продолжительность анимаций печати
                LD A, (IY + FDialogVariable.Print.DurationPrint)
                LD (IY + FDialogVariable.Print.Countdown), A

                ; инициализация продолжительности анимации прыгающей стрелки
                LD (IY + FDialogVariable.Arrow.Countdown), DURATION_ARROW

                ; инициализация скролла
                LD (IY + FDialogVariable.Scroll.Countdown), DURATION_SCROLL
                LD (IY + FDialogVariable.Scroll.RowCounter), SCROLLABLE_LINES

                ;
                XOR A
                LD (IY + FDialogVariable.Arrow.Animation), A
                LD (IY + FDialogVariable.Print.MessageOffset), A

                JP NextWord

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_INITIALIZE_