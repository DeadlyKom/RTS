
                ifndef _CORE_MODULE_MENU_OPTIONS_CHANGE_LANGUAGE_
                define _CORE_MODULE_MENU_OPTIONS_CHANGE_LANGUAGE_
Language:       LD A, (OptionsLanguage.Current)
                LD HL, OptionsLanguage
                JP Suboption

ReqChangeLang:  LD DE, OptionsLanguage.Current
                LD B, OptionsLanguage.Num
                JP ReqChange

OptionsLanguage ; текст в "английский"
                DB 0x16 * 8
                DB Language.Text.Menu.English
                ; текст в "русский"
                DB 0x16 * 8
                DB Language.Text.Menu.Russian
                ; текст в "испанский"
                DB 0x16 * 8
                DB Language.Text.Menu.Spanish
.Num            EQU (($-OptionsLanguage) / 2)-1
.Current        DB #00

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_CHANGE_LANGUAGE_
