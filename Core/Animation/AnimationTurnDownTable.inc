
                DISP #0000
AnimationTurnDownTable:
                DW Soldier.Down - $
                DW Tank.Down - $
                DW #FFFF

                include "Soldier/TurnDown.inc"
                include "Tank/TurnDown.inc"

                ENT
