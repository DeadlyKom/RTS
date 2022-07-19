
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_NEXT_MESSAGE_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_NEXT_MESSAGE_
; -----------------------------------------
; переход к следующему сообщению
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
NextMsg:        ; проверка наличия сообщений
                DEC (IY + FDialogVariable.CounterMsgID)
                JR Z, EndDialog

                ; переход к следующему сообщению
                LD HL, (IY + FDialogVariable.Dialog)
                INC HL
                LD (IY + FDialogVariable.Dialog), HL

                ; инициализация сообщения
                LD A, (HL)
                LD (IY + FDialogVariable.Print.MessageID), A

.Initialize     ; инициализация новой строки
                XOR A
                LD (IY + FDialogVariable.Print.MessageOffset), A

                ; получить длину слова в строке
                CALL GetLengthWord
                JP NextWord.NextRow

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_NEXT_MESSAGE_
