
                    ifndef _CORE_AI_BEHAVIOR_SOLDER_
                    define _CORE_AI_BEHAVIOR_SOLDER_
BEHAVIOR_SOLDER:    ; root
                    
                    ;BT_Sequence
                    ;BT_Task
                    ;BT_Selector

                    DB #FF, #00

                    ; BT_Selector Root
                    ; BT_Selector $
                    ; BT_Sequence
                    ; BT_Task
                    ; BT_Selector $

    
                    lua pass3
                    Root  = CreateNode("Root",  _c("BT_ROOT"));

                    -- Root
                    ToTarget = CreateNode("ToTarget", _c("BT_SELECTOR"));
                    AddNode(Root, ToTarget);
                    Idle = CreateNode("Idle", _c("BT_TASK"));
                    AddNode(Root, Idle);

                    -- ToTarget
                    MoveToTarget = CreateNode("MoveToTarget", _c("BT_SEQUENCE"));
                    AddNode(ToTarget, MoveToTarget);
                    AttackToTarget = CreateNode("AttackToTarget", _c("BT_SEQUENCE"));
                    AddNode(ToTarget, AttackToTarget);

                    -- MoveToTarget
                    WayPoint = CreateNode("WayPoint", _c("BT_TASK"));
                    AddNode(MoveToTarget, WayPoint);
                    TurnTo = CreateNode("TurnTo", _c("BT_TASK"));
                    AddNode(MoveToTarget, TurnTo);
                    MoveTo = CreateNode("MoveTo", _c("BT_TASK"));
                    AddNode(MoveToTarget, MoveTo);

                    -- AttackToTarget
                    CheckEnemy = CreateNode("CheckEnemy", _c("BT_TASK"));
                    AddNode(AttackToTarget, CheckEnemy);
                    AddNode(AttackToTarget, TurnTo);
                    AttackTo = CreateNode("AttackTo", _c("BT_TASK"));
                    AddNode(AttackToTarget, AttackTo);

                    -- 
                    PrintTree(Root);
                    endlua
                    

;                     BT_Selector
;                     BT_Nested .ToTarget
;                     BT_Task AI.BTT.Idle
;                     BT_Break

; .ToTarget           ;
;                     BT_Selector
;                     BT_Nested .MoveToTarget
;                     BT_Nested .AttackToTarget
;                     BT_Break

; .MoveToTarget       ; перемещение к цели
;                     BT_Sequence
;                     BT_Task AI.BTT.WayPoint
;                     BT_Task AI.BTT.TurnTo
;                     BT_Task AI.BTT.MoveTo
;                     BT_Break

; .AttackToTarget     ; атака цели
;                     BT_Sequence
;                     BT_Task AI.BTT.CheckEnemy
;                     BT_Task AI.BTT.TurnTo
;                     BT_Task AI.BTT.AttackTo
;                     BT_Break

                    DB #00, #FF

                    savebin "lua_build.bin", BEHAVIOR_SOLDER, $ - BEHAVIOR_SOLDER

                    endif ; ~ _CORE_MODULE_AI_BEHAVIOR_SOLDER_