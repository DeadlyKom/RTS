
                ifndef _CORE_MODULE_UNIT_SELECT_ADD_UNITS_TO_QUEUE_
                define _CORE_MODULE_UNIT_SELECT_ADD_UNITS_TO_QUEUE_
; -----------------------------------------
; добавить выбранных юнитов в очередь на обработку
; In:
; Out:
;   если флаг переполнения C установлен, буфер выделеных объектов пуст
; Corrupt:
; Note:
; -----------------------------------------
AddToQueue:     ; выставим необходимую страничку
                ; CALL Memory.SetPage1
                SET_PAGE_UNITS_ARRAY

                ; опредлим выбраны ли юниты
                LD A, (NumberSelectedUnitRef)
                AND MaskSelectedBuffer
                JR Z, .BufferIsEmpty                                            ; в буфере нет выбранных юнитов

                LD B, A
                LD HL, SelectedBufferFirst

.Loop           LD A, (HL)
                INC L
                EXX
                CALL Pathfinding.Queue.PushUnit
                EXX
                DJNZ .Loop

                OR A
                RET

.BufferIsEmpty  SCF
                RET

                endif ; ~ _CORE_MODULE_UNIT_SELECT_ADD_UNITS_TO_QUEUE_