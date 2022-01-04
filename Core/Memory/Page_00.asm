
                    ifndef _CORE_MEMORY_PAGE_00_
                    define _CORE_MEMORY_PAGE_00_

                    include "Page_00_Map.inc"

                    MMU 3, 0
                    ORG Page_0
                    
                    module MemoryPage_0

; ; Behavior:           ; ********* BEHAVIOR **********
; ;                     include "../Behavior/Include.inc"
; ; Behavior.End:       ; ********* ~BEHAVIOR *********

; ; Animation:          ; ********* ANIMATIONS **********
; ; AnimationTurnUp:    ; ****** ANIMATION TURN UP ******
; ;                     include "../Animation/AnimationTurnUpTable.inc"
; ; AnimationTurnDown:  ; ***** ANIMATION TURN DOWN *****
; ;                     include "../Animation/AnimationTurnDownTable.inc"
; ; AnimationMove:      ; ******* ANIMATION MOVE ********
; ;                     include "../Animation/AnimationMoveTable.inc"
; ; Animation.End:      ; ********* ~ANIMATIONS *********

;                     endmodule
; ; Behavior_S          EQU MemoryPage_0.Behavior.End - MemoryPage_0.Behavior
; ; Animation_S         EQU MemoryPage_0.Animation.End - MemoryPage_0.Animation
; SizePage_0:         EQU 0; /*Behavior_S +*/ Animation_S
Start:
                RET
End:
                endmodule
SizePage_0:     EQU MemoryPage_6.End - MemoryPage_6.Start

                    endif ; ~_CORE_MEMORY_PAGE_00_
