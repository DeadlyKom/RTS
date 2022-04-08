
                ifndef _CORE_MODULE_AI_DEFINITION_
                define _CORE_MODULE_AI_DEFINITION_

; Types
BTT_SELECTOR    EQU 0x00
BTT_SEQUENCE    EQU 0x01
BTT_TASK        EQU 0x02
BTT_MASK        EQU %00000011

; behavior tree status
BTS_UNKNOW      EQU 0x00
BTS_SUCCESS     EQU 0x01
BTS_FAILURE     EQU 0x02
BTS_RUNNING     EQU 0x03

; Macros
BT_SELECTOR     macro Parent?, Child?
                DW ((Child? & 0x7F) << 9) | ((Parent? & 0x7F) << 3) | BTT_SELECTOR
                endm
BT_SEQUENCE     macro Parent?, Child?
                DW ((Child? & 0x7F) << 9) | ((Parent? & 0x7F) << 3) | BTT_SEQUENCE
                endm
BT_TASK         macro Parent?, NTask?
                DW ((NTask? & 0x7F) << 9) | ((Parent? & 0x7F) << 3) | BTT_TASK
                endm
BT_IDX          macro Parent?
                DB ((-Parent?) & 0x7F) | (0x00 << 7)
                endm
BT_IDX_BREAK    macro Parent?
                DB ((-Parent?) & 0x7F) | (0x01 << 7)
                endm

                endif ; ~ _CORE_MODULE_AI_DEFINITION_