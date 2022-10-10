
                ifndef _CORE_MODULE_UTILS_CHUNK_ARRAY_CORE_
                define _CORE_MODULE_UTILS_CHUNK_ARRAY_CORE_
; -----------------------------------------
; получение адреса юнитов в указанном чанке
; In:
;   A  - порядковый номер чанка [0..127]
;   HL - адрес массива чанков (выровненый 256 байт) + 0x80
; Out:
;   HL - начальный адрес счётчиков юнитов в указанном чанке
;   A  - количествой пройденых элементов/начальный адрес расположения элементов
;   B  - обнулён
; Corrupt:
;   L, BC, IY, AF
; Note:
; -----------------------------------------
GetAdrUnits:    ; A = (127 - A) << 1 (обратный)
                CPL
                ADD A, A
                LD C, A

                ; прирощение адреса перехода
                XOR A
                LD B, A
                LD IY, .Rows
                ADD IY, BC
                JP (IY)

.Rows           rept 127
                ADD A, (HL)
                INC L
                endr

                RET
; -----------------------------------------
; получение номера чанка 
; In:
;   DE - координаты в тайлах (D - y, E - x)
; Out:
;   A  - порядковый номер чанка [0..127]
; Corrupt:
;   D, AF
; Note:
; -----------------------------------------
GetChunkIdx:    LD A, D
.Operation      EQU $
                NOP
                NOP
                LD D, A
                LD A, E
                RRA
                RRA
                RRA
                XOR D
.Mask           EQU $+1
                AND 0
                XOR D
                AND UNIT_CHUNK_INDEX_MASK

                RET
; -----------------------------------------
; поиск адреса 
; In:
;   DE - координаты в тайлах (D - y, E - x)
; Out:
;   HL - начальный адрес чанка 
; Corrupt:
; Note:
; -----------------------------------------
; FindAddress:    ; инициализация
;                 LD HL, Adr.Unit.UnitChank
;                 XOR A
;                 ; конверсия Y в зависимости от размера чанка
;                 rept CHUNK_SHIFT
;                 SRL D
;                 endr
;                 JR Z, .Column                                                   ; переход, если певоя строка
; .Row            ; проход строки
; .Jump           EQU $+1
;                 JR $
;                 rept 16
;                 ADD A, (HL)
;                 LD L, A
;                 endr
;                 DEC D
;                 JR NZ, .Row
; .Column         ; конверсия X в зависимости от размера чанка
;                 rept CHUNK_SHIFT
;                 SRL E
;                 endr
;                 RET Z                                                           ; выход, если первоя колонка
;                 LD B, E
; .ColumnLoop     ; цикл прохода по строке
;                 ADD A, (HL)
;                 LD L, A
;                 DJNZ .ColumnLoop
;                 ADD A, (HL)
;                 LD L, A
;                 RET
; -----------------------------------------
; перемещение данных
; In:
;   HL - начальный адрес буфера перемещения
; Out:
;   HL - 
; Corrupt:
; Note:
; -----------------------------------------
; MemCopy:        ;
;                 INC L
;                 LD A, #80;(AI_NumUnitsRef)
; .MapSizeChunks  EQU $+1
;                 ADD A, #00
;                 SUB L
;                 DEC A
;                 LD C, A
;                 LD B, #00
;                 ADD HL, BC
;                 LD D, H
;                 LD E, L
;                 DEC L
;                 LDDR
;                 RET
; -----------------------------------------
; перемещение данных (расширение)
; In:
;   A  - количество элементов в массиве
;   HL - начальный адрес буфера перемещения
;   B  - обнулён
; Out:
;   HL - адрес счётчика элементов
;   DE - адрес пустого элемента 
; Corrupt:
;   
; Note:
; -----------------------------------------
; MemCopyExpend:  ;
;                 INC L
; .MapSizeChunks  EQU $+1
;                 ADD A, #00
;                 SUB L
;                 LD C, A
;                 ; LD B, #00
;                 ADD HL, BC
;                 LD D, H
;                 LD E, L
;                 DEC L
;                 LDDR
;                 RET

                endif ; ~ _CORE_MODULE_UTILS_CHUNK_ARRAY_CORE_