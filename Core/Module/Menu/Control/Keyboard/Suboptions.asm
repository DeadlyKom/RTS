
                ifndef _CORE_MODULE_MENU_OPTIONS_SUBOPTIONS_CONTROL_KEYBOARD_
                define _CORE_MODULE_MENU_OPTIONS_SUBOPTIONS_CONTROL_KEYBOARD_

SuboptionsControl
                LD HL, DefaultKeyUpRef
                LD BC, (OPTION_KEY_NUM << 8) | OPTION_UP
                LD A, (MenuVariables.Current)

.Loop           CP C
                JR Z, .Set
                INC HL
                DEC C
                DJNZ .Loop

                RET

.Set            LD A, (HL)
                ADD A, Language.Text.Menu.KEY_CAPS_SHIFT
                LD (OptionsKeys.ID_Keys), A
                XOR A
                LD HL, OptionsKeys
                JP Suboption

OptionsKeys:    DB 0x16 * 8
.ID_Keys        DB Language.Text.Menu.KEY_CAPS_SHIFT

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_SUBOPTIONS_CONTROL_KEYBOARD_
