
                    ifndef _STRUCTURE_SPRITE_
                    define _STRUCTURE_SPRITE_

; -------------------- Sprite --------------------

                    struct FSprite
Info                FSpriteInfo
Dummy               DB #00
Page                DB #00
Data                DW #0000

                    ends

                    endif ; ~_STRUCTURE_SPRITE_