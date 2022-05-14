
                ifndef _CORE_MODULE_UTILS_CHUNK_ARRAY_MOVE_
                define _CORE_MODULE_UTILS_CHUNK_ARRAY_MOVE_
; -----------------------------------------
; переместить значение в другой чанк
; In:
;   A  - порядковый номер чанка [0..127]
;   HL - адрес массива чанков
;   D  - добавляемое значение
;   E  - количество элементов в массиве
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Move:           ; 

                RET

                endif ; ~ _CORE_MODULE_UTILS_CHUNK_ARRAY_MOVE_