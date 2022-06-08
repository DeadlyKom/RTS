
                ifndef _CORE_MODULE_MENU_OPTIONS_CONTROL_CHANGE_MOUSE_
                define _CORE_MODULE_MENU_OPTIONS_CONTROL_CHANGE_MOUSE_
Mouse:          LD A, (OptionsMouse.Current)
                LD HL, OptionsMouse
                JP Suboption

ReqChangeMouse: LD DE, OptionsMouse.Current
                LD B, OptionsMouse.Num
                JP ReqChange

OptionsMouse    ; текст в "правша"
                DB 0x16 * 8
                DB Language.Text.Menu.RightHanded
                ; текст в "левша"
                DB 0x16 * 8
                DB Language.Text.Menu.LeftHanded
.Num            EQU (($-OptionsMouse) / 2)-1
.Current        DB #00

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_CONTROL_CHANGE_MOUSE_
