
                    ifndef _CORE_MEMORY_PAGE_07_
                    define _CORE_MEMORY_PAGE_07_

                    MMU 3, 7
                    ORG Page_7
                    
                    module MemoryPage_7
Start:              

Sprite_Cursor_0:
                    incbin "Sprites/Cursor/Cursor_0.spr"        ; 16x16
Sprite_Cursor_1:
                    incbin "Sprites/Cursor/Cursor_1.spr"        ; 16x16
Sprite_Cursor_2:
                    incbin "Sprites/Cursor/Cursor_2.spr"        ; 16x16
Sprite_Cursor_3:
                    incbin "Sprites/Cursor/Cursor_3.spr"        ; 16x16
; Sprite_Cursor_1:
;                     incbin "Sprites/Units/SolderA/Move_0_1.spr"                         ; 16x16
                    
                    ORG Page_7_TileTable
TableSprites:       DW Sprite_Sand_1,       Sprite_Sand_2,      Sprite_Sand_3,      Sprite_Sand_4       ; 0   - 3
                    DW #0000,               #0000,              #0000,              #0000               ; 4   - 7
                    DW #0000,               #0000,              #0000,              #0000               ; 8   - 11
                    DW #0000,               #0000,              #0000,              #0000               ; 12  - 15
                    DW #0000,               #0000,              #0000,              #0000               ; 16  - 19
                    DW #0000,               #0000,              #0000,              #0000               ; 20  - 23
                    DW #0000,               Sprite1,            Sprite2,            #0000               ; 24  - 27
                    DW #0000,               #0000,              #0000,              #0000               ; 28  - 31
                    DW Sprite_Canyon_1,     Sprite_Canyon_2,    Sprite_Canyon_3,    Sprite_Canyon_4     ; 32  - 35
                    DW Sprite_Canyon_5,     Sprite_Canyon_6,    Sprite_Canyon_7,    Sprite_Canyon_8     ; 36  - 39
                    DW Sprite_Canyon_9,     Sprite_Canyon_10,   Sprite_Canyon_11,   Sprite_Canyon_12    ; 40  - 43
                    DW Sprite_Canyon_13,    Sprite_Canyon_14,   Sprite_Canyon_15,   Sprite_Canyon_16    ; 44  - 47
                    DW #0000,               #0000,              #0000,              #0000               ; 48  - 51
                    DW #0000,               #0000,              #0000,              #0000               ; 52  - 55
                    DW #0000,               #0000,              #0000,              #0000               ; 56  - 59
                    DW #0000,               #0000,              #0000,              #0000               ; 60  - 63
                    DW #0000,               #0000,              #0000,              #0000               ; 64  - 67
                    DW #0000,               #0000,              #0000,              #0000               ; 68  - 71
                    DW #0000,               #0000,              #0000,              #0000               ; 72  - 75
                    DW #0000,               #0000,              #0000,              #0000               ; 76  - 79
                    DW #0000,               #0000,              #0000,              #0000               ; 80  - 83
                    DW #0000,               #0000,              #0000,              #0000               ; 84  - 87
                    DW #0000,               #0000,              #0000,              #0000               ; 88  - 91
                    DW #0000,               #0000,              #0000,              #0000               ; 92  - 95
                    DW #0000,               #0000,              #0000,              #0000               ; 96  - 99
                    DW #0000,               #0000,              #0000,              #0000               ; 100 - 103
                    DW #0000,               #0000,              #0000,              #0000               ; 104 - 107
                    DW #0000,               #0000,              #0000,              #0000               ; 108 - 111
                    DW #0000,               #0000,              #0000,              #0000               ; 112 - 115
                    DW #0000,               #0000,              #0000,              #0000               ; 116 - 119
                    DW #0000,               #0000,              #0000,              #0000               ; 120 - 123
                    DW #0000,               #0000,              #0000,              #0000               ; 124 - 127
.End                EQU $
TableSprites_S:     EQU TableSprites.End - TableSprites

                    ORG Page_7_TileSprites

                    ; спрайты драфтовых значков 1 и 2
Sprite1:            ; 1
                    DW #0000, #FE7F, #0240, #0240, #0241, #0243, #0245, #0241
                    DW #0000, #FE7F, #0240, #0240, #C247, #0241, #0241, #0241
Sprite2:            ; 2
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
End:
Sprites_S:          EQU End - Page_7_TileSprites
SizePage_7_S:       EQU #1B00 + TableSprites_S + Sprites_S

                    endmodule
SizePage_7_Real:    EQU MemoryPage_7.SizePage_7_S
SizePage_7:         EQU MemoryPage_7.End - MemoryPage_7.Start

                    endif ; ~_CORE_MEMORY_PAGE_07_
