
                ifndef _CORE_MEMORY_PAGE_00_
                define _CORE_MEMORY_PAGE_00_

                MMU 3, 0
                ORG Page_0
                
                module MemoryPage_0
Start:
                align 256
TableSprites:   
                DW Sprite0, Sprite1, Sprite2, Sprite3, Sprite4, Sprite5, Sprite6, Sprite7, Sprite8
                DW Sprite_B1_0, Sprite_B1_1, Sprite_B1_2, Sprite_B1_3, Sprite_B1_4, Sprite_B1_5, Sprite_B1_6, Sprite_B1_7, Sprite_B1_8
                DW Sprite_B2_0, Sprite_B2_1, Sprite_B2_2, Sprite_B2_3

                align 256
TableMask:      DW FulltMask
FulltMask:      ;
                DW #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF
                DW #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF
; Sprite1:        ; 1
;                 DW #0000, #FE7F, #0240, #0240, #0241, #0243, #0245, #0241
;                 DW #0000, #FE7F, #0240, #0240, #C247, #0241, #0241, #0241
; Sprite2:        ; 2
;                 DW #0000, #FE7F, #0240, #0240, #8243, #4244, #4240, #8240
;                 DW #0000, #FE7F, #0240, #0240, #C247, #0244, #0242, #0241
Sprite0:        ;
                DW #0000, #0000, #0000, #0000, #0000, #0000, #0000, #0000
                DW #0000, #0000, #0000, #0000, #0000, #0000, #0000, #0000
Sprite1:        
                incbin "Sprite/Tile_0.spr"
Sprite2:        
                incbin "Sprite/Tile_1.spr"
Sprite3:        
                incbin "Sprite/Tile_2.spr"
Sprite4:        
                incbin "Sprite/Tile_3.spr"
Sprite5:        
                incbin "Sprite/Tile_4.spr"
Sprite6:        
                incbin "Sprite/Tile_5.spr"
Sprite7:        
                incbin "Sprite/Tile_6.spr"
Sprite8:        
                incbin "Sprite/Tile_7.spr"

Sprite_B1_0:        
                incbin "Sprite/Build_1_0.spr"
Sprite_B1_1:        
                incbin "Sprite/Build_1_1.spr"
Sprite_B1_2:        
                incbin "Sprite/Build_1_2.spr"
Sprite_B1_3:        
                incbin "Sprite/Build_1_3.spr"
Sprite_B1_4:        
                incbin "Sprite/Build_1_4.spr"
Sprite_B1_5:        
                incbin "Sprite/Build_1_5.spr"
Sprite_B1_6:        
                incbin "Sprite/Build_1_6.spr"
Sprite_B1_7:        
                incbin "Sprite/Build_1_7.spr"
Sprite_B1_8:        
                incbin "Sprite/Build_1_8.spr"
Sprite_B2_0:        
                incbin "Sprite/Build_2_0.spr"
Sprite_B2_1:        
                incbin "Sprite/Build_2_1.spr"
Sprite_B2_2:        
                incbin "Sprite/Build_2_2.spr"
Sprite_B2_3:        
                incbin "Sprite/Build_2_3.spr"
End:
                endmodule
SizePage_0:     EQU MemoryPage_0.End - MemoryPage_0.Start

                endif ; ~_CORE_MEMORY_PAGE_00_
