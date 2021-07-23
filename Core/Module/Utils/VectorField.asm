
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

VECTOR_UP       EQU 0x00
VECTOR_RIGHT    EQU 0x02
VECTOR_DOWN     EQU 0x04
VECTOR_LEFT     EQU 0x06

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
GetVectorField: CALL Utils.Tilemap.GetAddressTilemap                ; получение адреса тайла

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

.Less           AND %00001111                                       ; обрежим 

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
SetVectorField: EX AF, AF'

                CALL Utils.Tilemap.GetAddressTilemap                ; получение адреса тайла
                
                ; HL >> 1
                SRL H
                RR L

                ; т.к. адрес первого экрана упростим адресацию
                ; SET 6, H                                            ; LD BC, PathfindingVectorField : ADD HL, BC
                RES 5, H

                JR C, .Less                                         ; если нечётный  сдвигать не нужно

                RLD
                EX AF, AF'
                RRD
                
                RET

.Less           RRD
                EX AF, AF'
                RLD

                RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_PATH_FINDING_VECTOR_FIELD_