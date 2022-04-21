
                    ifndef _CORE_MODULE_UTILS_WAYPOINTS_SEQUENCER_
                    define _CORE_MODULE_UTILS_WAYPOINTS_SEQUENCER_

                    module WaypointsSequencer
; -----------------------------------------
; initialize waypoints sequencer
; In:
; Out:
; Corrupt:
;   HL, DE, AF
; Note:
; -----------------------------------------
Init:               LD HL, WaypointsSequenceBitmapPtr + SizeWaypointsSequenceBitmap
                    LD DE, #0000
                    CALL MEMSET.SafeFill_32
                    RET

; -----------------------------------------
; create weypoints sequencer
; In:
; Out:
;   L, A - индекс последовательности
;   если флаг С установлен, найти свободную последовательность не удалось
; Corrupt:
;   HL, BC, AF
; Note:
;   requires included memory page
; -----------------------------------------
Create:             CALL FindFreeElement                                        ; Out:
                                                                                ;   HL   - адрес свободной последовательности
                                                                                ;   L, A - индекс последовательности
                                                                                ;   если флаг С сброшен, найти свободную не удалось

                    RET C                                                       ; unsuccessful execution
                    LD (AddUnit.IndexSequence), A                               ; сохраним индекс последовательности
                    LD (AddWaypoint.Sequencer), HL                              ; инициализация для Waypoints
                    
                    CALL MarkBusyElement                                        ; пометить как занятый
                    
                    LD A, #08
                    LD (AddWaypoint.Counter), A
                    RET

; -----------------------------------------
; add waypoint to sequence
; In:
;   DE - waypoint location (tile center) (D - y, E - x)
; Out:
;   если флаг С сброшен, буфер последовательности переполнен
; Corrupt:
;   HL, BC, AF
; Note:
;   requires included memory page
; -----------------------------------------
AddWaypoint:        ; ---------------------------------------------
                    ; добавить Waypoint в масив
                    ; ---------------------------------------------
                    CALL Utils.Waypoint.FindAndAdd                              ; Out:
                                                                                ;   L  - waypoint index of the added element
                                                                                ;   if the C flag is true, successful

                    RET NC                                                      ; unsuccessful execution

                    ; ---------------------------------------------
                    ; добавить индекс Waypoint в масиве последовательности
                    ; ---------------------------------------------
                    LD A, L
.Sequencer          EQU $+1
                    LD BC, #0000
                    LD (BC), A

                    ; переход к следующему элементы в последовательности
                    DEC B
                    LD (.Sequencer), BC
                    LD HL, .Counter
                    DEC (HL)
                    JR Z, .More_8
                    DEC (HL)
                    JR Z, $+4
                    XOR A
                    LD (BC), A
                    INC (HL)
                    SCF                                                         ; successful execution
                    RET
.Counter            DB #08
                    ; ---------------------------------------------
                    ; последовательность Waypoints более 8
                    ; ---------------------------------------------
.More_8             OR A                                                        ; unsuccessful execution
                    RET
; -----------------------------------------
; In:
;   IX - указывает на структуру FUnit
; Out:
;   DE - waypoint location (tile center) (D - y, E - x)
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
GetCurrentWaypoint: LD A, (IX + FUnit.Data)
                    AND FUTF_MASK_OFFSET
                    ADD A, HIGH WaypointsSequencePtr
                    LD H, A
                    LD L, (IX + FUnit.Idx)
                    LD L, (HL)

                    LD H, HIGH WaypointArrayPtr + 1                             ; первое значение, счётчик
                    ; LD E, (HL)
                    ; INC H
                    ; LD D, (HL)

                    RET

; -----------------------------------------
; get the last waypoint into an array
; In:
;   IX - указывает на структуру FUnit
; Out:
;   HL - pointer to waypoint location (tile center)
; Corrupt:
;   HL, BC, AF
; Note:
;   requires included memory page
; -----------------------------------------
GetLastWaypoint:    LD A, (IX + FUnit.Data)
                    AND FUTF_MASK_OFFSET
                    LD B, A
                    INC B
                    ADD A, HIGH WaypointsSequencePtr
                    LD H, A
                    LD L, (IX + FUnit.Idx)

.NextIndex          LD A, (HL)
                    OR A
                    JR Z, .IsEmpty
                    DEC H
                    DJNZ .NextIndex

.IsEmpty            INC H
                    LD L, (HL)
                    LD H, HIGH WaypointArrayPtr
                    RET

