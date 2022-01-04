
                ifndef _GAME_MAP_DEBUG_INCLUDE_
                define _GAME_MAP_DEBUG_INCLUDE_

                include "Info.inc"

                ORG #0000
                
                module LoadMap
START:          ; начало блока

Surface:        ; ********** SURFACE **********
                include "SurfaceProperty.inc"
.End            ; ********* ~SURFACE **********


Behavior:       ; ********* BEHAVIOR **********
                include "../../../Core/Behavior/Include.inc"
Behavior.End:   ; ********* ~BEHAVIOR *********


AnimTUp:        ; ****** ANIMATION TURN UP ******
                include "../../../Core/Animation/AnimationTurnUpTable.inc"
AnimTUp.End:    ; ****** ~ANIMATION TURN UP ******
AnimTDown:      ; ***** ANIMATION TURN DOWN *****
                include "../../../Core/Animation/AnimationTurnDownTable.inc"
AnimTDown.End:  ; ***** !ANIMATION TURN DOWN *****
AnimMove:       ; ******* ANIMATION MOVE ********
                include "../../../Core/Animation/AnimationMoveTable.inc"
AnimMove.End:   ; ******* ~ANIMATION MOVE ********


Map:            ; ********** MAP **********
                include "Map.asm"
.End            ; ********* ~MAP **********


END:            ; конец блока
SIZE:           EQU END - START

SurfaceSize     EQU Surface.End - Surface
BehaviorSize    EQU Behavior.End - Behavior
AnimTUpSize     EQU AnimTUp.End - AnimTUp
AnimTDownSize:  EQU AnimTDown.End - AnimTDown
AnimMoveSize    EQU AnimMove.End - AnimMove

                endmodule
MAP_SIZE:       EQU LoadMap.Map.End - LoadMap.Map

                savetrd  TRD_FILENAME, MAP_FILENAME, #0000, LoadMap.SIZE

                endif ; ~ _GAME_MAP_DEBUG_INCLUDE_