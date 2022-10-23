
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_INPUT_
                define _CORE_MODULE_CAPTAIN_BRIDGE_INPUT_

                ; ***** InputDefault *****
InputCapBridge: JR NZ, .Processing                                              ; skip released
                EX AF, AF'
.NotProcessing  SCF
                RET

.Processing     ; опрос нажатой клавиши
                EX AF, AF'
                CP KEY_ID_UP
                JP Z, PressedUp
                
                CP KEY_ID_DOWN
                JP Z, PressedDown

                CP KEY_ID_LEFT
                JP Z, PressedLeft

                CP KEY_ID_RIGHT
                JP Z, PressedRight

                CP KEY_ID_SELECT
                JP Z, PressedSelect

                JR .NotProcessing

Processed:      OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET

PressedUp:      ; -----------------------------------------
                ;
                ; -----------------------------------------
                
                ; проверка отображения диалога
                CALL GetDialog
                JR Z, .NotDialog

                ; проверка состояния "выбора"
                CALL Dialog.GetWaitSelect
                JR Z, .Pressed

                ; обработка состояния "следующее сообщение"
                JR DialogWaitDown

.NotDialog      ; обработка клавиши (диалог отключен)
                JR Processed

.Pressed        ; обработка клавиши (нажата вверх)
                JP Dialog.ChoicePrev
PressedDown:    ; -----------------------------------------
                ;
                ; -----------------------------------------
                
                ; проверка отображения диалога
                CALL GetDialog
                JR Z, .NotDialog

                ; проверка состояния "выбора"
                CALL Dialog.GetWaitSelect
                JR Z, .Pressed

                ; обработка состояния "следующее сообщение"
                JR DialogWaitDown

.NotDialog      ; обработка клавиши (диалог отключен)
                JR Processed

.Pressed        ; обработка клавиши (нажата вниз)
                JP Dialog.ChoiceNext
PressedLeft:    ; -----------------------------------------
                ;
                ; -----------------------------------------
                
                ; проверка отображения диалога
                CALL GetDialog
                JR Z, .NotDialog

                ; проверка состояния "выбора"
                CALL Dialog.GetWaitSelect
                JR NZ, DialogWaitDown                                           ; обработка состояния "следующее сообщение"
                JR Processed

.NotDialog      ; обработка клавиши (диалог отключен)
                JP Room.LeftRotate
                ; JR Processed

.Pressed        ; обработка клавиши (нажата вниз)
                JR$
PressedRight:   ; -----------------------------------------
                ;
                ; -----------------------------------------
                
                ; проверка отображения диалога
                CALL GetDialog
                JR Z, .NotDialog

                ; проверка состояния "выбора"
                CALL Dialog.GetWaitSelect
                JR NZ, DialogWaitDown                                           ; обработка состояния "следующее сообщение"
                JR Processed

.NotDialog      ; обработка клавиши (диалог отключен)
                JP Room.RightRotate
                ; JR Processed

.Pressed        ; обработка клавиши (нажата вниз)
                JR$
PressedSelect:  ; -----------------------------------------
                ;
                ; -----------------------------------------
                
                ; проверка отображения диалога
                CALL GetDialog
                JR Z, .NotDialog

                ; проверка состояния "выбора"
                CALL Dialog.GetWaitSelect
                JR Z, .Pressed

                ; обработка состояния "следующее сообщение"
                JR DialogWaitDown

.NotDialog      ; обработка клавиши (диалог отключен)
                CALL SetInteract
                JR Processed

.Pressed        ; обработка клавиши (нажата вниз)
                JP Dialog.ChoiseSelect

DialogWaitDown: ; -----------------------------------------
                ; стрелка вниз
                ; -----------------------------------------
                CALL Dialog.GetWaitDown
                JR NZ, Processed
                
                ; диалог в состоянии ожидания нажатия клавиши
                CALL DisableInput
                CALL Dialog.ClearArrowDown
                JP Dialog.InvokeCallbakWait

                display " - Input : \t\t\t\t\t\t", /A, InputCapBridge, " = busy [ ", /D, $ - InputCapBridge, " bytes  ]"

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_INPUT_
