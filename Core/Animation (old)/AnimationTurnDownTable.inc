
                DISP #0000
AnimationTurnDownTable:
                DW Infantry.Down - $
                DW Tank.Down - $
                DW #FFFF

                include "Infantry/TurnDown.inc"
                include "Tank/TurnDown.inc"

                ENT
