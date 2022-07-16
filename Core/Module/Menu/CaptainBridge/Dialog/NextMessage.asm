
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_NEXT_MESSAGE_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_NEXT_MESSAGE_
; -----------------------------------------
; переход к следующему сообщению
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
NextMsg:        ;
                DEC (IY + FDialogVariable.NumberMsgID)
                JR Z, $

                ;
                LD HL, (IY + FDialogVariable.Dialog)
                INC HL
                LD (IY + FDialogVariable.Dialog), HL
                XOR A
                LD (IY + FDialogVariable.Print.MessageOffset), A
                EX AF, AF'
                LD A, (HL)
                LD (IY + FDialogVariable.Print.MessageID), A

                ; получить длину слова в строке
                ; In:
                ;   A  - ID сообщения
                ;   A' - смещение в строке
                ; Out:
                ;   HL - длина слова (в символах)
                ;   DE - длина слова в строке (в пикселях)

                CALL Functions.WordLength

                ;
                LD (IY + FDialogVariable.WordLength), L
                JP NextWord.NextRow

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_NEXT_MESSAGE_
