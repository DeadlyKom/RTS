
				ifndef _STRUCT_SURFACE_PROPERTY_
				define _STRUCT_SURFACE_PROPERTY_

; флаги коллизии
;                   +----+----+
;                   |    |    |
;                   +----+----+
;                   |    |    |
;                   +----+----+
SCF_NONE        EQU 0x00

;                   +----+----+
;                   |  X |  X |
;                   +----+----+
;                   |    |    |
;                   +----+----+
SCF_UP          EQU 0x01

;                   +----+----+
;                   |    |  X |
;                   +----+----+
;                   |    |  X |
;                   +----+----+
SCF_RIGHT       EQU 0x02

;                   +----+----+
;                   |    |    |
;                   +----+----+
;                   |  X |  X |
;                   +----+----+
SCF_DOWN        EQU 0x04

;                   +----+----+
;                   |  X |    |
;                   +----+----+
;                   |  X |    |
;                   +----+----+
SCF_LEFT        EQU 0x08

SCF_MASK        EQU SCF_UP | SCF_RIGHT | SCF_DOWN | SCF_LEFT
SCF_BLOCK       EQU SCF_UP | SCF_RIGHT | SCF_DOWN | SCF_LEFT

; коэффициент замедления
SDR_0_PERCENT   EQU 0x00 << 4
SDR_25_PERCENT  EQU 0x01 << 4
SDR_50_PERCENT  EQU 0x02 << 4
SDR_75_PERCENT  EQU 0x03 << 4

; флаги
SP_DESTRUCT_BIT EQU 0x07                                                        ; бит разрушаемости тайла
SP_ANIM_BIT     EQU 0x06                                                        ; бит тайла с анимацией

SP_DESTRUCT     EQU 1 << SP_DESTRUCT_BIT
SP_ANIM         EQU 1 << SP_ANIM_BIT

                struct FSurface
;
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | D  | A  | D1 | D0 | C3 | C2 | C1 | C0 |
;   +----+----+----+----+----+----+----+----+
;
;   D       [7]     - разрушаемый
;   A       [6]     - тайл с анимацией
;   D1, D0  [0..1]  - коэффициент замедления
;   C3 - C0 [0..3]  - флаги коллизии
;
Property        DB #00

                ends

                endif ; ~_STRUCT_SURFACE_PROPERTY_
