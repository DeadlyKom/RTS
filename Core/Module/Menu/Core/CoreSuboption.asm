
                ifndef _CORE_MODULE_MENU_CORE_SUBOPTION_
                define _CORE_MODULE_MENU_CORE_SUBOPTION_

; A - номер меню
; HL - адрес массива подопций
@Suboption:     ; расчёт информации о опции
                LD D, #00
                ADD A, A
                LD E, A
                ADD HL, DE
                LD A, (HL)
                INC HL

                ; копирование текста в буфер
                OR A
                EX AF, AF'
                LD A, (HL)
                JP Functions.TextToBuffer

; B  - максимальное значение
; DE - указатель на текущую подопцию
@ReqChange:     LD HL, MenuVariables.AddFlags
                LD A, (HL)
                LD (HL), #00

                CP SUBOPTION_LEFT
                JR Z, .Left

                CP SUBOPTION_RIGHT
                JR Z, .Right

                RET

.Left           LD A, (DE)
                CP B
                RET Z

                EX DE, HL
                INC (HL)
                
                JP RefreshMenuText

.Right          LD A, (DE)
                OR A
                RET Z

                EX DE, HL
                DEC (HL)

                JP RefreshMenuText

                display " - Core Suboption : \t\t", /A, Suboption, " = busy [ ", /D, $ - Suboption, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_CORE_SUBOPTION_
