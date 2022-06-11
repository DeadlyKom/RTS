
                ifndef _CORE_MODULE_MENU_OPTIONS_COTROL_
                define _CORE_MODULE_MENU_OPTIONS_COTROL_
@MenuControl:   ; сброс
                CALL ResetOptions
                
                ; инициализация переменных работы с настройками
                LD HL, Changed
                LD (MenuVariables.Changed), HL
                LD HL, Selected
                LD (MenuVariables.Selected), HL
                LD HL, CanSelected
                LD (MenuVariables.CanSelected), HL
                LD HL, ControlMenu
                LD (MenuVariables.Options), HL
                LD HL, SuboptionsControl
                LD (MenuVariables.SuboptionsFunc), HL

                ; отрисовка меню
                LD HL, ControlMenu
                CALL SetFirstOption

.Loop           HALT

                LD HL, MenuVariables.Flags
                BIT NEXT_FADE_BIT, (HL)
                CALL NZ, PreFadeinText

                LD HL, MenuVariables.Flags
                BIT ALL_FADE_BIT, (HL)
                JP NZ, SelectHandler

                JR .Loop
ControlMenu:    DB .Num-1
                ; текст в "вернутся"
                DW #0F03
                DB Language.Text.Menu.Back
                ; текст в "клавиатура"
                DW #0D02
                DB Language.Text.Menu.Keyboard
                ; текст в "мышь"
                DW #0C02
                DB Language.Text.Menu.Mouse
                ; текст в "KEMPSTON"
                DW #0B02
                DB Language.Text.Menu.Kempston
.Num            EQU ($-ControlMenu-1) / 3

                display " - Control : \t\t\t", /A, MenuControl, " = busy [ ", /D, $ - MenuControl, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_COTROL_
