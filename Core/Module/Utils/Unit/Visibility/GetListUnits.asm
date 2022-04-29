
                ifndef _CORE_MODULE_UTILS_GET_LIST_UNITS_
                define _CORE_MODULE_UTILS_GET_LIST_UNITS_

                module Visibility
; -----------------------------------------
; получить список юнитов
; In:
;   IX - указывает на структуру FUnit относительно кого проверяется массив
; Out:
;   если флаг переполнения C установлен, в буфере SharedBuffer хранятся позиции ближайщих юнитов
; Corrupt:
; Note:
; -----------------------------------------
GetListUnits:   ; драфтово формируем список юнитов (всех)

                ; проверка на наличие юнитов в массиве
                LD A, (AI_NumUnitsRef)
                OR A
                JR Z, .Fail
                ; LD (CheckRadius.SizeList), A
                LD B, A
                XOR A                                                           ; обнулим счётчик элементов в массиве
                EX AF, AF'                                                      ; сохраним счётчик элементов
                
                ; включить страницу
                ; SET_PAGE_UNITS_ARRAY

                ; LD DE, (IX + FUnit.Position)                                    ; получение позиции юнита
                LD C, (IX + FUnit.Type)                                         ; получение тип фракции юнита

                LD HL, SharedBuffer                                             ; HL - указывает на временный буфер
                LD DE, UnitArrayPtr                                             ; DE - указывает на FUnit

.Loop           ; проверка типа фракции юнита
                LD A, (DE)                                                      ; LD A, (IX + FUnit.Type)
                XOR C
                ADD A, A                                                        ; проверка флага TYPE_FACTION_BIT
                JR NC, .NextUnit                                                ; если тип фракции одинаковый, переход к следующему юниту

                ; проверка что юнит живой
                INC E
                LD A, (DE)
                DEC E
                AND UNIT_STATE_MASK
                CP UNIT_STATE_DEAD
                JR Z, .NextUnit                                                ; если тип фракции одинаковый, переход к следующему юниту

                ; переход к FUnit.Position
                INC E
                INC E

                ; сохраним позицию юнита
                LD A, (DE)
                LD (HL), A
                INC E
                INC L
                LD A, (DE)
                LD (HL), A
                DEC E
                INC L

                ; переход к FUnit.Type
                DEC E
                DEC E

                ; увеличим счётчик элементов
                EX AF, AF'
                INC A
                EX AF, AF'                                                      ; сохраним счётчик элементов

.NextUnit       ; переход к следующему юниту
                LD A, E
                ADD A, UNIT_SIZE
                LD E, A
                JP NC, $+4
                INC D

                DJNZ .Loop

                ; установим количство элементов в массиве
                EX AF, AF'
                LD (CheckRadius.SizeList), A

                ; проверим, наличие элементов в массиве
                OR A
                JR Z, .Fail                                                           ; список пуст
                
                ; выход в массиве есть элементы
                SCF
                RET

.Fail           OR A
                RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_GET_LIST_UNITS_