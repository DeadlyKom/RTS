
                ifndef _CONST_GAME_SCREEN_
                define _CONST_GAME_SCREEN_
SCREEN_TILE_X   EQU 16                                                          ; количество тайлов на экране по горизонтали
SCREEN_TILE_Y   EQU 12                                                          ; количество тайлов на экране по вертикали
SCREEN_CHAR_X   EQU SCREEN_TILE_X * 2                                           ; количество знакомест на экране по горизонтали
SCREEN_CHAR_Y   EQU SCREEN_TILE_Y * 2                                           ; количество знакомест на экране по вертикали
SCREEN_PIXEL_X  EQU SCREEN_TILE_X * 16                                          ; количество пикселей на экране по горизонтали
SCREEN_PIXEL_Y  EQU SCREEN_TILE_Y * 16                                          ; количество пикселей на экране по вертикали

                endif ; ~_CONST_GAME_SCREEN_
