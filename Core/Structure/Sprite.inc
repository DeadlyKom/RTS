
                    ifndef _STRUCTURE_SPRITE_
                    define _STRUCTURE_SPRITE_

; -------------------- sprite info --------------------

                    struct FSpriteInfo
Height              DB #00
Offset_Y            DB #00
Width               DB #00
Offset_X            DB #00

                    ends
                    
; -------------------- Sprite --------------------

                    struct FSprite
Info                FSpriteInfo
Dummy               DB #00                  ; смещение + Data = адрес маски
Page                DB #00                  ; 7 бит, говорит об использовании маски по смещению
Data                DW #0000

                    ends


                    struct FAnimation
Timeline            DB #00                          ; таймлайн
Flags               DB #00

                    ends

                    endif ; ~_STRUCTURE_SPRITE_