
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

                align 256
TableFOW:       DW SpriteFOW_1, SpriteFOW_2, SpriteFOW_3, SpriteFOW_4, SpriteFOW_5, SpriteFOW_6, SpriteFOW_7, SpriteFOW_8
                DW SpriteFOW_9, SpriteFOW_A, SpriteFOW_B, SpriteFOW_C, SpriteFOW_D, SpriteFOW_E, SpriteFOW_F

                align 256
TableMask:      DW FulltMask


FulltMask:      ;
                DW #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF
                DW #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF
Sprite1:        ; 1
                DW #0000, #FE7F, #0240, #0240, #0241, #0243, #0245, #0241
                DW #0000, #FE7F, #0240, #0240, #C247, #0241, #0241, #0241
Sprite2:        ; 2
                DW #0000, #FE7F, #0240, #0240, #8243, #4244, #4240, #8240
                DW #0000, #FE7F, #0240, #0240, #C247, #0244, #0242, #0241

SpriteFOW_1     DW #0000, #0000, #0000, #0000, #0000, #0000, #0000, #0000       ; ! 
                DW #FFFF, #7FFE, #FC3F, #1FF8, #E007, #0000, #0000, #0000
SpriteFOW_2     DW #FFFF, #7FFE, #FC3F, #1FF8, #E007, #0000, #0000, #0000       ; !
                DW #0000, #0000, #0000, #0000, #0000, #0000, #0000, #0000
SpriteFOW_3     DW #FFFF, #3FFC, #F81F, #0FF0, #F00F, #07E0, #E007, #07E0       ; !
                DW #FFFF, #3FFC, #F81F, #0FF0, #F00F, #07E0, #E007, #07E0
SpriteFOW_4     DW #0100, #0003, #0700, #000F, #0F00, #001F, #1F00, #001F       ; !
                DW #0100, #0003, #0700, #000F, #0F00, #001F, #1F00, #001F
SpriteFOW_5     DW #0100, #0001, #0300, #0003, #0700, #0007, #0F00, #001F       ; !
                DW #FFFF, #3FFF, #FF0F, #03FF, #FF01, #00FF, #7F00, #003F
SpriteFOW_6     DW #FFFF, #3FFF, #FF0F, #03FF, #FF01, #00FF, #7F00, #003F       ; !
                DW #0100, #0001, #0300, #0003, #0700, #0007, #0F00, #001F
SpriteFOW_7     DW #FFFF, #3FFF, #FF1F, #0FFF, #FF0F, #07FF, #FF07, #07FF       ; !
                DW #FFFF, #3FFF, #FF1F, #0FFF, #FF0F, #07FF, #FF07, #07FF
SpriteFOW_8     DW #0080, #C000, #00E0, #F000, #00F0, #F800, #00F8, #F800       ; !
                DW #0080, #C000, #00E0, #F000, #00F0, #F800, #00F8, #F800
SpriteFOW_9     DW #0080, #8000, #00C0, #C000, #00E0, #E000, #00F0, #F800       ; !
                DW #FFFF, #FFFC, #F0FF, #FFC0, #80FF, #FF00, #00FE, #FC00
SpriteFOW_A     DW #FFFF, #FFFC, #F0FF, #FFC0, #80FF, #FF00, #00FE, #FC00       ; !
                DW #0080, #8000, #00C0, #C000, #00E0, #E000, #00F0, #F800
SpriteFOW_B     DW #FFFF, #FFFC, #F8FF, #FFF0, #F0FF, #FFE0, #E0FF, #FFE0       ; !
                DW #FFFF, #FFFC, #F8FF, #FFF0, #F0FF, #FFE0, #E0FF, #FFE0
SpriteFOW_C     DW #0180, #8001, #03C0, #E007, #1FF8, #FFFF, #FFFF, #FFFF       ;
                DW #0180, #8001, #03C0, #E007, #1FF8, #FFFF, #FFFF, #FFFF
SpriteFOW_D     DW #0180, #8001, #03C0, #E007, #1FF8, #FFFF, #FFFF, #FFFF       ; !
                DW #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF
SpriteFOW_E     DW #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF       ; !
                DW #0180, #8001, #03C0, #E007, #1FF8, #FFFF, #FFFF, #FFFF
SpriteFOW_F     DW #1FF8, #E007, #03C0, #8001, #0180, #0000, #0000, #0000       ; !
                DW #1FF8, #E007, #03C0, #8001, #0180, #0000, #0000, #0000

MenuSprites:
                incbin "../../Data/MenuSprite.bin"

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
End:
                endmodule
SizePage_0:     EQU MemoryPage_0.End - MemoryPage_0.Start

                endif ; ~_CORE_MEMORY_PAGE_00_
