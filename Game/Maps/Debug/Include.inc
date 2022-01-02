
                ifndef _GAME_MAP_DEBUG_INCLUDE_
                define _GAME_MAP_DEBUG_INCLUDE_

                include "Info.inc"

                ORG #4000
                
                module LoadMap
START:          ; начало блока
Map:            ; ********** MAP **********
                include "Map.asm"
.End            ; ********* ~MAP **********
Surface:        ; ********** SURFACE **********
                include "SurfaceProperty.inc"
.End            ; ********* ~SURFACE **********
END:            ; конец блока
SIZE:           EQU END - START

                endmodule
MAP_SIZE:       EQU LoadMap.Map.End - LoadMap.Map

                savetrd  TRD_FILENAME, MAP_FILENAME, #4000, LoadMap.SIZE

                endif ; ~ _GAME_MAP_DEBUG_INCLUDE_