
                ifndef _CORE_MODULE_UTILS_CHUNK_ARRAY_CORE_
                define _CORE_MODULE_UTILS_CHUNK_ARRAY_CORE_
; -----------------------------------------
; поиск адреса 
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
FindAddress:    ; конверсия координат в зависимости от размера чанка
                rept CHUNK_SHIFT
                SRL D
                endr

                LD HL, ChunksArrayForUnitsPtr
                JR Z, .ColumnOffset

                XOR A
.NextLine       ;
.Jump           EQU $+1
                JR $
                rept 16
                ADD A, (HL)
                LD L, A
                endr

                DEC D
                JR NZ, .NextLine

.ColumnOffset   ;
                rept CHUNK_SHIFT
                SRL E
                endr
                RET Z
                LD B, E

.Column         ;
                ADD A, (HL)
                LD L, A
                DJNZ .Column

                ADD A, (HL)
                LD L, A

                RET
; -----------------------------------------
; перемещение данных
; In:
;   HL - начальный адрес буфера перемещения
; Out:
;   HL - 
; Corrupt:
; Note:
; -----------------------------------------
MemCopy:        ;
                INC L

                LD A, #80;(AI_NumUnitsRef)
.MapSizeChunks  EQU $+1
                ADD A, #00
                SUB L
                DEC A
                LD C, A
                LD B, #00
                ADD HL, BC
                LD D, H
                LD E, L
                DEC L
                LDDR

                RET

                endif ; ~ _CORE_MODULE_UTILS_CHUNK_ARRAY_CORE_