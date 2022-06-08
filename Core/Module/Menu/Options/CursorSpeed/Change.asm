
                ifndef _CORE_MODULE_MENU_OPTIONS_CHANGE_CURSOR_SPEED_
                define _CORE_MODULE_MENU_OPTIONS_CHANGE_CURSOR_SPEED_
CursorSpeed:    LD A, (OptionsCursorSpeed.Current)
                LD HL, OptionsCursorSpeed
                JP Suboption

ReqChangeCS:    LD DE, OptionsCursorSpeed.Current
                LD B, OptionsCursorSpeed.Num
                JP ReqChange

OptionsCursorSpeed ; текст в "быстрая скорость"
                DB 0x16 * 8
                DB Language.Text.Menu.Fast
                ; текст в "нормальная скорость"
                DB 0x16 * 8
                DB Language.Text.Menu.Normal
                ; текст в "медленная скорость"
                DB 0x16 * 8
                DB Language.Text.Menu.Slow
.Num            EQU (($-OptionsCursorSpeed) / 2)-1
.Current        DB #01

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_CHANGE_CURSOR_SPEED_
