
                ifndef _CORE_MODULE_MENU_MAIN_INPUT_
                define _CORE_MODULE_MENU_MAIN_INPUT_

                ; ***** InputDefault *****
InputDefault:   JR NZ, .Processing                                              ; skip released
                EX AF, AF'
.NotProcessing  SCF
                RET

.Processing     EX AF, AF'
                CP DEFAULT_UP
                JP Z, PressUp
                CP DEFAULT_DOWN
                JP Z, PressDown
                CP DEFAULT_SELECT
                JP Z, PressSelect
                JR .NotProcessing
PressUp:        LD HL, Menu.Current
                LD A, (HL)
                CP Menu.Num-1
                RET Z
                LD C, A

                ; проверка ранее установленного флага CHANGE_BIT
                INC HL
                BIT CHANGE_BIT, (HL)
                RET NZ
                SET CHANGE_BIT, (HL)
                DEC HL

                INC C
                LD (HL), C
                RET
PressDown:      LD HL, Menu.Current
                LD A, (HL)
                OR A
                RET Z
                LD C, A

                ; проверка ранее установленного флага CHANGE_BIT
                INC HL
                BIT CHANGE_BIT, (HL)
                RET NZ
                SET CHANGE_BIT, (HL)
                DEC HL
                
                DEC C
                LD (HL), C

                RET
PressSelect:    LD HL, Menu.Flag
                ; проверка ранее установленного флага SELECT_BIT
                BIT SELECT_BIT, (HL)
                RET NZ
                SET SELECT_BIT, (HL)

                RET

                endif ; ~ _CORE_MODULE_MENU_MAIN_INPUT_