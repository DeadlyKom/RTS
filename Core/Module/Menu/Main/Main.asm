
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
       
.Reset         ; подготовка экрана 1
                SET_SCREEN_BASE
                CLS_C000
                ATTR_C000_IPB RED, BLACK, 1

                ; подготовка экрана 2
                SET_SCREEN_SHADOW
                CLS_C000
                ATTR_C000_IPB RED, BLACK, 0

                ; инициализация VFX
                LD IY, VFX.Text.Variables
                LD HL, UpdateTextVFX
                LD (IY + VFX.Text.FTextVFX.FrameComplited), HL
                LD HL, FadeinNextText
                LD (IY + VFX.Text.FTextVFX.VFX_Complited), HL

                ; отрисовка меню
                LD HL, Menu
                LD A, (HL)
                CALL SetMenuText
                CALL SetFadeinVFX

                SetUserHendler INT_Handler

.Loop           HALT

                LD HL, Menu.Flag
                BIT NEXT_FADEIN_BIT, (HL)
                CALL NZ, PreFadeinText

                LD HL, Menu.Flag
                BIT ALL_FADEIN_BIT, (HL)
                JP NZ, Select

                JR .Loop

UpdateTextVFX:  ;
.Coord          EQU $+1
                LD DE, #0000
                CALL VFX.Text.Render

                LD HL, Menu.Flag
                BIT DRAW_CURSOR_BIT, (HL)
                RET Z

                ; сброс флага перерисовка флага
                RES DRAW_CURSOR_BIT, (HL)

                ; очиста курсора
.OldCoord       EQU $+1
                LD DE, #0000
                DEC E
                CALL PixelAddress
                XOR A
                dup  7
                LD (DE), A
                INC D
                edup
                LD (DE), A

                ; вывод курсора
                LD DE, (.Coord)
                DEC E
                CALL PixelAddress
                LD HL, SelectCursor
                JP DrawCharBoundary

; A - номер меню
SetMenuText:    ; установка выбранного меню
                LD (Menu.Current), A

                ; сохранить позицию курсора
                LD HL, (UpdateTextVFX.Coord)
                LD (UpdateTextVFX.OldCoord), HL

.NotUpdate      ; расчёт информации о меню
                LD HL, Menu.First
                LD D, #00
                LD E, A
                ADD A, A
                ADD A, E
                LD E, A
                ADD HL, DE
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD (UpdateTextVFX.Coord), DE

                ; копирование текста в буфер
                LD A, (HL)
                CALL Functions.TextToBuffer

                ; округление длины текста до знакоместа
                LD A, E
                LD B, #00
                RRA
                ADC A, B
                RRA
                ADC A, B
                RRA
                ADC A, B
                AND %00011111
                LD (IY + VFX.Text.FTextVFX.Length), A

                RET
Menu:           DB .Num-1
.First          ; текст в "настройки"
                DW #1413
                DB Language.Text.Menu.Options
                ; текст в "продолжить"
                DW #1313
                DB Language.Text.Menu.Continue
                ; текст в "новая игра"
                DW #1213
                DB Language.Text.Menu.NewGame
.Num            EQU ($-Menu-1) / 3
.Current        DB .Num-1                                                       ; 1 (порядок)
.Flag           DB #00                                                          ; 2 (порядок)


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

SelectCursor:   DB %00000000
                DB %00000000
                DB %01000000
                DB %00100000
                DB %01010000
                DB %01100000
                DB %01000000
                DB %00000000
                ZX_COLOR_IPB RED, BLACK, 1

                display " - Main : \t\t\t", /A, Main, " = busy [ ", /D, $ - Main, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_MAIN_
