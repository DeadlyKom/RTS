
                ifndef _CORE_MODULE_AI_TASK_INCLUDE_
                define _CORE_MODULE_AI_TASK_INCLUDE_

                module BTT

                include "AttackTo.asm"
                include "CheckEnemy.asm"
                include "Idle.asm"
                include "LookAround.asm"
                include "MoveTo.asm"
                include "TurnTo.asm"
                include "Wait.asm"
                include "WayPoint.asm"

                endmodule

                include "TaskTable.inc"

                endif ; ~ _CORE_MODULE_AI_TASKS_INCLUDE_