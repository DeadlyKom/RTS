
                    ifndef _CORE_AI_BEHAVIOR_SOLDER_
                    define _CORE_AI_BEHAVIOR_SOLDER_
BEHAVIOR_SOLDER:    ; root
                    BT_Selector
                    BT_Nested .ToTarget
                    BT_Task AI.BTT.Idle
                    BT_Break

.ToTarget           ;
                    BT_Selector
                    BT_Nested .MoveToTarget
                    BT_Nested .AttackToTarget
                    BT_Break

.MoveToTarget       ; перемещение к цели
                    BT_Sequence
                    BT_Task AI.BTT.WayPoint
                    BT_Task AI.BTT.TurnTo
                    BT_Task AI.BTT.MoveTo
                    BT_Break

.AttackToTarget     ; атака цели
                    BT_Sequence
                    BT_Task AI.BTT.CheckEnemy
                    BT_Task AI.BTT.TurnTo
                    BT_Task AI.BTT.AttackTo
                    BT_Break

                    endif ; ~ _CORE_MODULE_AI_BEHAVIOR_SOLDER_