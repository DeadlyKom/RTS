
                ifndef _CORE_MODULE_MENU_OPTIONS_CHANGE_LANGUAGE_
                define _CORE_MODULE_MENU_OPTIONS_CHANGE_LANGUAGE_
Language:       LD A, (OptionsLanguage.Current)

                ; расчёт информации о опции
                LD HL, OptionsLanguage
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

ReqChangeLang:  LD HL, MenuVariables.AddFlags
                LD A, (HL)
                LD (HL), #00
                CP SUBOPTION_LEFT
                JR Z, .Left

                CP SUBOPTION_RIGHT
                JR Z, .Right

                RET

.Left           LD HL, OptionsLanguage.Current
                LD A, (HL)
                CP OptionsLanguage.Num-1
                RET Z
                INC (HL)
                
                ; отрисовка меню
                LD A, (MenuVariables.Current)
                JP SetMenuText

.Right          LD HL, OptionsLanguage.Current
                LD A, (HL)
                OR A
                RET Z
                DEC (HL)

                ; отрисовка меню
                LD A, (MenuVariables.Current)
                JP SetMenuText

OptionsLanguage ; текст в "английский"
                DB 0x10 * 8
                DB Language.Text.Menu.English
                ; текст в "русский"
                DB 0x10 * 8
                DB Language.Text.Menu.Russian
                ; текст в "испанский"
                DB 0x10 * 8
                DB Language.Text.Menu.Spanish
.Num            EQU ($-OptionsLanguage) / 2
.Current        DB #00

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_CHANGE_LANGUAGE_
