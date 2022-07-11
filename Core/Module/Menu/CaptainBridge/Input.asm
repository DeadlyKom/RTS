
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

PressLeft:      CALL Room.LeftRotate

                OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET

PressRight:     CALL Room.RightRotate

                OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET

                display " - Input : \t\t\t", /A, InputCapBridge, " = busy [ ", /D, $ - InputCapBridge, " bytes  ]"

                endif ; ~ _CORE_MODULE_CAPTAIN_BRIDGE_INPUT_
