
                ifndef _CORE_MODULE_MENU_OPTIONS_
                define _CORE_MODULE_MENU_OPTIONS_
@MenuOptions:   ; сброс
                CALL ResetOptions
                
                ; инициализация переменных работы с настройками
                LD HL, Changed
                LD (MenuVariables.Changed), HL
                LD HL, Selected
                LD (MenuVariables.Selected), HL
                LD HL, CanSelected
                LD (MenuVariables.CanSelected), HL
                LD HL, OptionsMenu
                LD (MenuVariables.Options), HL
                LD HL, SuboptionsMenu
                LD (MenuVariables.SuboptionsFunc), HL
                XOR A
                LD (MenuVariables.Current), A
                LD (MenuVariables.Flags), A

                ; отрисовка меню
                LD HL, OptionsMenu
                CALL SetFirstOption

.Loop           HALT

                LD HL, MenuVariables.Flags
                BIT NEXT_FADE_BIT, (HL)
                CALL NZ, PreFadeinText

                LD HL, MenuVariables.Flags
                BIT ALL_FADE_BIT, (HL)
                JP NZ, SelectHandler

                JR .Loop
LanguageCoord   EQU #0A02
OptionsMenu:    DB .Num-1
.First          ; текст в "вернутся"
                DW #0E03
                DB Language.Text.Menu.Back
                ; текст в "скорость курсора"
                DW #0D02
                DB Language.Text.Menu.CursorSpeed
                ; текст в "скорость игры"
                DW #0C02
                DB Language.Text.Menu.GameSpeed
                ; текст в "управление"
                DW #0B02
                DB Language.Text.Menu.Control
                ; текст в "язык"
                DW LanguageCoord
                DB Language.Text.Menu.Language
.Num            EQU ($-OptionsMenu-1) / 3

                display " - Options : \t\t\t", /A, MenuOptions, " = busy [ ", /D, $ - MenuOptions, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_
