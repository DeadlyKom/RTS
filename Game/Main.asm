    
                ifndef _GAME_MAIN_
                define _GAME_MAIN_

                DEVICE ZXSPECTRUM128

                define ENABLE_TOGGLE_SCREENS_DEBUG
                define SHOW_DEBUG
                define SHOW_DEBUG_BORDER
                define SHOW_DEBUG_BORDER_TILEMAP
                define SHOW_DEBUG_BORDER_FOW
                define SHOW_DEBUG_MOUSE_POSITION
                define SHOW_DEBUG_BORDER_CURSOR

                ; define ENABLE_MUSIC
                define ENABLE_MOUSE
                define SHOW_FPS

                include "Include.inc"
                include "../Core/Memory/Include.inc"
                include "../Core/Builder.asm"

                endif ; ~_GAME_MAIN_
