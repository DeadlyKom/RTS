
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_NEXT_DIALOG_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_NEXT_DIALOG_
; -----------------------------------------
; завершение диалога
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
EndDialog:      ; обработка флагов
                LD A, (IY + FDialogVariable.DlgFlags)
                ADD A, A
                JP C, InvokeChoice                                              ; CHOICE_BIT

                ADD A, A                                                        ; FUNCTION_BIT
                CALL C, InvokeFunc

                ADD A, A                                                        ; SELECT_BIT
                JP C, InvokeSelect

                ; адрес текущего диалога
                LD HL, (IY + FDialogVariable.Payload)

.Continue       ; проверка завершения диалога
                LD A, (HL)
                CP END_DIALOG
                RET Z                                                           ; завершение диалога

.T              ; переход к следующему диалогу
                LD C, A
                LD B, #00
                ADD HL, BC
                CALL Initialize.Dialog
                JP NextMsg.Initialize

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_NEXT_DIALOG_
