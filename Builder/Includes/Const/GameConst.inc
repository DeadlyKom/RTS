
ANIM_INDEX_NONE     EQU 0xFF
ANIM_INDEX_0        EQU 0x00
ANIM_INDEX_1        EQU 0x01
ANIM_INDEX_2        EQU 0x02
ANIM_INDEX_3        EQU 0x03
GAMEPLAY_BIT        EQU 0x01                                                    ; флаг базового старта миссии
                                                                                ; 0 - нормальный старт со слота StartSlotA
                                                                                ; 1 - режим защиты старт со слота StartSlotB
GAMEPLAY_BASE       EQU 0x00
GAMEPLAY_PROTECT    EQU 1 << GAMEPLAY_BIT
