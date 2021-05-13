
                ifndef _CORE_MEMORY_PAGE_00_
                define _CORE_MEMORY_PAGE_00_

                MMU 3, 0
                ORG Page_0
                
                module MemoryPage_0
Start:
                align 256
TableSprites:   DW Sprite_Sand_1, Sprite_Sand_2, Sprite_Sand_3, Sprite_Sand_4               ; 0  - 3
                DW #0000, #0000, #0000, #0000                                               ; 4  - 7
                DW #0000, #0000, #0000, #0000                                               ; 8  - 11
                DW #0000, #0000, #0000, #0000                                               ; 12 - 15
                DW #0000, #0000, #0000, #0000                                               ; 16 - 19
                DW #0000, #0000, #0000, #0000                                               ; 20 - 23
                DW #0000, Sprite1, Sprite2, #0000                                           ; 24 - 27
                DW #0000, #0000, #0000, #0000                                               ; 28 - 31
                DW Sprite_Canyon_1, Sprite_Canyon_2, Sprite_Canyon_3, Sprite_Canyon_4       ; 32 - 35
                DW Sprite_Canyon_5, Sprite_Canyon_6, Sprite_Canyon_7, Sprite_Canyon_8       ; 36 - 39
                DW Sprite_Canyon_9, Sprite_Canyon_10, Sprite_Canyon_11, Sprite_Canyon_12    ; 40 - 43
                DW Sprite_Canyon_13, Sprite_Canyon_14, Sprite_Canyon_15, Sprite_Canyon_16   ; 44 - 47
                DW #0000, #0000, #0000, #0000                                               ; 48 - 51
                DW #0000, #0000, #0000, #0000                                               ; 52 - 55
                DW #0000, #0000, #0000, #0000                                               ; 56 - 59
                DW #0000, #0000, #0000, #0000                                               ; 60 - 63

                ; спрайты драфтовых значков 1 и 2
Sprite1:        ; 1
                DW #0000, #FE7F, #0240, #0240, #0241, #0243, #0245, #0241
                DW #0000, #FE7F, #0240, #0240, #C247, #0241, #0241, #0241
Sprite2:        ; 2
                DW #0000, #FE7F, #0240, #0240, #8243, #4244, #4240, #8240
                DW #0000, #FE7F, #0240, #0240, #C247, #0244, #0242, #0241

                ; спрайты песка
Sprite_Sand_1:        
                incbin "Sprites/Terrain/Sand_1.spr"
Sprite_Sand_2:        
                incbin "Sprites/Terrain/Sand_2.spr"
Sprite_Sand_3:        
                incbin "Sprites/Terrain/Sand_3.spr"
Sprite_Sand_4:        
                incbin "Sprites/Terrain/Sand_4.spr"

                ; спрайты каньёна
Sprite_Canyon_1:        
                incbin "Sprites/Terrain/Canyon_1.spr"
Sprite_Canyon_2:        
                incbin "Sprites/Terrain/Canyon_2.spr"
Sprite_Canyon_3:        
                incbin "Sprites/Terrain/Canyon_3.spr"
Sprite_Canyon_4:        
                incbin "Sprites/Terrain/Canyon_4.spr"
Sprite_Canyon_5:        
                incbin "Sprites/Terrain/Canyon_5.spr"
Sprite_Canyon_6:        
                incbin "Sprites/Terrain/Canyon_6.spr"
Sprite_Canyon_7:        
                incbin "Sprites/Terrain/Canyon_7.spr"
Sprite_Canyon_8:        
                incbin "Sprites/Terrain/Canyon_8.spr"
Sprite_Canyon_9:        
                incbin "Sprites/Terrain/Canyon_9.spr"
Sprite_Canyon_10:        
                incbin "Sprites/Terrain/Canyon_10.spr"
Sprite_Canyon_11:        
                incbin "Sprites/Terrain/Canyon_11.spr"
Sprite_Canyon_12:        
                incbin "Sprites/Terrain/Canyon_12.spr"
Sprite_Canyon_13:        
                incbin "Sprites/Terrain/Canyon_13.spr"
Sprite_Canyon_14:        
                incbin "Sprites/Terrain/Canyon_14.spr"
Sprite_Canyon_15:        
                incbin "Sprites/Terrain/Canyon_15.spr"
Sprite_Canyon_16:        
                incbin "Sprites/Terrain/Canyon_16.spr"
                ; спрайт солдата A
SolderA_Move_0_0:
                incbin "Sprites/Units/SolderA/Move_0_0.spr"                         ; 8x16
SolderA_Move_0_1:
                incbin "Sprites/Units/SolderA/Move_0_1.spr"                         ; 8x16
SolderA_Move_0_2:
                incbin "Sprites/Units/SolderA/Move_0_2.spr"                         ; 16x16
SolderA_Move_0_3:
                incbin "Sprites/Units/SolderA/Move_0_3.spr"                         ; 8x16

Sprite_Tile_0:        
                incbin "Sprites/Tile/Ground/Tile_0.spr"
Sprite_Tile_1:        
                incbin "Sprites/Tile/Ground/Tile_1.spr"
Sprite_Tile_2:        
                incbin "Sprites/Tile/Road/Tile_2.spr"
Sprite_Tile_3:        
                incbin "Sprites/Tile/Road/Tile_3.spr"
Sprite_Tile_4:        
                incbin "Sprites/Tile/Road/Tile_4.spr"
Sprite_Tile_5:        
                incbin "Sprites/Tile/Road/Tile_5.spr"
Sprite_Tile_6:        
                incbin "Sprites/Tile/Road/Tile_6.spr"
Sprite_Tile_7:        
                incbin "Sprites/Tile/Tree/Tile_7.spr"

Sprite_B1_0:        
                incbin "Sprites/Build/Main/Build_1_0.spr"
Sprite_B1_1:        
                incbin "Sprites/Build/Main/Build_1_1.spr"
Sprite_B1_2:        
                incbin "Sprites/Build/Main/Build_1_2.spr"
Sprite_B1_3:        
                incbin "Sprites/Build/Main/Build_1_3.spr"
Sprite_B1_4:        
                incbin "Sprites/Build/Main/Build_1_4.spr"
Sprite_B1_5:        
                incbin "Sprites/Build/Main/Build_1_5.spr"
Sprite_B1_6:        
                incbin "Sprites/Build/Main/Build_1_6.spr"
Sprite_B1_7:        
                incbin "Sprites/Build/Main/Build_1_7.spr"
Sprite_B1_8:        
                incbin "Sprites/Build/Main/Build_1_8.spr"
Sprite_B2_0:        
                incbin "Sprites/Build/Small/Build_2_0.spr"
Sprite_B2_1:        
                incbin "Sprites/Build/Small/Build_2_1.spr"
Sprite_B2_2:        
                incbin "Sprites/Build/Small/Build_2_2.spr"
Sprite_B2_3:        
                incbin "Sprites/Build/Small/Build_2_3.spr"
End:
                endmodule
SizePage_0:     EQU MemoryPage_0.End - MemoryPage_0.Start

                endif ; ~_CORE_MEMORY_PAGE_00_
