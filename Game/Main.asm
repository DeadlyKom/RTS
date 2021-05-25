    
                ifndef _GAME_MAIN_
                define _GAME_MAIN_

                DEVICE ZXSPECTRUM128

                define ENABLE_MUSIC
                define ENABLE_MOUSE           

                define SHOW_DEBUG_BORDER
                define SHOW_DEBUG_BORDER_TILEMAP
                define SHOW_DEBUG_BORDER_DRAW_UNITS
                define SHOW_DEBUG_BORDER_FOW
                define SHOW_DEBUG_BORDER_CURSOR
                define SHOW_DEBUG_BORDER_CURSOR_RESTORE
                define SHOW_DEBUG_BORDER_PLAY_MUSIC

                define SHOW_DEBUG
                ifdef SHOW_DEBUG
                define SHOW_FPS
                define SHOW_MOUSE_POSITION
                define ENABLE_TOGGLE_SCREENS_DEBUG
                endif

                include "Include.inc"
                include "../Core/Memory/Include.inc"
                include "../Core/Builder.asm"

                endif ; ~_GAME_MAIN_
