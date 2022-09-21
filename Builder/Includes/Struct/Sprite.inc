
				ifndef _STRUCT_SPRITE_
				define _STRUCT_SPRITE_

                struct FSpriteData
Page            DB #00                                                          ; номер страницы
Data            DW #0000                                                        ; адрес спрайта (#C000 - #FFFF)

                ends

                struct FSprite
AABB            FAABB                                                           ; смещение ограничивающей рамки по осям (AABB) относительно центра спрайта (Pivot'а)
                                                                                ; совмещает в себе размер спрайта + смещение
Offset          DB #00                                                          ; адрес маски = адрес спрайта + FSprite.Offset
; -----------------------------------------
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | GM | CS | .. | .. | .. | P2 | P1 | P0 |
;   +----+----+----+----+----+----+----+----+
;
;   GM      [7]     - общая маска для спрайта
;   CS      [6]     - флаг композитный спрайт
;   P2-P0   [2..0]  - страница хранения спрайта
; -----------------------------------------
Page            DB #00
Data            DW #0000                                                        ; адрес спрайта (#C000 - #FFFF)

                ends

; FSprite
FSSF_MASK_BIT   EQU 0x07                                                    	; используется общая маска (берётся из Offset)
FSSF_MASK       EQU 1 << FSSF_MASK_BIT

                struct FAnimation
Possability_A   DB #00                                                          ; проходимость А (100%)
Possability_B   DB #00                                                          ; проходимость Б (75%)
Possability_C   DB #00                                                          ; проходимость В (50%)
Possability_D   DB #00                                                          ; проходимость Г (25%)

                ends

                endif ; ~_STRUCT_SPRITE_
