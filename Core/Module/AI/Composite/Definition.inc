
                ifndef _CORE_MODULE_AI_DEFINITION_
                define _CORE_MODULE_AI_DEFINITION_
BT_SELECTOR     macro Parent?, Child?
                DB (Child?  % 0x7F) | (0x00 << 7)
                DB (Parent? % 0x7F) | (0x00 << 7)
                endm
BT_SEQUENCE     macro Parent?, Child?
                DB (Child?  % 0x7F) | (0x00 << 7)
                DB (Parent? % 0x7F) | (0x01 << 7)
                endm
BT_TASK         macro Parent?, NTask?
                DB (NTask?  % 0x7F) | (0x01 << 7)
                DB (Parent? % 0x7F) | (0x00 << 7)
                endm
BT_IDX          macro Parent?
                DB (Parent? % 0x7F) | (0x00 << 7)
                endm
BT_IDX_BREAK    macro Parent?
                DB (Parent? % 0x7F) | (0x01 << 7)
                endm

                endif ; ~ _CORE_MODULE_AI_DEFINITION_