
                ifndef _CORE_MODULE_MENU_OPTIONS_SUBOPTIONS_CONTROL_KEYBOARD_
                define _CORE_MODULE_MENU_OPTIONS_SUBOPTIONS_CONTROL_KEYBOARD_

SuboptionsControl
                LD HL, GameConfig.KeyUp
                LD BC, (OPTION_KEY_NUM << 8) | OPTION_UP
                LD A, (MenuVariables.Current)

.Loop           CP C
                JR Z, .Set
                DEC HL
                DEC C
                DJNZ .Loop

                RET

.Set            LD A, (HL)
                CP VK_NONE
                JR C, .IsValid

                ; символ '-' или '?' если отсутствует клавиша
                SUB VK_NONE
                ADD A, Language.Text.Menu.KEY_NONE
                
.IsValid        ADD A, Language.Text.Menu.KEY_CAPS_SHIFT
                LD (OptionsKeys.ID_Keys), A

                XOR A
                LD HL, OptionsKeys
                JP SuboptionText

OptionsKeys:    DB 0x15 * 8
.ID_Keys        DB Language.Text.Menu.KEY_CAPS_SHIFT

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_SUBOPTIONS_CONTROL_KEYBOARD_
