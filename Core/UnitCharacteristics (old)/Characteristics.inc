
                ifndef _DAMAGE_WEAPON_
                define _DAMAGE_WEAPON_

                DISP #0000
UnitCharacteristicsTable:
                DW Infantry.Characteristics - $
                DW Tank.Characteristics - $

                include "Infantry/Characteristics.inc"
                include "Tank/Characteristics.inc"

                ENT

                endif ; ~_DAMAGE_WEAPON_
