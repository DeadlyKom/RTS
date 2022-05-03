                        
                DISP #0000
AnimationTurnUpTable:
                DW #0000 - $
                DW Tank.Up - $
                DW #FFFF

                include "Infantry/TurnUp.inc"
                include "Tank/TurnUp.inc"

                ENT
