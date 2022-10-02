;   тень от шаттла
                FCompositeSpriteInfo CSIF_SIZE_32 | CSIF_OR_XOR | CSIF_ANIM_4,  ANIM_INDEX_2,    16, 14,  16, -16
                incbin "Core/Module/Sprites/Shuttle/Shadow/ShuttleShadow_3_0.spr"
                incbin "Core/Module/Sprites/Shuttle/Shadow/ShuttleShadow_2_0.spr"
                incbin "Core/Module/Sprites/Shuttle/Shadow/ShuttleShadow_1_0.spr"
                incbin "Core/Module/Sprites/Shuttle/Shadow/ShuttleShadow_0_0.spr"

                FCompositeSpriteInfo CSIF_SIZE_64 | CSIF_OR_XOR | CSIF_ANIM_4,  ANIM_INDEX_2,    16, 14,  32,   0
                incbin "Core/Module/Sprites/Shuttle/Shadow/ShuttleShadow_3_1.spr"
                incbin "Core/Module/Sprites/Shuttle/Shadow/ShuttleShadow_2_1.spr"
                incbin "Core/Module/Sprites/Shuttle/Shadow/ShuttleShadow_1_1.spr"
                incbin "Core/Module/Sprites/Shuttle/Shadow/ShuttleShadow_0_1.spr"

                DB #00                                                          ; завершение
