
                    ifndef _CORE_AI_BEHAVIOR_SOLDER_
                    define _CORE_AI_BEHAVIOR_SOLDER_
BEHAVIOR_SOLDER:    ; root
                    BT_Selector .MoveToTarget
                    BT_Task AI.BTT.Idle
                    BT_Break
                    
                    ;
.MoveToTarget       BT_Sequence .SearchTarget
                    BT_Task AI.BTT.TurnTo
                    BT_Task AI.BTT.MoveTo
                    BT_Break

                    ;
.SearchTarget       BT_Selector $
                    BT_Task AI.BTT.CheckEnemy
                    BT_Task AI.BTT.WayPoint
                    BT_Break

                    endif ; ~ _CORE_MODULE_AI_BEHAVIOR_SOLDER_