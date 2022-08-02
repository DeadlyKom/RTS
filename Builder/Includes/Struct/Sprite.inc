
				ifndef _STRUCT_SPRITE_
				define _STRUCT_SPRITE_

; FSprite state flags
FSSF_MASK_BIT   EQU 0x07                                                    	; используется общая маска (берётся из Dummy)
FSSF_MASK       EQU 1 << FSSF_MASK_BIT

; -------------------- sprite data --------------------

				struct FSpriteData
Page            DB #00                                                      	; номер страницы
Data            DW #0000                                                    	; адрес спрайта (#C000 - #FFFF)

				ends

; -------------------- sprite info --------------------

                struct FSpriteInfo
Height          DB #00                                                          ; высота спрайта (в пикселях)
OffsetY         DB #00                                                          ; смещение спрайта по вертикали (в пикселях)
Width           DB #00                                                          ; ширина спрайта (в знакоместах)
OffsetX         DB #00                                                          ; смещение спрайта по горизонтали (в пикселях)

                ends
  
; -------------------- sprite --------------------

                struct FSprite
Info            FSpriteInfo
Dummy           DB #00                                                          ; смещение + Data = адрес маски
Page            DB #00                                                          ; 7 бит, говорит об использовании маски по смещению
Data            DW #0000                                                        ; адрес спрайта (#C000 - #FFFF)

                ends

                struct FSequencer
Number          DB #00                                                          ; количество анимаций

                ends


                struct FAnimation
Possability_A   DB #00                                                          ; проходимость А (100%)
Possability_B   DB #00                                                          ; проходимость Б (75%)
Possability_C   DB #00                                                          ; проходимость В (50%)
Possability_D   DB #00                                                          ; проходимость Г (25%)

                ends

                endif ; ~_STRUCT_SPRITE_
