
                ifndef _CORE_MODULE_UTILS_CHUNK_ARRAY_INITIALIZE_
                define _CORE_MODULE_UTILS_CHUNK_ARRAY_INITIALIZE_
; -----------------------------------------
; первичная инициализация массива чанков
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Initialize:     ; очистка массива чанков для юнита
                LD HL, Adr.Unit.UnitChank + Size.Unit.UnitChank
                LD DE, #0000
                CALL SafeFill.b128
                LD HL, Adr.Unit.UnitChank + (Size.Unit.UnitChank >> 1)
                LD DE, #0101
                CALL SafeFill.b128
                
                ; ToDo сделать инициализацию на основе размера карты

                ; ; расчёт перехода по размеру карты по горизонтали
                ; LD A, #10                                                       ; макс количество чанков по горизонтали
                ; SUB #08                                                         ; размер карты по горизонтали
                ; ADD A, A
                ; LD (FindAddress.Jump), A

                ; расчёт размера пустого буфера по размеру карты (в чанках)
                LD A, 0x08 * 0x08
                LD (Insert.MapSizeChunks), A
                LD (Remove.MapSizeChunks), A

                ; подготовка
                LD C, #00
                
                ; округление
                LD A, 64                                                        ; размер карты по горизонтали
                rept CHUNK_SHIFT
                RRA
                ADC A, C
                endr
                DEC A
                LD (GetChunkIdx.Mask), A
                ; LD (GameVar.TilemapSizeChunk.X), A

                ; округление
                LD A, 64                                                        ; размер карты по вертикали
                rept CHUNK_SHIFT
                RRA
                ADC A, C
                endr
                ; LD (GameVar.TilemapSizeChunk.Y), A

                RRA                                                             ; пропуск 1 бита
                LD HL, #1F1F                                                    ; x2 (RRA : RRA)
                RRA
                JR C, .SetOperation
                LD H, C                                                         ; x4
                RRA
                JR C, .SetOperation
                LD L, C                                                         ; x8
                RRA
                JR C, .SetOperation
                LD L, #87                                                       ; x16 (ADD A, A)
.SetOperation   LD (GetChunkIdx.Operation), HL

                RET

                endif ; ~ _CORE_MODULE_UTILS_CHUNK_ARRAY_INITIALIZE_
