
				ifndef _STRUCT_SPRITE_
				define _STRUCT_SPRITE_

                struct FSpriteData
; -----------------------------------------
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | GM | CS | .. | .. | .. | P2 | P1 | P0 |
;   +----+----+----+----+----+----+----+----+
;
;   GM      [7]     - общая маска для спрайта
;   P2-P0   [2..0]  - страница хранения спрайта
; -----------------------------------------
Page            DB #00                                                          ; номер страницы
Data            DW #0000                                                        ; адрес спрайта (#C000 - #FFFF)

                ends


                struct FSpriteInfo
Height          DB #00                                                          ; высота спрайта
OffsetY         DB #00                                                          ; смещение спрайта по вертикали (в пикселях)
Width           DB #00                                                          ; ширина спрайта
OffsetX         DB #00                                                          ; смещение спрайта по горизонтали (в пикселях)

                ends


                struct FSprite
Info            FSpriteInfo                                                     ; информация о спрайте
Offset          DB #00                                                          ; адрес маски = адрес спрайта + FSprite.Offsetы
Data            FSpriteData                                                     ; данные расположения спрайта

                ends
FSSF_MASK_BIT   EQU 0x07                                                    	; используется общая маска (берётся из Offset)
FSSF_MASK       EQU 1 << FSSF_MASK_BIT

                struct FCompositeSprite
AABB            FAABB                                                           ; смещение ограничивающей рамки по осям (AABB) относительно центра спрайта (Pivot'а)
                                                                                ; совмещает в себе размер спрайта + смещение
Data            FSpriteData                                                     ; данные расположения спрайта
Dummy           DB #00                                                          ; 

                ends

                struct FCompositeSpriteInfo
; -----------------------------------------
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | OX | S2 | S1 | S0 | .. | .. | A1 | A0 |
;   +----+----+----+----+----+----+----+----+
;
;   OX      [7]     - если 0, то OR иначе OR & XOR вывод спрайта
;   S2-S0   [6..4]  - размер спрайта
;                    000 - 0х0
;                    001 - 16x16
;                    010 - 16x32|32x16
;                    100 - 32x32
;   A1,A0   [1,0]   - количество анимаций
;                    00 - 0 анимаций
;                    01 - 1 анимация
;                    10 - 2 анимации
;                    11 - 3 анимации
; -----------------------------------------
Flags           DB #00
Info            FSpriteInfo                                                     ; информация о спрайте

                ends

CSIF_OR_XOR_BIT EQU 0x07   
CSIF_OR_XOR     EQU 1 << CSIF_OR_XOR_BIT
CSIF_OR         EQU 0 << CSIF_OR_XOR_BIT
CSIF_ANIM_NONE  EQU 0x00 << 0
CSIF_ANIM_1     EQU 0x01 << 0
CSIF_ANIM_2     EQU 0x02 << 0
CSIF_ANIM_3     EQU 0x03 << 0
CSIF_SIZE_NONE  EQU 0x00 << 4
CSIF_SIZE_32    EQU 0x01 << 4                                                   ; 16x16
CSIF_SIZE_64    EQU 0x02 << 4                                                   ; 16x32|32x16
CSIF_SIZE_128   EQU 0x04 << 4                                                   ; 32x32
CSIF_ANIM_MASK  EQU %00000011
CSIF_SIZE_MASK  EQU %01110000


                struct FAnimation
Possability_A   DB #00                                                          ; проходимость А (100%)
Possability_B   DB #00                                                          ; проходимость Б (75%)
Possability_C   DB #00                                                          ; проходимость В (50%)
Possability_D   DB #00                                                          ; проходимость Г (25%)

                ends

                endif ; ~_STRUCT_SPRITE_
