
                ifndef _CORE_MODULE_MENU_MAIN_
                define _CORE_MODULE_MENU_MAIN_

                include "Sprites/Menu/Main/Compress.inc"
Main:           ; загрузка языка
                LD A, LANGUAGE_DEFAULT
                CALL Functions.ChangeLanguage

                ; загрузка текста главного меню
                LD A, LANGUAGE_DEFAULT
                CALL MainLoadText

                ; инициализация таблицы текста
                LD HL, Adr.MainMenuText
                LD (LocalizationRef), HL
       
                ; подготовка экрана 1
                CALL SetPage5
                CLS_C000
                ATTR_C000_IPB RED, BLACK, 1

                ; отрисовка надпись Loading
                LD HL, PlanetSprAttr
                LD DE, #DB00
                CALL Loader.Decompressor.Forward
                DrawSpriteATTR #DB00, 11, 6, 11, 11

                ; вывод текста в "новая игра"
                LD A, Language.Text.Menu.NewGame
                CALL Functions.TextToBuffer
                LD C, E
                LD DE, #1213
                CALL VFX.Text.Fadein

                ; вывод текста в "продолжить"
                LD A, Language.Text.Menu.Continue
                CALL Functions.TextToBuffer
                LD C, E
                LD DE, #1313
                CALL VFX.Text.Fadein

                ; вывод текста в "настройки"
                LD A, Language.Text.Menu.Options
                CALL Functions.TextToBuffer
                LD C, E
                LD DE, #1413
                CALL VFX.Text.Fadein

                ; подготовка экрана 2
                CALL SetPage7
                CLS_C000
                ATTR_C000_IPB RED, BLACK, 0

                ; отрисовка надпись Loading
                LD HL, Atmosphere7SprAttr
                LD DE, #DB00
                CALL Loader.Decompressor.Forward
                DrawSpriteATTR #DB00, 11, 8, 6, 5

                ; вывод текста в "новая игра"
                LD A, Language.Text.Menu.NewGame
                CALL Functions.TextToBuffer
                LD C, E
                LD DE, #1213
                CALL VFX.Text.Fadein

                ; вывод текста в "продолжить"
                LD A, Language.Text.Menu.Continue
                CALL Functions.TextToBuffer
                LD C, E
                LD DE, #1313
                CALL VFX.Text.Fadein

                ; вывод текста в "настройки"
                LD A, Language.Text.Menu.Options
                CALL Functions.TextToBuffer
                LD C, E
                LD DE, #1413
                CALL VFX.Text.Fadein

                ; вывод курсора
                LD DE, #1212
                CALL PixelAddress
                LD HL, SelectCursor
                CALL DrawCharBoundary

                SetUserHendler INT_Handler
                
.L1             ; подготовка экрана 1
                CALL SetPage5
                ; вывод текста в "продолжить"
                LD A, Language.Text.Menu.NewGame
                CALL Functions.TextToBuffer
                LD C, E
                LD DE, #1213
                CALL VFX.Text.Fadein

                ; подготовка экрана 2
                CALL SetPage7
                ; вывод текста в "продолжить"
                LD A, Language.Text.Menu.NewGame
                CALL Functions.TextToBuffer
                LD C, E
                LD DE, #1213
                CALL VFX.Text.Fadein
                JP .L1
PlanetSprAttr  incbin "../../../../Sprites/Menu/Main/Compressed/Planet.ar.spr"
Atmosphere7SprAttr  incbin "../../../../Sprites/Menu/Main/Compressed/Atmosphere7.ar.spr"

SelectCursor:   DB %00000000
                DB %00000000
                DB %01000000
                DB %00100000
                DB %01010000
                DB %01100000
                DB %01000000
                DB %00000000
                ZX_COLOR_IPB RED, BLACK, 0

                display " - Main : \t\t\t", /A, Main, " = busy [ ", /D, $ - Main, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_MAIN_
