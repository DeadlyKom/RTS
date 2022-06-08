
                ifndef _CORE_MODULE_MENU_OPTIONS_SUBOPTIONS_CONTROL_
                define _CORE_MODULE_MENU_OPTIONS_SUBOPTIONS_CONTROL_

SuboptionsControl LD A, (MenuVariables.Current)

                CP OPTIONS_KEMPSTON
                JP Z, KEMPSTON

                CP OPTIONS_MOUSE
                JP Z, Mouse

                ; CP OPTIONS_KEYBOARD
                ; JP Z, $

                RET

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_SUBOPTIONS_CONTROL_
