
                ifndef _CORE_AI_BEHAVIOR_INCLUDE_
                define _CORE_AI_BEHAVIOR_INCLUDE_

                module AI_Behavior
                
                DISP #0000
                include "BehaviorTable.inc"             ; первая обязательно!
                include "Soldier/Infantry.inc"
                include "Tank/Tank.inc"
                ENT

                endmodule

                endif ; ~ _CORE_AI_BEHAVIOR_INCLUDE_