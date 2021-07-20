
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
;   the C flag is true
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
Create:             RET

; -----------------------------------------
; add waypoint to sequence
; In:
;   DE - waypoint location (tile center) (D - y, E - x)
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
AddWaypoint:        RET

; -----------------------------------------
; add unit to sequence
; In:
;   A - index unit
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
AddUnit:            RET

; -----------------------------------------
; пометить элемент как занятый
; In:
;   A - index element
; Out:
; Corrupt:
;   HL, AF
; Note:
; -----------------------------------------
MarkBusyElement:    LD H, HIGH WaypointsSequenceBitmapPtr
                    LD L, A
                    SRL L
                    SRL L
                    SRL L

                    ADD A, A
                    ADD A, A
                    ADD A, A
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
;   HL - адрес свободной последовательности
;   если флаг С сброшен, найти свободную не удалось
; Corrupt:
;   HL, BC, AF
; Note:
; -----------------------------------------
FindFreeElement:    LD H, HIGH WaypointsSequencePtr
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
.Bit7               LD A, C                 ; 37
                    ADD A, A
                    ADD A, A
                    ADD A, A
                    ADD A, #07
                    LD L, A
                    RET

.Bit6               LD A, C                 ; 37
                    ADD A, A
                    ADD A, A
                    ADD A, A
                    ADD A, #06
                    LD L, A
                    RET

.Bit5               LD A, C                 ; 37
                    ADD A, A
                    ADD A, A
                    ADD A, A
                    ADD A, #05
                    LD L, A
                    RET

.Bit4               LD A, C                 ; 37
                    ADD A, A
                    ADD A, A
                    ADD A, A
                    ADD A, #04
                    LD L, A
                    RET

.Bit3               LD A, C                 ; 37
                    ADD A, A
                    ADD A, A
                    ADD A, A
                    ADD A, #03
                    LD L, A
                    RET

.Bit2               LD A, C                 ; 37
                    ADD A, A
                    ADD A, A
                    ADD A, A
                    ADD A, #02
                    LD L, A
                    RET

.Bit1               LD A, C                 ; 37
                    ADD A, A
                    ADD A, A
                    ADD A, A
                    ADD A, #01              ; INC A (не влияет на флаг С)
                    LD L, A
                    RET

.Bit0               LD A, C                 ; 34
                    ADD A, A
                    ADD A, A
                    ADD A, A
                    OR A                    ; вместо ADD A, #00 (сбросим флаг)
                    LD L, A
                    RET
                    
                    endmodule

                    endif ; ~ _CORE_MODULE_UTILS_WAYPOINTS_SEQUENCER_
