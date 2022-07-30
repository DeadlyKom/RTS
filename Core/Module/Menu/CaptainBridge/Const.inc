
                ifndef _CORE_MODULE_MENU_MAIN_CAPTAIN_BRIDGE_CONST_
                define _CORE_MODULE_MENU_MAIN_CAPTAIN_BRIDGE_CONST_
ENABLE_INPUT_BIT EQU 0x07                                                       ; бит, включения/выключения обработки ввода
DLG_ENABLE_BIT  EQU 0x06                                                        ; бит, включения/выключения обработки диалогов
INTERACT_BIT    EQU 0x05                                                        ; бит, интерактивности на капитанском мостике

ENABLE_INPUT    EQU 1 << ENABLE_INPUT_BIT
DLG_ENABLE      EQU 1 << DLG_ENABLE_BIT

                endif ; ~ _CORE_MODULE_MENU_MAIN_CAPTAIN_BRIDGE_CONST_
