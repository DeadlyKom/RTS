
                ifndef _CORE_MODULE_MENU_MAIN_
                define _CORE_MODULE_MENU_MAIN_

                include "Sprites/Menu/Main/Compress.inc"
Main:           

                LD A, LANGUAGE_EN
                CALL Functions.ChangeLanguage

                LD A, LANGUAGE_EN
                CALL MainLoadText

                LD HL, Adr.MainMenuText
                LD (LocalizationRef), HL

                LD A, Language.Text.Menu.Options
                CALL Functions.TextToBuffer

                LD HL, SharedBuffer
                LD DE, #4000
                LD BC, 32
                LDIR
                LD HL, SharedBuffer + 0x20
                LD DE, #4100
                LD BC, 32
                LDIR
                LD HL, SharedBuffer + 0x40
                LD DE, #4200
                LD BC, 32
                LDIR
                LD HL, SharedBuffer + 0x60
                LD DE, #4300
                LD BC, 32
                LDIR
                LD HL, SharedBuffer + 0x80
                LD DE, #4400
                LD BC, 32
                LDIR
                LD HL, SharedBuffer + 0xA0
                LD DE, #4500
                LD BC, 32
                LDIR
                LD HL, SharedBuffer + 0xC0
                LD DE, #4600
                LD BC, 32
                LDIR
                LD HL, SharedBuffer + 0xE0
                LD DE, #4700
                LD BC, 32
                LDIR
                JR$



                ; подготовка экрана 1
                CALL SetPage5
                CLS_C000
                ATTR_C000_IP WHITE, BLACK

                ; отрисовка надпись Loading
                LD HL, PlanetSprAttr
                LD DE, #DB00
                CALL Loader.Decompressor.Forward
                DrawSpriteATTR #DB00, 11, 6, 11, 11

                ; подготовка экрана 2
                CALL SetPage7
                CLS_C000
                ATTR_C000_IP WHITE, BLACK

                ; отрисовка надпись Loading
                LD HL, Atmosphere7SprAttr
                LD DE, #DB00
                CALL Loader.Decompressor.Forward
                DrawSpriteATTR #DB00, 11, 8, 6, 5
                
                JR$
.Text           
                ; En
                ; DB #01, #02, #03, #04, #05, #06, #07, #08, #09, #0A, #0B, #0C, #0D, #0E, #0F, #10, #00
                ; DB #11, #12, #13, #14, #15, #16, #17, #18, #19, #1A, #00
                ; DB #1B, #1C, #1D, #1E, #1F, #20, #21, #22, #23, #24, #25, #26, #27, #28, #29, #2A, #00
                ; DB #2B, #2C, #2D, #2E, #2F, #30, #31, #32, #33, #34, #00
                ; DB #35, #36, #37, #38, #39, #3A, #3B, #3C, #3D, #3E, #3F, #40, #41, #42, #43, #44, #00
                ; DB #45, #46, #47, #48, #49, #4A, #4B, #4C, #4D, #4E, #00
PlanetSprAttr  incbin "../../../Sprites/Menu/Main/Compressed/Planet.ar.spr"
Atmosphere7SprAttr  incbin "../../../Sprites/Menu/Main/Compressed/Atmosphere7.ar.spr"

                display " - Main : \t\t\t", /A, Main, " = busy [ ", /D, $ - Main, " bytes  ]"

                endif ; ~ _CORE_MODULE_MENU_MAIN_
