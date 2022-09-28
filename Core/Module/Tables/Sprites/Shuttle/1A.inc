;   000 - 1A (первый тир, нейтрального шаттла)
                ; FCompositeSpriteInfo CSIF_SIZE_32 | CSIF_OR_XOR | CSIF_ANIM_NONE,      16, -16,  16, -16
                ; incbin "Core/Module/Sprites/Tilemap/Pack 1/Foliage/Dracunculus_0.spr"
                ; incbin "Core/Module/Sprites/Tilemap/Pack 1/Foliage/Dracunculus_1.spr"

                ; FCompositeSpriteInfo CSIF_SIZE_32 | CSIF_OR | CSIF_ANIM_NONE,       16,   0,  16, -16
                ; incbin "Core/Module/Sprites/Tilemap/Pack 1/Foliage/Dracunculus_2.spr"

                ; FCompositeSpriteInfo CSIF_SIZE_32 | CSIF_OR_XOR | CSIF_ANIM_2,      16,  16,  16, -16
                ; incbin "Core/Module/Sprites/Tilemap/Pack 1/Foliage/Dracunculus_3.spr"
                ; incbin "Core/Module/Sprites/Tilemap/Pack 1/Foliage/Dracunculus_4.spr"

                ; FCompositeSpriteInfo CSIF_SIZE_64 | CSIF_OR_XOR | CSIF_ANIM_NONE,   32,   0,  16, -16
                ; incbin "Core/Module/Sprites/Tilemap/Pack 1/Foliage/Dracunculus_3.spr"

                ; FCompositeSpriteInfo CSIF_SIZE_64 | CSIF_OR | CSIF_ANIM_NONE,       32,   0,  16,   0
                ; incbin "Core/Module/Sprites/Tilemap/Pack 1/Foliage/Dracunculus_3.spr"

                ; FCompositeSpriteInfo CSIF_SIZE_64 | CSIF_OR | CSIF_ANIM_NONE,       32,   0,  16,  16
                ; incbin "Core/Module/Sprites/Tilemap/Pack 1/Foliage/Dracunculus_4.spr"

                FCompositeSpriteInfo CSIF_SIZE_32 | CSIF_OR_XOR | CSIF_ANIM_NONE,      16, -16,  16, -16
                DB #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55
                DB #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA
                DB #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55
                DB #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA
                FCompositeSpriteInfo CSIF_SIZE_32 | CSIF_OR_XOR | CSIF_ANIM_NONE,      16, 0,  16, 0
                DB #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55
                DB #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA
                DB #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55
                DB #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA, #55, #AA


                DB #00                                                          ; завершение
