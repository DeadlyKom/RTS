
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_CORE_
                define _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_CORE_

; SetOpenDialog:  LD (IY + FDialogVariable.State), OPEN_DLG
;                 RET
SetPrinted:     LD (IY + FDialogVariable.State), PRINTED_MSG
                RET
GetWaitDown:    LD A, (IY + FDialogVariable.State)
                CP WAITING_DOWN
                RET
SetWaitDown:    LD (IY + FDialogVariable.CallbackWait), HL
                LD (IY + FDialogVariable.State), WAITING_DOWN
                RET
GetWaitSelect:  LD A, (IY + FDialogVariable.State)
                CP WAITING_SELECT
                RET
                
SetWaitSelect:  LD (IY + FDialogVariable.State), WAITING_SELECT
                RET
SetScroll:      LD (IY + FDialogVariable.State), SCROLL_MSG
                RET
SetCloseDialog: LD (IY + FDialogVariable.State), CLOSE_DLG
                RET
InvokeCallbakWait:
                LD HL, (IY + FDialogVariable.CallbackWait)
                JP (HL)
; -----------------------------------------
; вызов функции
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
InvokeFunc:     ; вызов функции обработчика
                LD HL, (IY + FDialogVariable.Payload)
                LD E, (HL)
                INC HL
                LD D, (HL)
                EX DE, HL
                JP (HL)
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
; -----------------------------------------
; переход к следующему выбору
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ChoiceNext:     LD A, (IY + FDialogVariable.CurSelectionNum)
                INC A
                CP (IY + FDialogVariable.Choice.Number)
                RET NC
                LD (IY + FDialogVariable.CurSelectionNum), A
                DEC A
                LD (IY + FDialogVariable.OldSelectionNum), A
                JP ClearArrowSelect
; -----------------------------------------
; переход к предыдущему выбору
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ChoicePrev:     LD A, (IY + FDialogVariable.CurSelectionNum)
                OR A
                RET Z
                LD (IY + FDialogVariable.OldSelectionNum), A
                DEC (IY + FDialogVariable.CurSelectionNum)
                JP ClearArrowSelect
; -----------------------------------------
; переход к выбраному выбору
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ChoiseSelect:   ; расчёт адреса диалога в зависимости от выбора
                LD B, #00
                LD A, (IY + FDialogVariable.Choice.Number)
                DEC A
                SUB (IY + FDialogVariable.CurSelectionNum)
                LD C, A
                LD HL, (IY + FDialogVariable.Choice.Payload)
                SBC HL, BC

                ; расчёт адреса варианта ответа
                LD C, (HL)  
                ADD HL, BC

                ; проверка завершения диалога
                LD A, (HL)
                CP END_DIALOG
                RET Z                                                           ; завершение диалога

                INC HL
                ; переход к реакии выбора варианта
                LD C, A
                LD B, #00
                ADD HL, BC
                LD C, (HL)  
                ADD HL, BC

                ; переход к следующему диалогу
                CALL Initialize.Dialog
                CALL NextMsg.Initialize

                ; отключить бит обработки выбора
                RES CHOICE_BIT, (IY + FDialogVariable.DlgFlags)
                
                ; очистка текущего курсора
                LD B, (IY + FDialogVariable.CurSelectionNum)
                CALL ClearArrowSelect.B
                JP SetScroll
; -----------------------------------------
; открытие диалога
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Open:           ; инициализация для закрытия выноски
                LD (IY + FDialogVariable.Fade.RowLength), ROW_LENGTH_CHR+1

                ; отображение выноски
                LD HL, SCREEN_CALLOUT
                LD BC, CALLOUT_SIZE
                CALL DrawCallout
                JP SetPrinted
; -----------------------------------------
; закрытие диалога
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Close:          ; выключение диалогов
                CALL Menu.CaptainBridge.CapBridge.ResetDialog
                CALL Menu.CaptainBridge.CapBridge.EnableInput
                RET

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_DIALOG_CORE_
