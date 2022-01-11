
                    ifndef _CORE_AI_BEHAVIOR_SOLDER_
                    define _CORE_AI_BEHAVIOR_SOLDER_
BEHAVIOR_SOLDER:    ; root
                    BT_Selector .MoveToTarget
                    ; BT_Selector .AttackToTarget
                    ; BT_Selector .A
                    ; BT_Selector .B
                    BT_Task AI.BTT.Idle
                    BT_Break

; .A                  BT_Selector $
;                     BT_Break
; .B                  BT_Selector $
;                     BT_Break

                    
.MoveToTarget       ; перемещение к цели
                    BT_Sequence .SearchWayPoint
                    BT_Task AI.BTT.TurnTo
                    BT_Task AI.BTT.MoveTo
                    BT_Break

.SearchWayPoint     ; поиск цели
                    BT_Selector $
                    BT_Task AI.BTT.WayPoint
                    BT_Break

.AttackToTarget     ; атака цели
                    BT_Sequence .SearchAttack
                    BT_Task AI.BTT.TurnTo
                    BT_Task AI.BTT.AttackTo
                    BT_Break

.SearchAttack       ; поиск цели для атаки
                    BT_Selector $
                    BT_Task AI.BTT.CheckEnemy
                    BT_Break



                    endif ; ~ _CORE_MODULE_AI_BEHAVIOR_SOLDER_