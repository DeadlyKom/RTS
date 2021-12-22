
                ifndef _DRAW_SPRITE_INCLUDE_
                define _DRAW_SPRITE_INCLUDE_

                module Sprite

                include "FastClipping.asm"
                include "PixelClipping.asm" ; разбить на 2 и удалить!
                include "Draw.asm"

                include "VerticalClipping.asm"
                include "HorizontalClipping.asm"

                endmodule

                endif ; ~_DRAW_SPRITE_INCLUDE_
