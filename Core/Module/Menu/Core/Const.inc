
                ifndef _CORE_MODULE_MENU_CORE_CONST_
                define _CORE_MODULE_MENU_CORE_CONST_
@NEXT_FADE_BIT  EQU 0x07
@LAST_FADE_BIT  EQU 0x06
@ALL_FADE_BIT   EQU 0x05
@DRAW_CURSOR_BIT EQU 0x04
@CHANGE_BIT     EQU 0x03                                                        ; выбор опциий (вверх/вниз)
@SELECT_BIT     EQU 0x02                                                        ; выбрана опция (нажат выбор опции)
@OPTION_BIT     EQU 0x01                                                        ; выбор внутри опции (влево/вправо)
@JUMP_BIT       EQU 0x00                                                        ; переход в опцию (нажат выбор опции)
@NEXT_FADE      EQU 1 << NEXT_FADE_BIT
@LAST_FADE      EQU 1 << LAST_FADE_BIT
@ALL_FADE       EQU 1 << ALL_FADE_BIT
@DRAW_CURSOR    EQU 1 << DRAW_CURSOR_BIT

@SUBOPTION_LEFT_BIT     EQU 0x07
@SUBOPTION_RIGHT_BIT    EQU 0x06
@SUBOPTION_LEFT         EQU 1 << SUBOPTION_LEFT_BIT
@SUBOPTION_RIGHT        EQU 1 << SUBOPTION_RIGHT_BIT
@SUBOPTION_CHANGE_MASK  EQU 0xC0

                endif ; ~ _CORE_MODULE_MENU_CORE_CONST_