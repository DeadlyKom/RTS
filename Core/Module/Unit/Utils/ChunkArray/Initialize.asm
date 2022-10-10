
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
                CALL SafeFill.b256
                
                ; ToDo сделать инициализацию на основе размера карты

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

                ; округление
                LD A, 64                                                        ; размер карты по вертикали
                rept CHUNK_SHIFT
                RRA
                ADC A, C
                endr

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
