
                ifndef _DAMAGE_TANK_CHARACTERISTICS_
                define _DAMAGE_TANK_CHARACTERISTICS_

                module Tank
Characteristics FUnitCharacteristics {
                0x20                                                            ; Cooldown
                RES_EPS_SBIT,                                                   ; Weapon
                0x80,                                                           ; Damage
                0xB0,                                                           ; Armor
                RES_MHB | RES_GSS_IMMUNE | RES_GSL | RES_EPS | RES_EPL | RES_ERL_IMMUNE | RES_ERE | RES_NTA,
                { 1, 0, 0, 10, 1, 2, 3, 6 },                                    ; Resistance
                0x07                                                            ; Distance
                }

                endmodule

                endif ; ~_DAMAGE_TANK_CHARACTERISTICS_
