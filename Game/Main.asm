    
                ifndef _GAME_MAIN_
                define _GAME_MAIN_

                DEVICE ZXSPECTRUM128

                define _DEBUG_CHECK
                define ENABLE_TOGGLE_SCREENS_DEBUG
                define SHOW_DEBUG
                ; define ENABLE_MUSIC
                define SHOW_FPS

                include "Include.inc"
                include "../Core/Memory/Include.inc"
                include "../Core/Builder.asm"

                endif ; ~_GAME_MAIN_
