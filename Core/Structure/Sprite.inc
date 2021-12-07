
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
Dummy               DB #00                                                      ; смещение + Data = адрес маски
Page                DB #00                                                      ; 7 бит, говорит об использовании маски по смещению
Data                DW #0000

                    ends

                    struct FSequencer
Number              DB #00                                                      ; количество анимаций

                    ends


                    struct FAnimation
Possability_A       DB #00                                                      ; проходимость А (100%)
Possability_B       DB #00                                                      ; проходимость Б (75%)
Possability_C       DB #00                                                      ; проходимость В (50%)
Possability_D       DB #00                                                      ; проходимость Г (25%)

                    ends

                    endif ; ~_STRUCTURE_SPRITE_