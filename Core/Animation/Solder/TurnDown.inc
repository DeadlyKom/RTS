
                        module Solder
NormalTurn              EQU 2
PossabilityTurn_100     EQU NormalTurn
PossabilityTurn_75      EQU (((NormalTurn * 125) - (NormalTurn * 125 / 100 * 100) > 0) & 0x01) + NormalTurn * 125 / 100         ; NormalTurn * 125 / 100
PossabilityTurn_50      EQU (((NormalTurn * 150) - (NormalTurn * 150 / 100 * 100) > 0) & 0x01) + NormalTurn * 150 / 100         ; NormalTurn * 150 / 100
PossabilityTurn_25      EQU (((NormalTurn * 175) - (NormalTurn * 175 / 100 * 100) > 0) & 0x01) + NormalTurn * 175 / 100         ; NormalTurn * 175 / 100
Down:                   FAnimation PossabilityTurn_100, PossabilityTurn_75, PossabilityTurn_50, PossabilityTurn_25

                        endmodule
