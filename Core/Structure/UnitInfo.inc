
                    ifndef _STRUCTURE_UNIT_
                    define _STRUCTURE_UNIT_

                    include "Base.inc"

; unit types
Infantry            EQU #01
Ganner              EQU #02
HeavyGunner         EQU #03
Sniper              EQU #04
Engineer            EQU #05
ArmoredCarrier      EQU #06
Tank                EQU #07

; -------------------- Unit --------------------

                    struct FUnit
Type                DB #00                          ; 1 byte
Health              DB #00                          ; 1 byte
Status              DB #00                          ; 1 byte
AnimationIndex      DB #00                          ; 1 byte
Location            FLocation                       ; 2 bytes
PixelOffset         FLocation                       ; 2 bytes
PathFinding         FPathFindingStack               ; 8 bytes

                    ends

                    endif ; ~_STRUCTURE_UNIT_