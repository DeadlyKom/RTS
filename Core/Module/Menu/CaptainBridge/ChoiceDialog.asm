
                ifndef _CORE_MODULE_MENU_MAIN_CAPTAIN_BRIDGE_CHOICE_DIALOG_
                define _CORE_MODULE_MENU_MAIN_CAPTAIN_BRIDGE_CHOICE_DIALOG_

Recruit:        LD HL, Dialog.SetCloseDialog                                    ; после нажатия (вызывать функцию SetCloseDialog)
                JP Dialog.SetWaitDown
                ; JP Dialog.SetCloseDialog
Veteran:        LD HL, Dialog.SetCloseDialog                                    ; после нажатия (вызывать функцию SetCloseDialog)
                JP Dialog.SetWaitDown
                ; JP Dialog.SetCloseDialog

                endif ; ~ _CORE_MODULE_MENU_MAIN_CAPTAIN_BRIDGE_CHOICE_DIALOG_
