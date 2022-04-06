
                ifndef _CORE_AI_BEHAVIOR_INCLUDE_
                define _CORE_AI_BEHAVIOR_INCLUDE_

                module AI_Behavior
                
                DISP #0000
                include "TaskIndixes.inc"
                include "BehaviorTable.inc"             ; первая обязательно!
                include "Solder/Solder.inc"
                ENT

                endmodule

                endif ; ~ _CORE_AI_BEHAVIOR_INCLUDE_