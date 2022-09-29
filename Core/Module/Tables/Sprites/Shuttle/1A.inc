;   000 - 1A (первый тир, нейтрального шаттла)
                FCompositeSpriteInfo CSIF_SIZE_32 | CSIF_OR_XOR | CSIF_ANIM_2,      16, -16,  16, -16
                incbin "Core/Module/Tables/Sprites/Shuttle/1A/Shuttle_1A_0_0.spr"
                incbin "Core/Module/Tables/Sprites/Shuttle/1A/Shuttle_1A_0_1.spr"

                FCompositeSpriteInfo CSIF_SIZE_32 | CSIF_OR_XOR | CSIF_ANIM_NONE,   16, -16,  16,   0
                incbin "Core/Module/Tables/Sprites/Shuttle/1A/Shuttle_1A_1.spr"

                FCompositeSpriteInfo CSIF_SIZE_32 | CSIF_OR_XOR | CSIF_ANIM_2,      16, -16,  16,  16
                incbin "Core/Module/Tables/Sprites/Shuttle/1A/Shuttle_1A_2_0.spr"
                incbin "Core/Module/Tables/Sprites/Shuttle/1A/Shuttle_1A_2_1.spr"

                FCompositeSpriteInfo CSIF_SIZE_64 | CSIF_OR_XOR | CSIF_ANIM_NONE,   16,   0,  32, -16
                incbin "Core/Module/Tables/Sprites/Shuttle/1A/Shuttle_1A_3.spr"

                FCompositeSpriteInfo CSIF_SIZE_64 | CSIF_OR | CSIF_ANIM_NONE,       16,   0,  32,   0
                incbin "Core/Module/Tables/Sprites/Shuttle/1A/Shuttle_1A_4.spr"

                FCompositeSpriteInfo CSIF_SIZE_64 | CSIF_OR_XOR | CSIF_ANIM_NONE,   16,   0,  32,  16
                incbin "Core/Module/Tables/Sprites/Shuttle/1A/Shuttle_1A_5.spr"

                DB #00                                                          ; завершение
