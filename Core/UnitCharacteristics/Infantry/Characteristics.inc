
                ifndef _DAMAGE_INFANTRY_CHARACTERISTICS_
                define _DAMAGE_INFANTRY_CHARACTERISTICS_

                module Infantry
Characteristics FUnitCharacteristics {
                GUNSHOT_LARGE,
                0x08,
                0x10,
                RES_MHB | RES_GSS_IMMUNE | RES_GSL | RES_EPS | RES_EPL | RES_ERL_IMMUNE | RES_ERE | RES_NTA,
                { 1, 0, 0, 10, 1, 2, 3, 6 }
                0x05,
                0x00 }

                endmodule

                endif ; ~_DAMAGE_INFANTRY_CHARACTERISTICS_
