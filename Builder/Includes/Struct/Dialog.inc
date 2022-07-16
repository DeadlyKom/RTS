
                
                ifndef _DIALOG_STRUCT_
                define _DIALOG_STRUCT_

                struct FPrintedTextVFX
CursorPosition: FLocation                                                       ; положение курсора
MessageID       DB #00                                                          ; ID сообщения
MessageOffset   DB #00                                                          ; смещение в сообщении
Countdown:      DB #00                                                          ; обратный счётчик продолжительности печати
DurationPrint:  DB DURATION_PRINT                                               ; продолжительность анимаций печати (1/50)

                ends

                struct FDialogArrow
Countdown:      DB #00                                                          ; обратный счётчик
Animation:      DB #00                                                          ; номер анимации стрелки
                ends

                struct FDialogScroll
Countdown:      DB #00                                                          ; обратный счётчик
RowCounter:     DB #00
                ends

                struct FDialogVariable
Print:          FPrintedTextVFX
Arrow:          FDialogArrow
Scroll:         FDialogScroll
RowLength:      DB #00                                                          ; доступная длина строки для отображения сообщения
WordLength:     DB #00                                                          ; длина отоброжаемого слова
Rows:           DB #00                                                          ; доступное количество строк для отображения сообщения
State:          DB #00                                                          ; состояние отображение диалогов

; переменные диалога
DlgFlags:       DB #00                                                          ; флаги диалога
NumberMsgID:    DB #00                                                          ; количество ID сообщений
Dialog:         DW #0000                                                        ; адрес последовательностей ID сообщений
Payload:        DW #0000                                                        ; адрес данных (смещение/функтор)
                ends

                endif ; ~ _DIALOG_STRUCT_