
                ifndef _CORE_MODULE_UTILS_CHUNK_ARRAY_MOVE_
                define _CORE_MODULE_UTILS_CHUNK_ARRAY_MOVE_
; -----------------------------------------
; переместить значение в другой чанк
; In:
; HL - адрес массива чанков
; D  - перемещяемое значение
; B  - номер чанка источника  [0..127]
; A' - номер чанка назначения [0..127]
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Move:           ;
;                 EX AF, AF'
;                 LD C, A
;                 JR NC, .IsPositive

;                 ;
;                 LD A, B
;                 SUB C
;                 LD E, A
;                 LD A, C




; .IsPositive     ;
;                 SUB B
;                 LD E, A
;                 LD A, B

;                 ; A  - номер чанка перемещения
;                 ; D  - перемещяемое значение
;                 ; E  - количество проходимых элементов
;                 ; B  - начальный чанк
;                 ; C  - конечный чанк


;                 ; получение начального адреса чанка
;                 CALL GetChunkAdr







;                 ; получение начального адреса чанка
;                 CALL GetChunkAdr

;                 DEC (HL)                                                        ; уменьшение счётчика элементов в чанке

;                 ; инициализация
;                 LD C, (HL)
;                 INC L
;                 LD A, D

;                 ; поиск перемещяемого значения
;                 CPIR
;                 DEBUG_BREAK_POINT_NZ



                RET

                endif ; ~ _CORE_MODULE_UTILS_CHUNK_ARRAY_MOVE_