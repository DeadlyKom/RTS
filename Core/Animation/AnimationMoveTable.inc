
                DISP #0000
AnimationMoveTable:
                DW Soldier.Move - $
                DW Tank.Move - $
                DW #FFFF

                include "Soldier/Move.inc"
                include "Tank/Move.inc"

                ENT
