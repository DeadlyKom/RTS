
                ifndef _CORE_MODULE_MENU_OPTIONS_CHANGE_CONTROL_
                define _CORE_MODULE_MENU_OPTIONS_CHANGE_CONTROL_
ControlHelp:    LD A, (TextControlHelp.Current)
                LD HL, TextControlHelp
                JP Suboption

ReqChangeCH:    LD DE, TextControlHelp.Current
                LD B, TextControlHelp.Num
                JP ReqChange

TextControlHelp ; текст в "клавиатура"
                DB 0x16 * 8
                DB Language.Text.Menu.KeyboardSel
                ; текст в "кемпстон"
                DB 0x16 * 8
                DB Language.Text.Menu.KempstonSel
                ; текст в "мышь"
                DB 0x16 * 8
                DB Language.Text.Menu.MouseSel
.Num            EQU (($-TextControlHelp) / 2)-1
.Current        DB #01

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_CHANGE_CONTROL_
