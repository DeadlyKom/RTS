
                
                ifndef _DIALOG_STRUCT_
                define _DIALOG_STRUCT_

                struct FPrintedTextVFX
CursorPosition: FLocation                                                       ; положение курсора
MessageID       DB #00                                                          ; ID сообщения
MessageOffset   DB #00                                                          ; смещение в сообщении
Countdown:      DB #00                                                          ; обратный счётчик продолжительности печати

                ends

                struct FDialogArrow
Countdown:      DB #00                                                          ; обратный счётчик
Animation:      DB #00                                                          ; номер анимации стрелки
                ends

                struct FDialogScroll
Countdown:      DB #00                                                          ; обратный счётчик
RowCounter:     DB #00
                ends

                struct FDialogChoice
Number:         DB #00                                                          ; количество вариантов выбора
Counter:        DB #00                                                          ; счётчик вариантов выбора
Payload:        DW #0000                                                        ; адрес данных (смещение вариантов)
                ends

                struct FDialogFade
Countdown:      DB #00                                                          ; обратный счётчик
RowLength:      DB #00                                                          ; длина отображаемых рядов        
                ends

                struct FDialogVariable
Print:          FPrintedTextVFX
Arrow:          FDialogArrow
Scroll:         FDialogScroll
Choice:         FDialogChoice
Fade:           FDialogFade
RowLength:      DB #00                                                          ; доступная длина строки для отображения сообщения
WordLength:     DB #00                                                          ; длина отоброжаемого слова
Rows:           DB #00                                                          ; доступное количество строк для отображения сообщения
State:          DB #00                                                          ; состояние отображение диалогов
CurSelectionNum DB #00                                                          ; номер текущего выбора
OldSelectionNum DB #00                                                          ; номер текущего выбора

; переменные диалога
DlgFlags:       DB #00                                                          ; флаги диалога
CounterMsgID:   DB #00                                                          ; счётчик ID сообщений
Dialog:         DW #0000                                                        ; адрес последовательностей ID сообщений
Payload:        DW #0000                                                        ; адрес данных (смещение/функтор)
CallbackWait:   DW #0000                                                        ; адрес обработчика после ожидания нажатия (вывод стрелки вниз)
                ends

                endif ; ~ _DIALOG_STRUCT_