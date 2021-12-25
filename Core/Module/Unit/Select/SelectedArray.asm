
                ifndef _CORE_MODULE_UNIT_SELECT_ARRAY_
                define _CORE_MODULE_UNIT_SELECT_ARRAY_

; -----------------------------------------
; добавить элемент в буфер выбранных элементов
; In:
;   A - индекс юнита
; Out:
;   если флаг переполнения C установлен, буфер переполнен
; Corrupt:
;   HL, DE, BC, AF, AF'
; Note:
;   циклический буфер, добавляет элемент в конец, если он не переполнен
;   если индекс имеется в буфере, перенесёт его в конец
; -----------------------------------------
PushUnit:       EX AF, AF'                                                      ; сохраним добавляемый индекс
.NextFree       EQU $+1                                                         ; следующий свободный
                LD HL, SelectedBufferFirst

                ; проверка возможности добавить элемент
.CountFree      EQU $+1
                LD A, SizeSelectedBuffer
                CP SizeSelectedBuffer
                JR Z, .Push                                                     ; буфер пуст

                ; сохранить адрес следующего свободного элемента
                LD D, H
                LD E, L

                ; найдём индекс в буфере
                LD C, A                                                         ; сохраним количество свободных элементов
                NEG
                AND SizeSelectedBuffer - 1
                LD B, A                                                         ; количество элементов в буфере
                EX AF, AF'                                                      ; востановим добавляемый индекс

.NextElement    ; перейдём к предыдущему элементу
                INC L
                RES 5, L

                ; сравнение индекса
                CP (HL)
                JR Z, .FindIndex
                DJNZ .NextElement

                ; в буфере нет нужного индекса
                EX AF, AF'                                                      ; сохраним добавляемый индекс
                LD A, C                                                         ; востановим количество свободных элементов
                EX DE, HL                                                       ; востановить адрес следующего свободного элемента

.Push           ; добавление элемента
                DEC A
                JR Z, .BufferIsFull
                LD (CountFreeSelectedRef), A

                ; сохраним индекс
                EX AF, AF'                                                      ; востановим добавляемый индекс
                LD (HL), A

                ; перейдём к следующему свободному элементу
                LD A, L
                DEC A
                AND %00011111
                OR LOW SelectedBufferLast
                LD (.NextFree), A
                RET

.FindIndex      ; найден индекс в массиве
                EX AF, AF'                                                      ; сохраним добавляемый индекс

                ; расчитаем сколько элементов перемещать
                LD A, (CountFreeSelectedRef)
                NEG
                AND %00011111
                SUB B
                JR Z, .EndMemcopy                                               ; перемещать не нужно, т.к. добавляемый индекс последний

                LD B, A                                                         ; количество копируемых элементов
                ; сохраним текущий адрес
                LD D, H
                LD E, L
                
.Memcopy        ; расчитаем адрес следующего элемента (который нужно переместить)
                LD A, L
                DEC A
                AND %00011111
                OR LOW SelectedBufferLast
                LD L, A
                LD A, (HL)
                LD (DE), A
                LD E, L                                                         ; обновим адрес для следующего перемещения
                DJNZ .Memcopy

.EndMemcopy     EX AF, AF'                                                      ; востановим добавляемый индекс
                LD (HL), A
                
                RET
.IsEmpty        ; метка PopUnit
.BufferIsFull   SCF
                RET

; -----------------------------------------
; взять первый элемент в буфере выбранных элементов
; In:
; Out:
;   A - индекс юнита, если буфер не пуст
;   если флаг переполнения C установлен, буфер пуст
; Corrupt:
;   HL, C, AF
; Note:
; -----------------------------------------
PopUnit:        LD A, (PushUnit.CountFree)
                CP SizeSelectedBuffer
                JR Z, PushUnit.IsEmpty                                          ; буфер пуст

                LD C, A

                ; увеличим размер буфера
                INC A
                LD (PushUnit.CountFree), A

                ; рассчитаем адрес 1 элемента в буфере
                LD HL, (PushUnit.NextFree)
                LD A, SizeSelectedBuffer
                SUB C
                ADD A, L
                LD L, A

                LD A, (HL)

                RET

                endif ; ~ _CORE_MODULE_UNIT_SELECT_ARRAY_