
                ifndef _CORE_MODULE_MENU_MAIN_
                define _CORE_MODULE_MENU_MAIN_

                ; include "Sprites/Menu/Main/Compress.inc"
Main:           SET_LANGUAGE LANGUAGE_DEFAULT
                CALL SetLanguage
@Main.Back      ; вернутся в главное меню

                ; подготовка
                CALL CLS                                                        ; очистка экранов
                CALL ResetOptions                                               ; сброс опций

                ; инициализация переменных работы с меню
                LD HL, Changed
                LD (MenuVariables.Changed), HL
                LD HL, Selected
                LD (MenuVariables.Selected), HL
                LD HL, CanBeSelected
                LD (MenuVariables.CanSelected), HL
                LD HL, MainMenu
                LD (MenuVariables.Options), HL

                ; отрисовка меню
                LD HL, MainMenu
                CALL SetFirstOption

.Loop           HALT

                LD HL, MenuVariables.Flags
                BIT NEXT_FADE_BIT, (HL)
                CALL NZ, PreFadeinText

                LD HL, MenuVariables.Flags
                BIT ALL_FADE_BIT, (HL)
                JP NZ, SelectHandler

                JR .Loop
MainMenu:       DB .Num-1
                ; текст в "настройки"
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
