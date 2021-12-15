
                    ifndef _CORE_MODULE_UTILS_WAYPOINT_
                    define _CORE_MODULE_UTILS_WAYPOINT_

                    module Waypoint
; -----------------------------------------
; initialize array waypoint
; In:
; Out:
; Corrupt:
;   HL, DE, BC, AF
; Note:
; -----------------------------------------
Init:               CALL Memory.SetPage1
                    XOR A
                    LD (WaypointCounterRef), A
                    LD HL, (WaypointArrayRef)
                    INC H
                    LD D, A
                    LD E, D
                    CALL MEMSET.SafeFill_256
                    RET
; -----------------------------------------
; find free waypoint element 
; In:
; Out:
;   HL - waypoint element address
;   if the Z flag is true, successful
; Corrupt:
;   HL, AF
; Note:
;   requires included memory page
; -----------------------------------------
; FindFreeElement:    ; initialize
;                     XOR A                               ; поиск элемента с счётчиком равный 0
;                     LD HL, (WayPointArrayRef)
;
;                     ; find free waypoint element
; .Loop               CP (HL)
;                     RET Z
;                     INC L
;                     JP NZ, .Loop
;
;                     RET

; -----------------------------------------
; add waypoint element to array
; In:
;   DE - waypoint location (tile center) (D - y, E - x)
; Out:
;   L  - waypoint index of the added element
;   if the C flag is true, successful
; Corrupt:
;   HL, BC, AF
; Note:
;   requires included memory page
; -----------------------------------------
FindAndAdd:         LD HL, (WaypointArrayRef)
                    INC L                                                       ; исключить 0 элемент
                    LD A, (WaypointCounterRef)
                    OR A
                    JR Z, Set.ByHL

                    LD B, A
                    XOR A
                    LD C, A
                    
.Loop               CP (HL)
                    JR Z, .FirstEmpty

.Compare            ; сравнение значения текущего waypoint'а и в массиве
                    INC H
                    LD A, (HL)
                    CP E
                    JR NZ, .PreNext
                    INC H
                    LD A, (HL)
                    CP D
                    JR Z, .Equal                                                ; обнаружено совпадение
                    DEC H
.PreNext            DEC H

                    ; уменьшим счётчик элементов в массиве
                    DEC B
                    JR Z, .End                                                  ; счётчик waypoint обнулён, совпадений не обноружено

.Next               ; переход к следующей ячейке
                    XOR A
                    INC L
                    JP NZ, .Loop
                    JR .ArrayIsFull                                             ; массив переполнен

.End                ; счётчик waypoint обнулён, совпадений не обноружено
                    LD A, C                                                     ; C = первый свободный
                    OR A
                    JR Z, .LastElement
                    LD L, C
                    JP Set.ByHL                                                 ; установим waypoint по адресу в HL

.LastElement        INC L
                    JP NZ, Set.ByHL                                             ; установим waypoint по адресу в HL

.ArrayIsFull        ; массив переполнен
                    OR A                                                        ; unsuccessful execution
                    RET

.FirstEmpty         LD A, C
                    OR A
                    JR NZ, .Next
                    LD C, L
                    JR .Next
                    
.Equal              ; обнаружено совпадение
                    DEC H
                    DEC H
                    INC (HL)                                                    ; нужна проверка если превысило 255
                    JR Z, $                                                     ; ToDo нужно обработать переполнение
                    SCF                                                         ; successful execution
                    RET

; -----------------------------------------
; set waypoint at specified index
; In:
;   A  - insert index
;   DE - waypoint location (tile center) (D - y, E - x)
;   the C flag is true
; Out:
;   L  - waypoint index
; Corrupt:
;   HL, AF
; Note:
;   requires included memory page
; -----------------------------------------
Set:                LD L, A
                    LD A, (HighWaypointArrayRef)
                    LD H, A

.ByHL               LD (HL), #01
                    INC H
                    LD (HL), E
                    INC H
                    LD (HL), D
                    LD A, L

                    ; увеличение счётчика элементов в массиве waypoint
                    LD HL, WaypointCounterRef
                    INC (HL)

                    LD L, A
                    SCF                                                         ; successful execution
                    RET
; -----------------------------------------
; remove waypoint at specified index
; In:
;   A  - index
; Out:
; Corrupt:
;   HL, AF
; Note:
;   requires included memory page
; -----------------------------------------
Remove:             LD L, A
                    LD A, (HighWaypointArrayRef)
                    LD H, A
                    DEC (HL)
                    JR Z, .DecreaseCounter

                    ifdef DEBUG
                    JR $                                                        ; ошибка!
                    else
                    RET
                    endif

.DecreaseCounter    ; увеличение счётчика элементов в массиве waypoint
                    LD HL, WaypointCounterRef
                    DEC (HL)
                    RET

                    endmodule

                    endif ; ~ _CORE_MODULE_UTILS_WAYPOINT_