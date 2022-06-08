
                ifndef _CORE_MODULE_MENU_OPTIONS_CHANGE_GAME_SPEED_
                define _CORE_MODULE_MENU_OPTIONS_CHANGE_GAME_SPEED_
GameSpeed:      LD A, (OptionsGameSpeed.Current)
                LD HL, OptionsGameSpeed
                JP Suboption

ReqChangeGS:    LD DE, OptionsGameSpeed.Current
                LD B, OptionsGameSpeed.Num
                JP ReqChange

OptionsGameSpeed; текст в "быстрая скорость"
                DB 0x16 * 8
                DB Language.Text.Menu.Fast
                ; текст в "нормальная скорость"
                DB 0x16 * 8
                DB Language.Text.Menu.Normal
                ; текст в "медленная скорость"
                DB 0x16 * 8
                DB Language.Text.Menu.Slow
.Num            EQU (($-OptionsGameSpeed) / 2)-1
.Current        DB #01

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_CHANGE_GAME_SPEED_
