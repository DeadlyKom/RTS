
                ifndef _CORE_MODULE_UTILS_CHUNK_ARRAY_INITIALIZE_
                define _CORE_MODULE_UTILS_CHUNK_ARRAY_INITIALIZE_
; -----------------------------------------
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Init:           ; очистка массива чанков для юнита
                LD HL, UnitsObjectArrayPtr + UnitsObjectArraySize
                LD DE, #0000
                CALL MEMSET.SafeFill_128
                LD HL, UnitsObjectArrayPtr + (UnitsObjectArraySize >> 1)
                LD DE, #0101
                CALL MEMSET.SafeFill_128
                
                ; расчёт размера пустого буфера по размеру карты (в чанках)
                LD A, 0x08 * 0x08
                LD (Insert.MapSizeChunks), A
                LD (Remove.MapSizeChunks), A
                RET




                ; очистка массива чанков для юнита
                ; LD HL, ChunksArrayForUnitsPtr + ChunksArrayForUnitsSize
                ; LD DE, #0000
                ; CALL MEMSET.SafeFill_128
                ; LD HL, ChunksArrayForUnitsPtr + (ChunksArrayForUnitsSize >> 1)
                ; LD DE, #0101
                ; CALL MEMSET.SafeFill_128
                ; ; расчёт перехода по размеру карты по горизонтали
                ; LD C, #10 - #08
                ; LD A, C
                ; ADD A, A
                ; LD (FindAddress.Jump), A
                ; ; расчёт размера смещения по размеру карты (в чанках)
                ; LD A, #08 * #08
                ; LD (MemCopy.MapSizeChunks), A
                ; RET

                endif ; ~ _CORE_MODULE_UTILS_CHUNK_ARRAY_INITIALIZE_