
                ifndef _CORE_MODULE_MENU_OPTIONS_CHANGE_GRAPHICS_
                define _CORE_MODULE_MENU_OPTIONS_CHANGE_GRAPHICS_
GraphicsHelp:   LD A, (TextGraphicsHelp.Current)
                LD HL, TextGraphicsHelp
                JP Suboption

ReqChangeGraphics: LD DE, TextGraphicsHelp.Current
                LD B, TextGraphicsHelp.Num
                JP ReqChange

TextGraphicsHelp ; текст в "высокие"
                DB 0x16 * 8
                DB Language.Text.Menu.Graphic_High
                ; текст в "средние"
                DB 0x16 * 8
                DB Language.Text.Menu.Graphic_Medium
                ; текст в "низкие"
                DB 0x16 * 8
                DB Language.Text.Menu.Graphic_Low
.Num            EQU (($-TextGraphicsHelp) / 2)-1
.Current        DB #00

                endif ; ~ _CORE_MODULE_MENU_OPTIONS_CHANGE_GRAPHICS_
