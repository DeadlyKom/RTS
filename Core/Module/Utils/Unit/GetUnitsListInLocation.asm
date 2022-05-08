
                ifndef _CORE_MODULE_UTILS_GET_UNITS_LIST_IN_LOCATION_
                define _CORE_MODULE_UTILS_GET_UNITS_LIST_IN_LOCATION_

                module Tile
; -----------------------------------------
; получить список юнитов в указанных позициях
; In:
;   IX - указывает на структуру FUnit
;   BC - координаты тайла (B - y, C - x)
; Out:
; Corrupt:
;   DE, AF, AF'
; Note:
; -----------------------------------------
GetUnitsInLoc:  ; драфтово формируем список юнитов

                PUSH HL

                ;
                XOR A
                LD (.ListSize), A

                ; проверка на наличие юнитов в массиве
                LD A, (AI_NumUnitsRef)
                OR A
                JR Z, .Fail

                LD HL, SharedBuffer                                             ; HL - указывает на временный буфер
                LD DE, UnitArrayPtr + FUnit.Position - UNIT_SIZE                ; DE - указывает на FUnit.Position

.Loop           EX AF, AF'

                LD A, E
                ADD A, UNIT_SIZE
                LD E, A
                JR NC, $+3
                INC D

                ; проверка что юнит жив
                DEC E
                LD A, (DE)
                INC E
                AND UNIT_STATE_MASK
                CP UNIT_STATE_DEAD
                JR Z, .NextUnit

                ; сравнение позиций юнитов
                LD A, (DE)
                CP C
                JR NZ, .NextUnit
                INC E
                LD A, (DE)
                DEC E
                CP B
                JR NZ, .NextUnit

                ; совпадение позиции, сохраним адрес юнита
                LD (HL), E
                INC L
                LD (HL), D
                DEC L

                ; установим количство элементов в массиве
                LD A, (.ListSize)
                INC A
                LD (.ListSize), A

.NextUnit       ; переход к следующему юниту
                EX AF, AF'
                DEC A
                JR NZ, .Loop

.ListSize       EQU $+1
                LD A, #00

                POP HL

                OR A
                JR Z, .Fail

                SCF
                RET

.Fail           XOR A
                RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_GET_UNITS_LIST_IN_LOCATION_