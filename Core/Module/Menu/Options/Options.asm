
                ifndef _CORE_MODULE_MENU_OPTIONS_
                define _CORE_MODULE_MENU_OPTIONS_
@Options:       
.Reset          SET_SCREEN_SHADOW

                ; инициализация VFX
                LD IY, VariablesVFX
                LD HL, UpdateTextVFX
                LD (IY + FTVFX.FrameComplited), HL
                LD HL, FadeinNextText
                LD (IY + FTVFX.VFX_Complited), HL
                
                ; инициализация переменных работы с меню
                LD HL, ChangeMenu
                LD (MenuVariables.Changed), HL
                LD HL, SelectMenu
                LD (MenuVariables.Selected), HL
                LD HL, OptionsMenu
                LD (MenuVariables.Options), HL
                XOR A
                LD (MenuVariables.Current), A
                LD (MenuVariables.Flags), A

                ; отрисовка меню
                LD HL, OptionsMenu
                LD A, (HL)
                LD (MenuVariables.NumberOptions), A
                CALL SetMenuText
                CALL SetFadeinVFX

.Loop           HALT

                LD HL, MenuVariables.Flags
                BIT NEXT_FADE_BIT, (HL)
                CALL NZ, PreFadeinText

                LD HL, MenuVariables.Flags
                BIT ALL_FADE_BIT, (HL)
                JP NZ, Select

                JR .Loop
OptionsMenu:    DB .Num-1
.First          ; текст в "настройки"
                DW #1413
                DB Language.Text.Menu.Options
                ; текст в "продолжить"
                DW #1313
                DB Language.Text.Menu.Continue
                ; текст в "новая игра"
                DW #1213
                DB Language.Text.Menu.NewGame
.Num            EQU ($-OptionsMenu-1) / 3

                display " - Options : \t\t\t", /A, Options, " = busy [ ", /D, $ - Options, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_
