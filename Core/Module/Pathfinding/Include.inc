
                    ifndef _CORE_MODULE_PATHFINDING_INCLUDE_
                    define _CORE_MODULE_PATHFINDING_INCLUDE_

                    module Pathfinding
VECTOR_FIELD_EMPTY  EQU 0x0F                                                    ; remove ??
VECTOR_FIELD_END    EQU 0x0F                                                    ; remove ??
VECTOR_FIELD_BEGIN  EQU 0x0B >> 1                                               ; remove ??
VECTOR_FIELD_FILL   EQU (VECTOR_FIELD_EMPTY << 12) | (VECTOR_FIELD_EMPTY << 8) | (VECTOR_FIELD_EMPTY << 4) | VECTOR_FIELD_EMPTY ; remove ??

                    include "Base.asm"
                    include "Player/Request.asm"                                ; remove ??

                    endmodule

                    endif ; ~ _CORE_MODULE_PATHFINDING_INCLUDE_