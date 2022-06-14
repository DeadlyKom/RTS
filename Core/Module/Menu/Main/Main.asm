
                ifndef _CORE_MODULE_MENU_MAIN_
                define _CORE_MODULE_MENU_MAIN_

                ; include "Sprites/Menu/Main/Compress.inc"
Main:           SET_LANGUAGE LANGUAGE_DEFAULT
                CALL SetLanguage
@Main.Back      ; вернутся в главное меню

                ; подготовка
                CALL CLS                                                        ; очистка экранов
                CALL ResetOptions                                               ; сброс опций

                ;
                HALT
                SET_SCREEN_BASE
                LD HL, SprA
                CALL DrawStencilSpr

                HALT
                SET_SCREEN_SHADOW
                LD HL, SprB
                CALL DrawStencilSpr
                HALT

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
SprA:           incbin "Core/Module/Sprites/Menu/Main/NubulaA0.spr"
                incbin "Core/Module/Sprites/Menu/Main/NubulaA1.spr"
                incbin "Core/Module/Sprites/Menu/Main/NubulaA2.spr"
                incbin "Core/Module/Sprites/Menu/Main/NubulaA3.spr"
                incbin "Core/Module/Sprites/Menu/Main/NubulaA4.spr"
                incbin "Core/Module/Sprites/Menu/Main/NubulaA5.spr"
                DW #0000
SprB:           incbin "Core/Module/Sprites/Menu/Main/NubulaB0.spr"
                incbin "Core/Module/Sprites/Menu/Main/NubulaB1.spr"
                incbin "Core/Module/Sprites/Menu/Main/NubulaB2.spr"
                incbin "Core/Module/Sprites/Menu/Main/NubulaB3.spr"
                incbin "Core/Module/Sprites/Menu/Main/NubulaB4.spr"
                incbin "Core/Module/Sprites/Menu/Main/NubulaB5.spr"
                DW #0000

                display " - Main : \t\t\t", /A, Main, " = busy [ ", /D, $ - Main, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_MAIN_
