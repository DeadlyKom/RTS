
                ifndef _UTILS_PROJECTILE_INCLUDE_
                define _UTILS_PROJECTILE_INCLUDE_

                module Projectile
SCREEN_RECT_X   EQU 256
SCREEN_RECT_Y   EQU 192
PROJECTILES     EQU #C000
MAX_PROJECTILES EQU 255

                include "Handler.asm"
                include "Spawn.asm"
                include "Move.asm"
                include "Draw.asm"
                include "Collision.asm"
                include "Destroy.asm"
Number:         DB #00

                endmodule

                endif ; ~_UTILS_PROJECTILE_INCLUDE_