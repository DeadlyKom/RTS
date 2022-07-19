
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_CORE_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_CORE_

SetPrinted:     LD (IY + FDialogVariable.State), PRINTED_MSG
                RET
GetWaitDown:    LD A, (IY + FDialogVariable.State)
                CP WAITING_DOWN
                RET
SetWaitDown:    LD (IY + FDialogVariable.State), WAITING_DOWN
                RET
GetWaitSelect:  LD A, (IY + FDialogVariable.State)
                CP WAITING_SELECT
                RET
SetWaitSelect:  LD (IY + FDialogVariable.State), WAITING_SELECT
                RET

SetScroll:      LD (IY + FDialogVariable.State), SCROLL_MSG
                RET

; -----------------------------------------
; вызов функции
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
InvokeFunc:     JR$
                RET
; -----------------------------------------
; вызов выбора
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
InvokeSelect:   ; включить бит обработки выбора
                SET CHOICE_BIT, (IY + FDialogVariable.DlgFlags)

                ; инициализация вариаций выбора
                LD HL, (IY + FDialogVariable.Payload)
                LD A, (HL)                                                      ; /*choice*/
                LD (IY + FDialogVariable.Choice.Number), A
                LD (IY + FDialogVariable.Choice.Counter), A
                INC HL
                LD (IY + FDialogVariable.Choice.Payload), HL

                ;
                LD C, A
                LD A, (IY + FDialogVariable.Rows)
                DEC A
                SUB C
                JR NC, .SkipScroll

                NEG
                INC C
                LD (IY + FDialogVariable.Rows), C
                LD B, A
                XOR A

.Mult           ADD A, ROW_HEGHT
                DJNZ .Mult

                LD (IY + FDialogVariable.Scroll.RowCounter), A
                CALL SetScroll

                ; корректировка курсора по вертикали (после скрола)
                LD C, A
                LD A, (IY + FDialogVariable.Print.CursorPosition.Y)
                SUB C
                LD (IY + FDialogVariable.Print.CursorPosition.Y), A

.SkipScroll     ;
                LD (IY + FDialogVariable.Payload), HL
                
                LD A, (HL)
                JP EndDialog.T
; -----------------------------------------
; вызов обработчика выбора
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
InvokeChoice:   ; уменьшение счётчика выводимых сообщений
                DEC (IY + FDialogVariable.Choice.Counter)
                JR Z, SetWaitSelect

                LD HL, (IY + FDialogVariable.Choice.Payload)
                INC HL
                LD (IY + FDialogVariable.Choice.Payload), HL

                JR InvokeSelect.SkipScroll

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_CORE_
