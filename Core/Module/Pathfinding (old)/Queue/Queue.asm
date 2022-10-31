
                ifndef _CORE_MODULE_PATHFINDING_QUEUE_
                define _CORE_MODULE_PATHFINDING_QUEUE_

                module Queue
; -----------------------------------------
; добавить элемент в очередь запросов поиска пути
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
                LD HL, PathfindingQueryQueueLast

                ; проверка возможности добавить элемент
.CountFree      EQU $+1
                LD A, SizePathfindingQueryQueue
                CP SizePathfindingQueryQueue
                JR Z, .Push                                                     ; буфер пуст

                ; сохранить адрес следующего свободного элемента
                LD D, H
                LD E, L

                ; найдём индекс в буфере
                LD C, A                                                         ; сохраним количество свободных элементов
                NEG
                AND SizePathfindingQueryQueue - 1
                LD B, A                                                         ; количество элементов в буфере
                EX AF, AF'                                                      ; востановим добавляемый индекс

.NextElement    ; перейдём к предыдущему элементу
                INC L
                SET 7, L                                                        ; используем старшие 128 байт

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
                LD (CountFreeQueryQueueRef), A

                ; сохраним индекс
                EX AF, AF'                                                      ; востановим добавляемый индекс
                LD (HL), A

                ; перейдём к следующему свободному элементу
                LD A, L
                DEC A
                OR LOW PathfindingQueryQueueFirst
                LD (.NextFree), A
                RET

.FindIndex      ; найден индекс в массиве
                EX AF, AF'                                                      ; сохраним добавляемый индекс

                ; расчитаем сколько элементов перемещать
                LD A, (CountFreeQueryQueueRef)
                NEG
                AND MaskPathfindingQueryQueue
                SUB B
                JR Z, .EndMemcopy                                               ; перемещать не нужно, т.к. добавляемый индекс последний

                LD B, A                                                         ; количество копируемых элементов
                ; сохраним текущий адрес
                LD D, H
                LD E, L
                
.Memcopy        ; расчитаем адрес следующего элемента (который нужно переместить)
                LD A, L
                DEC A
                OR LOW PathfindingQueryQueueFirst
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
; взять первый элемент из очереди запросов поиска пути
; In:
; Out:
;   A - индекс юнита, если буфер не пуст
;   если флаг переполнения C установлен, буфер пуст
; Corrupt:
;   HL, C, AF
; Note:
; -----------------------------------------
PopUnit:        LD A, (PushUnit.CountFree)
                CP SizePathfindingQueryQueue
                JR Z, PushUnit.IsEmpty                                          ; буфер пуст

                LD C, A

                ; увеличим размер буфера
                INC A
                LD (PushUnit.CountFree), A

                ; рассчитаем адрес 1 элемента в буфере
                LD HL, (PushUnit.NextFree)
                LD A, SizePathfindingQueryQueue
                SUB C
                ADD A, L
                LD L, A

                ; включим страницу с данными о очереди
                SET_PAGE_TILEMAP
                LD A, (HL)

                RET
; -----------------------------------------
; проверить пуст ли очередь запросов поиска пути
; In:
; Out:
;   если флаг переполнения C установлен, буфер пуст
; Corrupt:
; Note:
; -----------------------------------------
IsEmpty:        LD A, (PushUnit.CountFree)
                CP SizePathfindingQueryQueue
                JR Z, PushUnit.IsEmpty
                OR A
                RET

                endmodule

                endif ; ~ _CORE_MODULE_PATHFINDING_QUEUE_