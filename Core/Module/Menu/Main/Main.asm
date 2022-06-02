
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

                ; сброс выбора
                LD A, Menu.Num-1
                LD (Menu.Current), A
                XOR A
                LD (Menu.Flag), A
                DEC A
                LD (.Flag), A
       
                ; подготовка экрана 1
                SET_SCREEN_BASE
                CLS_C000
                ATTR_C000_IPB RED, BLACK, 1

                ; подготовка экрана 2
                SET_SCREEN_SHADOW
                CLS_C000
                ATTR_C000_IPB RED, BLACK, 0

                ; отрисовка меню
                LD HL, Menu
                LD B, (HL)
                INC HL

.Loop           LD (UpdateVFX.Selected), HL
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD A, (HL)
                INC HL
                PUSH HL
                PUSH BC
                PUSH DE

                CALL Functions.TextToBuffer
                LD A, E
                LD (UpdateVFX.Length), A
                LD C, E
                POP DE
                CALL VFX.Text.Fadein
                
                POP BC
                POP HL
                DJNZ .Loop

                ;
                LD HL, Update
                LD (VFX.Text.NextVFX.Func), HL

                LD HL, UpdateVFX
                LD (VFX.Text.Fadein_Tick.FuncUpdate), HL

                SetUserHendler INT_Handler

.MainLoop       ;
                LD A, (.Flag)
                OR A
                JP Z, Main

                ; обработка ввода
                LD DE, InputDefault
                CALL Input.JumpDefaulKeys

                JR .MainLoop
.Flag           DB #FF

UpdateVFX:      ;
.Length         EQU $+1
                LD C, #00
.Selected       EQU $+1
                LD HL, #0000
                LD E, (HL)
                INC HL
                LD D, (HL)
                PUSH DE
                CALL VFX.Text.Fadein

                ; вывод курсора
                POP DE
                DEC E
                CALL PixelAddress
                LD HL, SelectCursor
                CALL DrawCharBoundary
                RET

Menu:           DB .Num
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
.Current        DB .Num-1
.Flag           DB #00

                ; ***** InputDefault *****
InputDefault:   JR NZ, .Processing                                              ; skip released
                EX AF, AF'
.NotProcessing  SCF
                RET

.Processing     EX AF, AF'
                CP DEFAULT_UP
                JP Z, PressUp
                CP DEFAULT_DOWN
                JP Z, PressDown
                CP DEFAULT_SELECT
                JP Z, PressSelect
                JR .NotProcessing

PressUp:        LD HL, Menu.Current
                LD A, (HL)
                CP Menu.Num-1
                RET Z
                LD C, A

                ; 
                INC HL
                LD A, (HL)
                OR A
                RET NZ
                LD (HL), #FF
                DEC HL

                INC C
                LD (HL), C
                RET
PressDown:      LD HL, Menu.Current
                LD A, (HL)
                OR A
                RET Z
                LD C, A

                ; 
                INC HL
                LD A, (HL)
                OR A
                RET NZ
                LD (HL), #FF
                DEC HL
                
                DEC C
                LD (HL), C
                RET
PressSelect:    LD HL, Menu.Flag
                LD A, (HL)
                OR A
                RET NZ
                LD (HL), #FF

                LD HL, PressSelect.Next
                LD (VFX.Text.NextVFX.Func), HL
                LD A, 4
                JP VFX.Text.SetVFX

.Next           CALL VFX.Text.SetDefault
                SET_PAGE_VISIBLE_SCREEN
                XOR A
                LD (Main.Flag), A
                RET
                ; JP Main

Update:         LD A, (Menu.Flag)
                OR A
                RET Z

                LD HL, (UpdateVFX.Selected)
                PUSH HL

                LD A, (Menu.Current)
                LD HL, Menu.First
                LD E, A
                ADD A, A
                ADD A, E
                LD E, A
                LD D, #00
                ADD HL, DE

                LD (UpdateVFX.Selected), HL
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD A, (HL)
                CALL Functions.TextToBuffer
                LD A, E
                LD (UpdateVFX.Length), A

                POP HL
                LD E, (HL)
                INC HL
                LD D, (HL)
                DEC E

                CALL PixelAddress
                XOR A
                dup  7
                LD (DE), A
                INC D
                edup
                LD (DE), A

                LD (Menu.Flag), A

                RET



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
                ZX_COLOR_IPB RED, BLACK, 0

                display " - Main : \t\t\t", /A, Main, " = busy [ ", /D, $ - Main, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_MAIN_
