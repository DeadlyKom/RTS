
                    ifndef _STRUCTURE_SURFACE_PROPERTY_
                    define _STRUCTURE_SURFACE_PROPERTY_

; collision flags
;                   +----+----+
;                   |    |    |
;                   +----+----+
;                   |    |    |
;                   +----+----+
SCF_NONE            EQU 0x00
;                   +----+----+
;                   |  X |  X |
;                   +----+----+
;                   |    |    |
;                   +----+----+
SCF_UP              EQU 0x01
;                   +----+----+
;                   |    |  X |
;                   +----+----+
;                   |    |  X |
;                   +----+----+
SCF_RIGHT           EQU 0x02
;                   +----+----+
;                   |    |    |
;                   +----+----+
;                   |  X |  X |
;                   +----+----+
SCF_DOWN            EQU 0x04
;                   +----+----+
;                   |  X |    |
;                   +----+----+
;                   |  X |    |
;                   +----+----+
SCF_LEFT            EQU 0x08

; deceleration ratio
SDR_0_PERCENT       EQU 0x00 << 4
SDR_25_PERCENT      EQU 0x01 << 4
SDR_50_PERCENT      EQU 0x02 << 4
SDR_75_PERCENT      EQU 0x03 << 4

SP_DESTRUCTIBLE     EQU 0x80                        ; is object can be destroyed


                    struct FSurface                 ;
Property            DB #00                          ; 1 bytes

                    ends

                    endif ; ~_STRUCTURE_SURFACE_PROPERTY_