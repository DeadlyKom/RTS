
                ifndef _CORE_MODULE_UTILS_CHUNK_ARRAY_INCLUDE_
                define _CORE_MODULE_UTILS_CHUNK_ARRAY_INCLUDE_

                module ChunkArray
CHUNK_SHIFT     EQU 3
CHUNK_SIZE      EQU 1 << CHUNK_SHIFT
CHUNK_SIZE_MASK EQU (CHUNK_SIZE - 1) & 0xFF

                ; структура хранения данных, состоит из 2х половинок
                ; 1ая половина находится в буфере от   0 до 127 соответстует списку объектов
                ; 2ая половина находится в буфере от 128 до 255 соответствент номеру чанка

                include "Core.asm"
                include "Initialize.asm"
                include "Insert.asm"
                include "Remove.asm"
                include "Move.asm"

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_CHUNK_ARRAY_INCLUDE_
