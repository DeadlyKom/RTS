
                    ifndef _CORE_MENU_INCLUDE_
                    define _CORE_MENU_INCLUDE_

                    module Menu

                    include "EntryPoint.asm"
                    include "Initialize.asm"
                    include "Loop.asm"
                    ; include "Music.asm"

; default keyboard
VK_Keys             EQU $
VK_KeyUp:           DB VK_W
VK_KeyDown:         DB VK_S
VK_KeyLeft:         DB VK_A
VK_KeyRight:        DB VK_D
VK_KeySelect:       DB VK_SPACE

                    endmodule

                    endif ; ~_CORE_MENU_INCLUDE_
