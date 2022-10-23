
                ifndef _CORE_MODULE_MENU_CORE_INPUT_
                define _CORE_MODULE_MENU_CORE_INPUT_

                ; ***** InputDefault *****
@InputDefault:  JR NZ, .Processing                                              ; skip released
                EX AF, AF'
.NotProcessing  SCF
                RET

.Processing     ; сброс флагов смены опций
                XOR A
                LD (MenuVariables.AddFlags), A

                ; опрос нажатой клавиши
                EX AF, AF'
                CP KEY_ID_UP
                JP Z, PressUp
                
                CP KEY_ID_DOWN
                JP Z, PressDown

                CP KEY_ID_LEFT
                JP Z, PressLeft

                CP KEY_ID_RIGHT
                JP Z, PressRight

                CP KEY_ID_SELECT
                JP Z, PressSelect

                JR .NotProcessing
PressUp:        LD HL, MenuVariables.OptionsMax
                LD A, (HL)
                INC HL
                INC HL
                CP (HL)
                JR Z, InputDefault.NotProcessing                                ; обработка клавиши не произведена

                ; проверка ранее установленного флага CHANGE_BIT
                INC HL
                BIT CHANGE_BIT, (HL)
                JR NZ, InputDefault.NotProcessing                                ; обработка клавиши не произведена
                SET CHANGE_BIT, (HL)
                DEC HL

                INC (HL)

                OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET
PressDown:      LD HL, MenuVariables.OptionsMin
                LD A, (HL)
                INC HL
                CP (HL)
                JR NC, InputDefault.NotProcessing                                ; обработка клавиши не произведена

                ; проверка ранее установленного флага CHANGE_BIT
                INC HL
                BIT CHANGE_BIT, (HL)
                JR NZ, InputDefault.NotProcessing                                ; обработка клавиши не произведена
                SET CHANGE_BIT, (HL)
                DEC HL
                
                DEC (HL)

                OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET
PressLeft:      ; проверка ранее установленного флага SELECT_BIT
                LD HL, MenuVariables.Flags
                BIT CHANGE_BIT, (HL)
                JR NZ, InputDefault.NotProcessing                               ; обработка клавиши не произведена
                SET CHANGE_BIT, (HL)
                SET OPTION_BIT, (HL)
                INC HL
                LD (HL), SUBOPTION_LEFT
                
                OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET
PressRight:     ; проверка ранее установленного флага SELECT_BIT
                LD HL, MenuVariables.Flags
                BIT CHANGE_BIT, (HL)
                JR NZ, InputDefault.NotProcessing                               ; обработка клавиши не произведена
                SET CHANGE_BIT, (HL)
                SET OPTION_BIT, (HL)
                INC HL
                LD (HL), SUBOPTION_RIGHT
                
                OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET
PressSelect:    ; проверка ранее установленного флага SELECT_BIT
                LD HL, MenuVariables.Flags
                BIT SELECT_BIT, (HL)
                JR NZ, InputDefault.NotProcessing                               ; обработка клавиши не произведена
                SET SELECT_BIT, (HL)

                OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET

                display " - Input Default : \t\t\t\t\t", /A, InputDefault, " = busy [ ", /D, $ - InputDefault, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_CORE_INPUT_