; -----------------------------------------
; add unit to sequence
; In:
;   A - индекс юнита
;   C  - флаги
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | WP | IX | IN | LP | NX | O2 | O1 | O0 |
;   +----+----+----+----+----+----+----+----+
;
;   WP - [7]     валиден ли указанный Way Point
;   IX - [6]     бит валидности данных об индексе
;   IN - [5]     бит вставки (если 1 WP хранит временный путь, увеличивать смещение не нужно)
;   LP - [4]     бит зациклиности
;   NX - [3]     бит длины последовательности более 8, последний индекс (отсчёт от 7 до 0) в цепочке указывает индекс следующей цепочки
;   O  - [2..0]  смещение (обратное от 7 до 0)
;
; Out:
; Corrupt:
;   HL, AF
; Note:
;   requires included memory page
; -----------------------------------------
AddUnit:            ; расчёт смещения по индексу юнита
                    CALL Utils.Unit.GetAddress

.UnitAddressToIX    ; IX - указывает на структуру FUnit
                    LD (IX + FUnit.Data), C

.IndexSequence      EQU $+3
                    LD (IX + FUnit.Idx), #00

                    RET

; -----------------------------------------
; пометить элемент как занятый
; In:
;   L, A - индекс последовательности
; Out:
; Corrupt:
;   HL, AF
; Note:
; -----------------------------------------
MarkBusyElement:    LD H, HIGH WaypointsSequenceBitmapPtr

                    SCF
                    RR L
                    SRA L
                    SRA L

                    ADD A, A
                    ADD A, A
                    ADD A, A
                    CPL
                    AND %00111000
                    OR %11000110
                    LD (.SET), A

.SET                EQU $+1                                                     ; SET n, (HL)
                    DB #CB, #00
                    RET

; -----------------------------------------
; поиск свободной последовательности
; In:
; Out:
;   HL   - адрес свободной последовательности
;   L, A - индекс последовательности
;   если флаг С установлен, найти свободную не удалось
; Corrupt:
;   HL, BC, AF
; Note:
; -----------------------------------------
FindFreeElement:    LD H, HIGH WaypointsSequencePtr + 0x07                      ; обратный отсчёт от 7 до 0
                    LD BC, WaypointsSequenceBitmapPtr

.Loop               LD A, (BC)

                    ADD A, A
                    JR NC, .Bit7            ; 23
                    ADD A, A
                    JR NC, .Bit6            ; 34
                    ADD A, A
                    JR NC, .Bit5            ; 45
                    ADD A, A
                    JR NC, .Bit4            ; 56
                    ADD A, A
                    JR NC, .Bit3            ; 67
                    ADD A, A
                    JR NC, .Bit2            ; 78
                    ADD A, A
                    JR NC, .Bit1            ; 89
                    ADD A, A
                    JR NC, .Bit0            ; 100

                    INC C
                    JP NZ, .Loop            ; 14 (переход)

                    SCF                     ; unsuccessful execution
                    RET

                    ; ---------------------------------------------
                    ; во всех операций флаг С, должен быть сброшен
                    ; ---------------------------------------------
.Bit7               LD A, C                 ; 34
                    ADD A, A
                    ADD A, A
                    ADD A, A
                    OR A                    ; вместо ADD A, #00 (сбросим флаг)
                    LD L, A
                    RET

.Bit6               LD A, C                 ; 37
                    ADD A, A
                    ADD A, A
                    ADD A, A
                    ADD A, #01              ; INC A (не влияет на флаг С)
                    LD L, A
                    RET

.Bit5               LD A, C                 ; 37
                    ADD A, A
                    ADD A, A
                    ADD A, A
                    ADD A, #02
                    LD L, A
                    RET

.Bit4               LD A, C                 ; 37
                    ADD A, A
                    ADD A, A
                    ADD A, A
                    ADD A, #03
                    LD L, A
                    RET

.Bit3               LD A, C                 ; 37
                    ADD A, A
                    ADD A, A
                    ADD A, A
                    ADD A, #04
                    LD L, A
                    RET

.Bit2               LD A, C                 ; 37
                    ADD A, A
                    ADD A, A
                    ADD A, A
                    ADD A, #05
                    LD L, A
                    RET

.Bit1               LD A, C                 ; 37
                    ADD A, A
                    ADD A, A
                    ADD A, A
                    ADD A, #06
                    LD L, A
                    RET

.Bit0               LD A, C                 ; 37
                    ADD A, A
                    ADD A, A
                    ADD A, A
                    ADD A, #07
                    LD L, A
                    RET
                    
                    endmodule

                    endif ; ~ _CORE_MODULE_UTILS_WAYPOINTS_SEQUENCER_
