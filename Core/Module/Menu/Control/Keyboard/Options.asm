
                ifndef _CORE_MODULE_MENU_OPTIONS_COTROL_KEYBOARD_
                define _CORE_MODULE_MENU_OPTIONS_COTROL_KEYBOARD_
@MenuControlKey:; сброс
                CALL ResetOptions
                
                ; инициализация переменных работы с настройками
                LD HL, Changed
                LD (MenuVariables.Changed), HL
                LD HL, Selected
                LD (MenuVariables.Selected), HL
                LD HL, CanSelected
                LD (MenuVariables.CanSelected), HL
                LD HL, ControlKeys
                LD (MenuVariables.Options), HL
                LD HL, SuboptionsControl
                LD (MenuVariables.SuboptionsFunc), HL
                XOR A
                LD (MenuVariables.Current), A
                LD (MenuVariables.Flags), A

                ; отрисовка меню
                LD HL, ControlKeys
                CALL SetFirstOption

.Loop           HALT

                LD HL, MenuVariables.Flags
                BIT NEXT_FADE_BIT, (HL)
                CALL NZ, PreFadeinText

                LD HL, MenuVariables.Flags
                BIT ALL_FADE_BIT, (HL)
                JP NZ, SelectHandler

                JR .Loop
ControlKeys:    DB .Num-1
.First          ; текст в "вернутся"
                DW #1403
                DB Language.Text.Menu.Back
                ; текст в "меню/пауза"
                DW #1202
                DB Language.Text.Menu.MenuPause
                ; текст в "ускорение прокрутки"
                DW #1102
                DB Language.Text.Menu.SpeedScroll
                ; текст в "отмена выбора"
                DW #1002
                DB Language.Text.Menu.Deselect
                ; текст в "выбор"
                DW #0F02
                DB Language.Text.Menu.Select
                ; текст в "вправо"
                DW #0E02
                DB Language.Text.Menu.Right
                ; текст в "влево"
                DW #0D02
                DB Language.Text.Menu.Left
                ; текст в "вниз"
                DW #0C02
                DB Language.Text.Menu.Down
                ; текст в "вверх"
                DW #0B02
                DB Language.Text.Menu.Up
.Num            EQU ($-ControlKeys-1) / 3

                display " - Keyboard : \t\t", /A, MenuControlKey, " = busy [ ", /D, $ - MenuControlKey, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_COTROL_KEYBOARD_
