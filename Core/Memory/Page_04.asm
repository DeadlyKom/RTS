
                ifndef _CORE_MEMORY_PAGE_04_
                define _CORE_MEMORY_PAGE_04_

                MMU 3, 4
                ORG Page_4
                
                module MemoryPage_4
Start:
                ; спрайт юнита А (вверх)
SolderA_Move_0_0:
                incbin "Sprites/Units/SolderA/Move_0_0.spr"                         ; 8x16
SolderA_Move_0_1:
                incbin "Sprites/Units/SolderA/Move_0_1.spr"                         ; 16x16
SolderA_Move_0_2:
                incbin "Sprites/Units/SolderA/Move_0_2.spr"                         ; 8x16
SolderA_Move_0_3:
                incbin "Sprites/Units/SolderA/Move_0_3.spr"                         ; 8x16

                ; спрайт юнита А (вверх-вправо)
SolderA_Move_1_0:
                incbin "Sprites/Units/SolderA/Move_1_0.spr"                         ; 16x16
SolderA_Move_1_1:
                incbin "Sprites/Units/SolderA/Move_1_1.spr"                         ; 16x16
SolderA_Move_1_2:
                incbin "Sprites/Units/SolderA/Move_1_2.spr"                         ; 16x16
SolderA_Move_1_3:
                incbin "Sprites/Units/SolderA/Move_1_3.spr"                         ; 16x16

                ; спрайт юнита А (вправо)
SolderA_Move_2_0:
                incbin "Sprites/Units/SolderA/Move_2_0.spr"                         ; 16x16
SolderA_Move_2_1:
                incbin "Sprites/Units/SolderA/Move_2_1.spr"                         ; 16x16
SolderA_Move_2_2:
                incbin "Sprites/Units/SolderA/Move_2_2.spr"                         ; 16x16
SolderA_Move_2_3:
                incbin "Sprites/Units/SolderA/Move_2_3.spr"                         ; 16x16

                ; спрайт юнита А (вправо-вниз)
SolderA_Move_3_0:
                incbin "Sprites/Units/SolderA/Move_3_0.spr"                         ; 8x16
SolderA_Move_3_1:
                incbin "Sprites/Units/SolderA/Move_3_1.spr"                         ; 8x16
SolderA_Move_3_2:
                incbin "Sprites/Units/SolderA/Move_3_2.spr"                         ; 8x16
SolderA_Move_3_3:
                incbin "Sprites/Units/SolderA/Move_3_3.spr"                         ; 8x16

                ; спрайт юнита А (вниз)
SolderA_Move_4_0:
                incbin "Sprites/Units/SolderA/Move_4_0.spr"                         ; 8x16
SolderA_Move_4_1:
                incbin "Sprites/Units/SolderA/Move_4_1.spr"                         ; 8x16
SolderA_Move_4_2:
                incbin "Sprites/Units/SolderA/Move_4_2.spr"                         ; 8x16
SolderA_Move_4_3:
                incbin "Sprites/Units/SolderA/Move_4_3.spr"                         ; 8x16

                ; спрайт юнита А (влево-вниз)
SolderA_Move_5_0:
                incbin "Sprites/Units/SolderA/Move_5_0.spr"                         ; 16x16
SolderA_Move_5_1:
                incbin "Sprites/Units/SolderA/Move_5_1.spr"                         ; 16x16
SolderA_Move_5_2:
                incbin "Sprites/Units/SolderA/Move_5_2.spr"                         ; 16x16
SolderA_Move_5_3:
                incbin "Sprites/Units/SolderA/Move_5_3.spr"                         ; 16x16

                ; спрайт юнита А (влево)
SolderA_Move_6_0:
                incbin "Sprites/Units/SolderA/Move_6_0.spr"                         ; 16x16
SolderA_Move_6_1:
                incbin "Sprites/Units/SolderA/Move_6_1.spr"                         ; 16x16
SolderA_Move_6_2:
                incbin "Sprites/Units/SolderA/Move_6_2.spr"                         ; 16x16
SolderA_Move_6_3:
                incbin "Sprites/Units/SolderA/Move_6_3.spr"                         ; 16x16

                ; спрайт юнита А (влево-вверх)
SolderA_Move_7_0:
                incbin "Sprites/Units/SolderA/Move_7_0.spr"                         ; 8x16
SolderA_Move_7_1:
                incbin "Sprites/Units/SolderA/Move_7_1.spr"                         ; 8x16
SolderA_Move_7_2:
                incbin "Sprites/Units/SolderA/Move_7_2.spr"                         ; 8x16
SolderA_Move_7_3:
                incbin "Sprites/Units/SolderA/Move_7_3.spr"                         ; 8x16

                ;
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

                ; ************ Health Bar ************
Sprite_SmallHP:
                incbin "Sprites/HealthBar/HealthBarSmall_B.spr"
End:
                endmodule
SizePage_4:     EQU MemoryPage_4.End - MemoryPage_4.Start

                endif ; ~_CORE_MEMORY_PAGE_04_
