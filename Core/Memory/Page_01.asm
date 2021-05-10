
                ifndef _CORE_MEMORY_PAGE_01_
                define _CORE_MEMORY_PAGE_01_

                MMU 3, 1
                ORG Page_1
                
                module MemoryPage_1
Start:
                align 256
TableFOW:       DW SpriteFOW_1, SpriteFOW_2, SpriteFOW_3, SpriteFOW_4, SpriteFOW_5, SpriteFOW_6, SpriteFOW_7, SpriteFOW_8
                DW SpriteFOW_9, SpriteFOW_A, SpriteFOW_B, SpriteFOW_C, SpriteFOW_D, SpriteFOW_E, SpriteFOW_F
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
FulltMask:      DW #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF
                DW #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF, #FFFF
End:
                endmodule
SizePage_1:     EQU MemoryPage_1.End - MemoryPage_1.Start

                endif ; ~_CORE_MEMORY_PAGE_01_
