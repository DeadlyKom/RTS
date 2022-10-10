
                ifndef _CORE_MODULE_UTILS_CHUNK_ARRAY_INCLUDE_
                define _CORE_MODULE_UTILS_CHUNK_ARRAY_INCLUDE_

                module ChunkArray
CHUNK_SHIFT     EQU 3
CHUNK_SIZE      EQU 1 << CHUNK_SHIFT
CHUNK_SIZE_MASK EQU (CHUNK_SIZE - 1) & 0xFF

                include "Core.asm"
                include "Initialize.asm"
                include "Insert.asm"
                include "Remove.asm"
                include "Move.asm"
                include "Request.asm"

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_CHUNK_ARRAY_INCLUDE_