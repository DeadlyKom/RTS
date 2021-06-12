
                    ifndef _CORE_MODULE_AI_DEFINITION_
                    define _CORE_MODULE_AI_DEFINITION_

; behavior tree branch type
BT_SELECTOR_TYPE    EQU 0x00
BT_SEQUENCE_TYPE    EQU 0x01
BT_TASK_TYPE        EQU 0x02
BT_BREAK_TYPE       EQU 0x03

; behavior tree macros

BT_TYPE             macro Type?
                    DB (Type? << 6) & 0xFF
                    endm

; Selector
; выполняет последовательность задачь, пока какая-то из них не вернёт успешное выполнение
BT_Selector         macro Offset?
                    BT_TYPE BT_SELECTOR_TYPE
                    DB (Offset? - $) & 0xFF
                    endm

; Sequence
; выполняет последовательность задачь, до тех пор, пока какая-то из них вернёт неудачу
BT_Sequence         macro Offset?
                    BT_TYPE BT_SEQUENCE_TYPE
                    DB (Offset? - $) & 0xFF
                    endm

BT_Task             macro AddressTask?
                    BT_TYPE BT_TASK_TYPE
                    DB #01
                    DW AddressTask? & 0xFFFF
                    endm
BT_Break            macro
                    BT_TYPE BT_BREAK_TYPE
                    endm

                    endif ; ~ _CORE_MODULE_AI_DEFINITION_