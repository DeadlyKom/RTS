
                ifndef _CORE_MODULE_UTILS_CHUNK_ARRAY_INSERT_
                define _CORE_MODULE_UTILS_CHUNK_ARRAY_INSERT_
; -----------------------------------------
; добавить индекс в массив чанков
; In:
;   A  - индекс
;   DE - координаты расположения индекса (D - y, E - x)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Insert:         EX AF, AF'
                
                ; поиск места вставки
                CALL FindAddress

                ; перемещение
                CALL MemCopy

                ; вставка индекса
                INC (HL)
                EX AF, AF'
                LD (DE), A

                RET

                endif ; ~ _CORE_MODULE_UTILS_CHUNK_ARRAY_INSERT_