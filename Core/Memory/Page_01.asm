
                ifndef _CORE_MEMORY_PAGE_01_
                define _CORE_MEMORY_PAGE_01_

                MMU 3, 1
                ORG Page_1
                
                module MemoryPage_1

                ORG MapStructure
Map:
.Begin          FMap .Tilemap, {64, 64}, {0, 0}, UnitArray
.Tilemap        include "Map.asm"
.UnitCounter    DB #00
.End
                ORG SurfaceProperty
Surf:
.Begin
                include "Tables/Gameplay/SurfaceProperty.inc"
.End
MapSize:        EQU MemoryPage_1.Map.UnitCounter - MemoryPage_1.Map.Tilemap

                endmodule
Map_S:          EQU MemoryPage_1.Map.End - MemoryPage_1.Map.Begin 
Surf_S:         EQU MemoryPage_1.Surf.End - MemoryPage_1.Surf.End
SizePage_1_R:   EQU Map_S + Surf_S
SizePage_1:     EQU UnitArray - Page_1


                endif ; ~_CORE_MEMORY_PAGE_01_
