
                ifndef _STRUCTURE_PROJECTILE_
                define _STRUCTURE_PROJECTILE_
SWAP_XY_BIT     EQU 0x07                                                        ; бит отвечающий изменение местами X и Y

SWAP_XY         EQU 1 << SWAP_XY_BIT

                struct FProjectile
Type            DB #00
Speed           DB #00
Counter         DB #00
Location        FLocation16
Direction       FLocation16
Delta           DW #0000
Error           DW #0000
DeltaError      DW #0000

                ends

                endif ; ~_STRUCTURE_PROJECTILE_