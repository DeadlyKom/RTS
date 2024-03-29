
                ifndef _CORE_MODULE_UTILS_CHUNK_ARRAY_REMOVE_
                define _CORE_MODULE_UTILS_CHUNK_ARRAY_REMOVE_
; -----------------------------------------
; удалить значение из массива чанков
; In:
;   A  - порядковый номер чанка [0..127]
;   HL - адрес массива чанков
;   D  - удаляемое значение
;   E  - количество элементов в массиве
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Remove:         ; получение начального адреса чанка
                CALL GetChunkAdr

                ; -----------------------------------------
                ; Out:
                ;   HL - начальный адрес чанка
                ;   B  - обнулён
                ; -----------------------------------------

                ; удаление значение (поиск удаляемого объекта)
                LD C, (HL)

                ifdef DEBUG
                DEC C
                JR Z, $                                                         ; ошибка (неверный чанк)
                INC C
                endif

                DEC (HL)
                INC L
                LD A, D
                CPIR

                ifdef DEBUG
                JP PO, $                                                        ; не найдено искомое значение
                JR NZ, $                                                        ; не найдено искомое значение
                endif

                ; -----------------------------------------
                ; In:
                ;   E  - количество элементов в массиве
                ;   HL - адрес искомого значения
                ;   B  - обнулён
                ; -----------------------------------------
                
                ; перемещение данных (сокращение) shrink
                LD A, E
.MapSizeChunks  EQU $+1
                ADD A, #00
                SUB L
                LD C, A
                LD D, H
                LD E, L
                DEC E
                LDIR

                RET

                endif ; ~ _CORE_MODULE_UTILS_CHUNK_ARRAY_REMOVE_