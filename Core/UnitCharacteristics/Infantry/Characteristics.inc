
                ifndef _DAMAGE_INFANTRY_CHARACTERISTICS_
                define _DAMAGE_INFANTRY_CHARACTERISTICS_

                module Infantry
Characteristics FUnitCharacteristics {
                0x00,                                                           ; Cooldown
                RES_GSL_SBIT,                                                   ; Weapon
                0x08,                                                           ; Damage
                0x10,                                                           ; Armor
                RES_MHB | RES_GSS_IMMUNE | RES_GSL | RES_EPS | RES_EPL | RES_ERL_IMMUNE | RES_ERE | RES_NTA,
                { 1, 0, 0, 10, 1, 2, 3, 6 },                                    ; Resistance
                0x06                                                            ; Distance
                }

                endmodule

                endif ; ~_DAMAGE_INFANTRY_CHARACTERISTICS_
