
                ifndef _CORE_MODULE_CAPTAIN_BRIDGE_INPUT_
                define _CORE_MODULE_CAPTAIN_BRIDGE_INPUT_

                ; ***** InputDefault *****
InputCapBridge: JR NZ, .Processing                                              ; skip released
                EX AF, AF'
.NotProcessing  SCF
                RET

.Processing     ; опрос нажатой клавиши
                EX AF, AF'
                CP DEFAULT_UP
                JP Z, $
                
                CP DEFAULT_DOWN
                JP Z, $

                CP DEFAULT_LEFT
                JP Z, PressLeft

                CP DEFAULT_RIGHT
                JP Z, PressRight

                CP DEFAULT_SELECT
                JP Z, $

                JR .NotProcessing

Processed:      OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET

PressLeft:      CALL GetDialog
                JR Z, .NotDialog
                
                ; -----------------------------------------
                ; обработка клавиши (диалог включен)
                ; -----------------------------------------
                CALL Dialog.GetWaitInput
                JR NZ, Processed
                
                ; диалог в состоянии ожидания нажатия клавиши
                CALL DisableInput
                CALL Dialog.ClearArrow
                JP Dialog.SetScroll

.NotDialog      ; -----------------------------------------
                ; обработка клавиши (диалог отключен)
                ; -----------------------------------------
                CALL Room.LeftRotate

                JR Processed

PressRight:     CALL Room.RightRotate

                JR Processed

                display " - Input : \t\t\t", /A, InputCapBridge, " = busy [ ", /D, $ - InputCapBridge, " bytes  ]"

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_INPUT_
