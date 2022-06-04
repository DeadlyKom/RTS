
                ifndef _CORE_MODULE_MENU_MAIN_
                define _CORE_MODULE_MENU_MAIN_

                ; include "Sprites/Menu/Main/Compress.inc"
Main:           ; загрузка языка
                LD A, LANGUAGE_DEFAULT
                CALL Functions.ChangeLanguage

                ; загрузка текста главного меню
                LD A, LANGUAGE_DEFAULT
                CALL LoadText

                ; инициализация таблицы текста
                LD HL, Adr.Module.Text
                LD (LocalizationRef), HL
       
.Reset          ; подготовка экрана 1
                SET_SCREEN_BASE
                CLS_C000
                ATTR_C000_IPB RED, BLACK, 1

                ; подготовка экрана 2
                SET_SCREEN_SHADOW
                CLS_C000
                ATTR_C000_IPB RED, BLACK, 0

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
                LD HL, MainMenu
                LD (MenuVariables.Options), HL
                XOR A
                LD (MenuVariables.Current), A
                LD (MenuVariables.Flags), A

                ; отрисовка меню
                LD HL, MainMenu
                LD A, (HL)
                LD (MenuVariables.NumberOptions), A
                CALL SetMenuText
                CALL SetFadeinVFX

                SetUserHendler INT_Handler

.Loop           HALT

                LD HL, MenuVariables.Flags
                BIT NEXT_FADE_BIT, (HL)
                CALL NZ, PreFadeinText

                LD HL, MenuVariables.Flags
                BIT ALL_FADE_BIT, (HL)
                JP NZ, Select

                JR .Loop
MainMenu:       DB .Num-1
.First          ; текст в "настройки"
                DW #1413
                DB Language.Text.Menu.Options
                ; текст в "продолжить"
                DW #1313
                DB Language.Text.Menu.Continue
                ; текст в "новая игра"
                DW #1213
                DB Language.Text.Menu.NewGame
.Num            EQU ($-MainMenu-1) / 3

                ; ; отрисовка надпись
                ; LD HL, PlanetSprAttr
                ; LD DE, #DB00
                ; CALL Loader.Decompressor.Forward
                ; DrawSpriteATTR #DB00, 11, 6, 11, 11

                ; ; отрисовка надпись
                ; LD HL, Atmosphere7SprAttr
                ; LD DE, #DB00
                ; CALL Loader.Decompressor.Forward
                ; DrawSpriteATTR #DB00, 11, 8, 6, 5

; PlanetSprAttr  incbin "../../../../Sprites/Menu/Main/Compressed/Planet.ar.spr"
; Atmosphere7SprAttr  incbin "../../../../Sprites/Menu/Main/Compressed/Atmosphere7.ar.spr"

                display " - Main : \t\t\t", /A, Main, " = busy [ ", /D, $ - Main, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_MAIN_
