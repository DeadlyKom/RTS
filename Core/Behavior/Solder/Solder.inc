
                    ifndef _CORE_AI_BEHAVIOR_SOLDER_
                    define _CORE_AI_BEHAVIOR_SOLDER_

BEHAVIOR_SOLDER:    DB .Child, #AA

                    BT_TASK 0, BTT_IDLE                                         ; B
                    BT_TASK 6, BTT_ATO                                          ; J
                    BT_TASK 6, BTT_TTO                                          ; I
                    BT_TASK 6, BTT_CE                                           ; H
                    BT_SEQUENCE 1, 4                                            ; D
                    BT_TASK 2, BTT_MTO                                          ; G
                    BT_TASK 2, BTT_TTO                                          ; F
                    BT_TASK 2, BTT_WP                                           ; E
                    BT_SEQUENCE 1, 4                                            ; C
                    BT_SELECTOR 0, 2                                            ; A

.Child              EQU $

                    BT_IDX 1
                    BT_IDX_BREAK 10
                    BT_IDX 2
                    BT_IDX_BREAK 6
                    BT_IDX 3
                    BT_IDX 4
                    BT_IDX_BREAK 5
                    BT_IDX 7
                    BT_IDX 8
                    BT_IDX_BREAK 9
                    
                    ; lua allpass
                    ; Root  = CreateNode("Root",  _c("BT_ROOT"));
                    ; -- Root
                    ; ToTarget = CreateNode("ToTarget", _c("BT_SELECTOR"));
                    ; AddNode(Root, ToTarget);
                    ; Idle = CreateNode("Idle", _c("BT_TASK"));
                    ; AddNode(Root, Idle);
                    ; -- ToTarget
                    ; MoveToTarget = CreateNode("MoveToTarget", _c("BT_SEQUENCE"));
                    ; AddNode(ToTarget, MoveToTarget);
                    ; AttackToTarget = CreateNode("AttackToTarget", _c("BT_SEQUENCE"));
                    ; AddNode(ToTarget, AttackToTarget);
                    ; -- MoveToTarget
                    ; WayPoint = CreateNode("WayPoint", _c("BT_TASK"));
                    ; AddNode(MoveToTarget, WayPoint);
                    ; TurnTo = CreateNode("TurnTo", _c("BT_TASK"));
                    ; AddNode(MoveToTarget, TurnTo);
                    ; MoveTo = CreateNode("MoveTo", _c("BT_TASK"));
                    ; AddNode(MoveToTarget, MoveTo);
                    ; -- AttackToTarget
                    ; CheckEnemy = CreateNode("CheckEnemy", _c("BT_TASK"));
                    ; AddNode(AttackToTarget, CheckEnemy);
                    ; AddNode(AttackToTarget, TurnTo);
                    ; AttackTo = CreateNode("AttackTo", _c("BT_TASK"));
                    ; AddNode(AttackToTarget, AttackTo);
                    ; -- 
                    ; -- Print(Root);
                    ; --
                    ; PackTree(Root);
                    ; endlua
                    ; savebin "lua_build.bin", BEHAVIOR_SOLDER, $ - BEHAVIOR_SOLDER

                    endif ; ~ _CORE_MODULE_AI_BEHAVIOR_SOLDER_