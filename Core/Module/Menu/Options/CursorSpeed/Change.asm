
                ifndef _CORE_MODULE_MENU_OPTIONS_CHANGE_CURSOR_SPEED_
                define _CORE_MODULE_MENU_OPTIONS_CHANGE_CURSOR_SPEED_
CursorSpeed:    LD A, (OptionsCursorSpeed.Current)

                ; расчёт информации о опции
                LD HL, OptionsCursorSpeed
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

ReqChangeCS:    LD HL, MenuVariables.AddFlags
                LD A, (HL)
                LD (HL), #00
                CP SUBOPTION_LEFT
                JR Z, .Left

                CP SUBOPTION_RIGHT
                JR Z, .Right

                RET

.Left           LD HL, OptionsCursorSpeed.Current
                LD A, (HL)
                CP OptionsCursorSpeed.Num-1
                RET Z
                INC (HL)
                
                ; отрисовка меню
                LD A, (MenuVariables.Current)
                JP SetMenuText

.Right          LD HL, OptionsCursorSpeed.Current
                LD A, (HL)
                OR A
                RET Z
                DEC (HL)

                ; отрисовка меню
                LD A, (MenuVariables.Current)
                JP SetMenuText

OptionsCursorSpeed ; текст в "быстрая скорость"
                DB 0x10 * 8
                DB Language.Text.Menu.Fast
                ; текст в "нормальная скорость"
                DB 0x10 * 8
                DB Language.Text.Menu.Normal
                ; текст в "медленная скорость"
                DB 0x10 * 8
                DB Language.Text.Menu.Slow
.Num            EQU ($-OptionsCursorSpeed) / 2
.Current        DB #01

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_CHANGE_CURSOR_SPEED_
