
                ifndef _CORE_MODULE_AI_DEFINITION_
                define _CORE_MODULE_AI_DEFINITION_

; node types
BTT_NONE        EQU 0x00 << 6
BTT_SELECTOR    EQU 0x01 << 6
BTT_SEQUENCE    EQU 0x02 << 6
BTT_TASK        EQU 0x03 << 6

; behavior tree status
BTS_RUNNING     EQU 0x00 << 6
BTS_SUCCESS     EQU 0x01 << 6
BTS_FAILURE     EQU 0x02 << 6
BTS_UNKNOW      EQU 0x03 << 6

; internal flags of behavior tree
BTF_ROOT_BIT    EQU 0x06
BTF_LAST_BIT    EQU 0x07

BTF_NONE        EQU 0x00
BTF_ROOT        EQU 1 << BTF_ROOT_BIT                                           ; флаг указывающий, что узел является рутом
BTF_LAST        EQU 1 << BTF_LAST_BIT                                           ; флаг указывающий, что узел последний в списке

BT_TYPE_MASK    EQU %11000000
BT_INDEX_MASK   EQU %00111111
BT_TASK_MASK    EQU %00111111
BT_STATE_MASK   EQU %11000000
; -----------------------------------------
; 
;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;   | 15 | 14 | 13 | 12 | 11 | 10 |  9 |  8 |   |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;   | T1 | T0 | P5 | P4 | P3 | P2 | P1 | P0 |   | F1 | F0 | C5 | C4 | C3 | C2 | C1 | C0 |
;   +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
;
;   T0, T1  - node type
;   F0, F1  - internal flags of behavior tree
;   C0 - C5 - index child
;   P0 - P5 - index parent
;
; -----------------------------------------

; Macros
BT_SELECTOR     macro Parent?, Child?, Flags?
                DB (Child?  & 0x3F) | Flags?
                DB (Parent? & 0x3F) | BTT_SELECTOR
                endm
BT_SEQUENCE     macro Parent?, Child?, Flags?
                DB (Child?  & 0x3F) | Flags?
                DB (Parent? & 0x3F) | BTT_SEQUENCE
                endm
BT_TASK         macro Parent?, NTask?, Flags?
                DB (NTask?  & 0x3F) | Flags?
                DB (Parent? & 0x3F) | BTT_TASK
                endm

                endif ; ~ _CORE_MODULE_AI_DEFINITION_
