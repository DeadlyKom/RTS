
                ifndef _CORE_MODULE_MENU_OPTIONS_
                define _CORE_MODULE_MENU_OPTIONS_

LanguageCoord   EQU #0A02
ControlCoord    EQU #0B02
AudioCoord      EQU #0C02
GraphicsCoord   EQU #0D02
GameSpeedCoord  EQU #0E02
CursorSpeedCoord EQU #0F02
BackCoord       EQU #1105
ApplyCoord      EQU #1113
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
OptionsMenu:    DB .Num-1
                ; текст в "применить"
                DW ApplyCoord
                DB Language.Text.Menu.Apply
                ; текст в "вернутся"
                DW BackCoord
                DB Language.Text.Menu.Back
                ; текст в "скорость курсора"
                DW CursorSpeedCoord
                DB Language.Text.Menu.CursorSpeed
                ; текст в "скорость игры"
                DW GameSpeedCoord
                DB Language.Text.Menu.GameSpeed
                ; текст в "графика"
                DW GraphicsCoord
                DB Language.Text.Menu.Graphics
                ; текст в "аудио"
                DW AudioCoord
                DB Language.Text.Menu.Audio
                ; текст в "управление"
                DW ControlCoord
                DB Language.Text.Menu.Control
                ; текст в "язык"
                DW LanguageCoord
                DB Language.Text.Menu.Language
.Num            EQU ($-OptionsMenu-1) / 3

                display " - Options : \t\t\t", /A, MenuOptions, " = busy [ ", /D, $ - MenuOptions, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_
