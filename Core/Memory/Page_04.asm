
                ifndef _CORE_MEMORY_PAGE_04_
                define _CORE_MEMORY_PAGE_04_

                MMU 3, 4
                ORG Page_4
                
                module MemoryPage_4
Start:
                include "Sprite/SolderMove.inc"
                include "Sprite/SolderAttack.inc"

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
