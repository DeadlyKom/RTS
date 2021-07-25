
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
Init:               ; WaypointsSequenceBitmapPtr + 0xE0
                    LD HL, RenderBuffer
                    INC H
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
Create:             CALL FindFreeElement                            ; Out:
                                                                    ;   HL   - адрес свободной последовательности
                                                                    ;   L, A - индекс последовательности
                                                                    ;   если флаг С сброшен, найти свободную не удалось

                    RET C                                           ; unsuccessful execution
                    LD (AddUnit.IndexSequence), A                   ; сохраним индекс последовательности
                    LD (AddWaypoint.Sequencer), HL                  ; инициализация для Waypoints
                    LD A, #08
                    LD (AddWaypoint.Counter), A
                    CALL MarkBusyElement                            ; пометить как занятый
                    RET

; -----------------------------------------
; add waypoint to sequence
; In:
;   DE - waypoint location (tile center) (D - y, E - x)
; Out:
; Corrupt:
;   HL, BC, AF
; Note:
;   requires included memory page
; -----------------------------------------
AddWaypoint:        ; ---------------------------------------------
                    ; добавить Waypoint в масив
                    ; ---------------------------------------------
                    CALL Utils.Waypoint.FindAndAdd                  ; Out:
                                                                    ;   L  - waypoint index of the added element
                                                                    ;   if the C flag is true, successful

                    RET NC                                          ; unsuccessful execution

                    ; ---------------------------------------------
                    ; добавить индекс Waypoint в масиве последовательности
                    ; ---------------------------------------------
                    LD A, L
.Sequencer          EQU $+1
                    LD HL, #0000
                    LD (HL), A

                    ; переход к следующему элементы в последовательности
                    DEC H
                    LD (.Sequencer), HL
                    LD HL, .Counter
                    DEC (HL)
                    JR Z, .More_8
                    SCF                                             ; successful execution
                    RET
.Counter            DB #08
                    ; ---------------------------------------------
                    ; последовательность Waypoints более 8
                    ; ---------------------------------------------
.More_8             OR A                                            ; unsuccessful execution
                    RET

; -----------------------------------------
; add unit to sequence
; In:
;   A - index unit * 4
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
AddUnit:            LD HL, (UnitArrayRef)
                    ; ADD A, A
                    ; ADD A, A
                    ADD A, L
                    LD L, A

                    ; HL - FUnitState (1)
                    INC H                                           ; FUnitLocation     (2)
                    INC H                                           ; FUnitTargets      (3)

                    INC L                                           ; FUnitTargets.WayPoint.Y
                    INC L                                           ; FUnitTargets.Data
                    LD (HL), C

                    INC L                                           ; FUnitTargets.Idx
.IndexSequence      EQU $+1
                    LD (HL), #00
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

.SET                EQU $+1                 ; SET n, (HL)
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
