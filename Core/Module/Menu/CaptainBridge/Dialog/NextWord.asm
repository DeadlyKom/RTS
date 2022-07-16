
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_NEXT_WORD_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_NEXT_WORD_
; -----------------------------------------
; переход к следующему слову
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
NextWord:       ; получить длину слова в строке
                ; In:
                ;   A  - ID сообщения
                ;   A' - смещение в строке
                ; Out:
                ;   HL - длина слова (в символах)
                ;   DE - длина слова в строке (в пикселях)

                LD A, (IY + FDialogVariable.Print.MessageOffset)
                EX AF, AF'
                LD A, (IY + FDialogVariable.Print.MessageID)

                CALL Functions.WordLength

                ;
                LD (IY + FDialogVariable.WordLength), L

                ; проверка переполнения доступной области вывода сообщения
                LD A, (IY + FDialogVariable.RowLength)
                SUB E
                JR C, .NextRow
                LD (IY + FDialogVariable.RowLength), A
                
                ; флаг переноса сброшен (не конец строки)
                RET

.NextRow        ; -----------------------------------------
                ; доступная строка области вывода сообщения заполнелась
                ; -----------------------------------------

                ; уменьшение счётчика заполненых строк
                DEC (IY + FDialogVariable.Rows)
                JR Z, .FillCallout

                ; перенос курсор в начало области вывода
                LD (IY + FDialogVariable.Print.CursorPosition.X), START_CUR_POS & 0xFF
                LD A, (IY + FDialogVariable.Print.CursorPosition.Y)
                ADD A, ROW_HEGHT
                LD (IY + FDialogVariable.Print.CursorPosition.Y), A

                ; инициализация доступной области вывода сообщений
                LD A, ROW_LENGTH
                SUB E
                JR C, NextWord
                LD (IY + FDialogVariable.RowLength), A

                SCF                                                             ; флаг переноса установлен (конец строки)
                RET

.FillCallout    ; перенос курсор в начало области вывода
                LD (IY + FDialogVariable.Print.CursorPosition.X), START_CUR_POS & 0xFF
                LD A, (IY + FDialogVariable.Print.CursorPosition.Y)
                SUB ROW_HEGHT
                LD (IY + FDialogVariable.Print.CursorPosition.Y), A

                ; инициализация доступной области вывода сообщений
                LD A, ROW_LENGTH
                SUB E
                JR C, NextWord
                LD (IY + FDialogVariable.RowLength), A
                LD (IY + FDialogVariable.Rows), 2

                SCF                                                             ; флаг переноса установлен (конец строки)
                JP SetWaitInput

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_NEXT_WORD_
