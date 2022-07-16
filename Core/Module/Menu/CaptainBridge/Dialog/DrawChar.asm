
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_DRAW_CHAR_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_DRAW_CHAR_
; -----------------------------------------
; отображение текста
; In:
;   IY - указатель на структуру FDialogVariable
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawChar:       ; отображение символа строки на экране
                ;   A  - ID сообщения
                ;   A' - смещение в строке
                ;   DE - координаты в пикселях (D - y, E - x)
                ; Out:
                ;   E  - ширина символа

                LD A, (IY + FDialogVariable.Print.MessageOffset)
                EX AF, AF'
                LD A, (IY + FDialogVariable.Print.MessageID)
                LD DE, (IY + FDialogVariable.Print.CursorPosition)
                CALL Functions.DrawCharToScr

                ; проверка конца строки
                LD A, E
                OR A
                JP Z, NextMsg

                ; перемещение курсора отображения символа
                LD A, (IY + FDialogVariable.Print.CursorPosition.X)
                ADD A, E
                INC A                                                           ; 1 пиксель между символами
                LD (IY + FDialogVariable.Print.CursorPosition.X), A

                ; флаг переноса сброшен (не конец строки)
                RET

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_DRAW_CHAR_
