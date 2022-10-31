
                DISP #0000
AnimationMoveTable:
                DW Infantry.Move - $
                DW Tank.Move - $
                DW #FFFF

                include "Infantry/Move.inc"
                include "Tank/Move.inc"

                ENT
