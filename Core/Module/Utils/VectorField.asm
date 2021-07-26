
                    ifndef _CORE_MODULE_UTILS_PATH_FINDING_VECTOR_FIELD_
                    define _CORE_MODULE_UTILS_PATH_FINDING_VECTOR_FIELD_

                    module Pathfinding

;           000 - up
;           001 - up-right
;           010 - right
;           011 - down-right
;           100 - down
;           101 - down-left
;           110 - left
;           111 - up-left
VECTOR_UP           EQU 0x00 << 1
VECTOR_RIGHT_UP     EQU 0x01 << 1
VECTOR_RIGHT        EQU 0x02 << 1
VECTOR_RIGHT_DOWN   EQU 0x03 << 1
VECTOR_DOWN         EQU 0x04 << 1
VECTOR_LEFT_DOWN    EQU 0x05 << 1
VECTOR_LEFT         EQU 0x06 << 1
VECTOR_LEFT_UP      EQU 0x07 << 1

; -----------------------------------------
; получить значение из в векторного поля
; In:
;   DE - позиция тайла (D - y, E - x)
; Out:
;   A  - значение
; Corrupt:
;   HL, AF
; Note:
;   requires included memory page
; -----------------------------------------
GetVectorField_DE:  CALL Utils.Tilemap.GetAddressTilemap                ; получение адреса тайла

                    ; HL >> 1
                    SRL H
                    RR L

                    ; т.к. адрес первого экрана упростим адресацию
                    ; SET 6, H                                            ; LD BC, PathfindingVectorField : ADD HL, BC
                    RES 5, H

                    LD A, (HL)                                          ; получим заначение из адреса (2 значения)

                    JR C, .Less                                         ; если нечётный  сдвигать не нужно
                    
                    ; A >> 4
                    RRA
                    RRA
                    RRA
                    RRA

.Less               AND %00001111                                       ; обрежим

                    RET

; -----------------------------------------
; получить значение из векторного поля
; In:
;   HL - адрес тайла
; Out:
;   A  - значение
; Corrupt:
;   BC, AF
; Note:
;   requires included memory page
; -----------------------------------------
GetVectorField:     ; BC = HL >> 1
                    LD A, H
                    RRA
                    LD B, A
                    LD A, L
                    RRA
                    LD C, A

                    ; т.к. адрес первого экрана упростим адресацию
                    RES 5, B

                    LD A, (BC)                                          ; получим заначение из адреса (2 значения)

                    JR C, .Less                                         ; если нечётный сдвигать не нужно
                    
                    ; A >> 4
                    RRA
                    RRA
                    RRA
                    RRA

.Less               AND %00001111                                       ; обрежим

                    RET
; -----------------------------------------
; запишем значение в векторное поле
; In:
;   A  - значение (младшие 4 бита)
;   DE - позиция тайла (D - y, E - x)
; Out:
; Corrupt:
;   HL, AF, AF'
; Note:
;   requires included memory page
; -----------------------------------------
SetVectorField:     ;EX AF, AF'

                    CALL Utils.Tilemap.GetAddressTilemap                ; получение адреса тайла
 
                    ; JR $
                    EX AF, AF'
                    ADD A, #50
                    LD (HL), A
                    SUB #50
                    EX AF, AF'

                    ; HL >> 1
                    SRL H
                    RR L

                    ; т.к. адрес первого экрана упростим адресацию
                    RES 5, H

                    JR C, .Less                                         ; если нечётный сдвигать не нужно

                    RLD
                    EX AF, AF'
                    RRD
                    
                    RET

.Less               RRD
                    EX AF, AF'
                    RLD

                    RET

; -----------------------------------------
; пометим как занятая ячейка в векторное поле
; In:
;   DE - позиция тайла (D - y, E - x)
; Out:
; Corrupt:
;   HL, AF
; Note:
;   requires included memory page
; -----------------------------------------
MarkVectorField:    CALL Utils.Tilemap.GetAddressTilemap                ; получение адреса тайла
                    
                    PUSH HL

                    ; HL >> 1
                    SRL H
                    RR L

                    ; т.к. адрес первого экрана упростим адресацию
                    RES 5, H

                    JR C, .Less                                         ; если нечётный сдвигать не нужно

                    SET 4, (HL)

                    POP HL
                    SET 0, (HL)

                    RET

.Less               SET 0, (HL)

                    POP HL
                    SET 0, (HL)
                    
                    RET

                    endmodule

                    endif ; ~ _CORE_MODULE_UTILS_PATH_FINDING_VECTOR_FIELD_