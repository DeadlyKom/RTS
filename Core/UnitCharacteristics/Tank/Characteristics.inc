
                ifndef _DAMAGE_TANK_CHARACTERISTICS_
                define _DAMAGE_TANK_CHARACTERISTICS_

                module Tank
Characteristics FUnitCharacteristics {
                GUNSHOT_LARGE,
                0x80,
                0xA0,
                RES_MHB | RES_GSS_IMMUNE | RES_GSL | RES_EPS | RES_EPL | RES_ERL_IMMUNE | RES_ERE | RES_NTA,
                { 1, 0, 0, 10, 1, 2, 3, 6 }
                0x05,
                0x20 }

                endmodule

                endif ; ~_DAMAGE_TANK_CHARACTERISTICS_
