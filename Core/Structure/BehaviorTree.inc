
                    ifndef _STRUCTURE_BEHAVIOR_TREE_
                    define _STRUCTURE_BEHAVIOR_TREE_

                    struct FBehaviorTree
; -----------------------------------------
; 
;   +----+----+----+----+----+----+----+----+
;   |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
;   +----+----+----+----+----+----+----+----+
;   | S1 | S0 | P5 | P4 | P3 | P2 | P1 | P0 |
;   +----+----+----+----+----+----+----+----+
;
;   S0, S1  - state execute node
;   P0 - P5 - index
;
; -----------------------------------------
Info                DB #00
Child               DB #00

                    ends

                    endif ; ~_STRUCTURE_BEHAVIOR_TREE_