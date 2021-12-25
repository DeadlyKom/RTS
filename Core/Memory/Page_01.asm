
                ifndef _CORE_MEMORY_PAGE_01_
                define _CORE_MEMORY_PAGE_01_

                MMU 3, 1
                ORG Page_1
                
                module MemoryPage_1

                ORG TilemapPtr
Map:
                include "Map.asm"
.End
                FMap #CCCC, TilemapTableAddress, {64, 64}, {0, 0}, WaypointArrayPtr, Behavior.Begin, Animation.Begin, UnitArrayPtr, #0000, SurfacePropertyPtr
Behavior.Begin:
                include "../Behavior/Include.inc"
Behavior.End:

Animation.Begin:
                include "../Animation/Include.inc"
Animation.End:

                ORG SurfacePropertyPtr
Surf:
.Begin
                include "Tables/Gameplay/SurfaceProperty.inc"
.End
MapSize:        EQU MemoryPage_1.Map.End - TilemapPtr

                endmodule
; Map_S:          EQU MemoryPage_1.Map.End - MemoryPage_1.Map.Begin
Behavior_S      EQU MemoryPage_1.Behavior.End - MemoryPage_1.Behavior.Begin
Animation_S     EQU MemoryPage_1.Animation.End - MemoryPage_1.Animation.Begin
Surf_S:         EQU MemoryPage_1.Surf.End - MemoryPage_1.Surf.Begin
Others_S        EQU Behavior_S + Animation_S + Surf_S
SizePage_1:     EQU UnitArrayPtr - Page_1

                endif ; ~_CORE_MEMORY_PAGE_01_
