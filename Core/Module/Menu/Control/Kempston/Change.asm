
                ifndef _CORE_MODULE_MENU_OPTIONS_CONTROL_CHANGE_KEMPSTON_
                define _CORE_MODULE_MENU_OPTIONS_CONTROL_CHANGE_KEMPSTON_
KEMPSTON:       LD A, (OptionsKEMPSTON.Current)
                LD HL, OptionsKEMPSTON
                JP Suboption

ReqChangeKEMPSTON
                LD DE, OptionsKEMPSTON.Current
                LD B, OptionsKEMPSTON.Num
                JP ReqChange

OptionsKEMPSTON ; текст в "8 кнопочный"
                DB 0x16 * 8
                DB Language.Text.Menu.Button_8
                ; текст в "классический"
                DB 0x16 * 8
                DB Language.Text.Menu.Classic
.Num            EQU (($-OptionsKEMPSTON) / 2)-1
.Current        DB #00

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_CONTROL_CHANGE_KEMPSTON_
