
                        module Infantry
MoveNormal              EQU 0
PossabilityMove_100     EQU MoveNormal
PossabilityMove_75      EQU 1;(((MoveNormal * 125) - (MoveNormal * 125 / 100 * 100) > 0) & 0x01) + MoveNormal * 125 / 100         ; MoveNormal * 125 / 100
PossabilityMove_50      EQU 2;(((MoveNormal * 150) - (MoveNormal * 150 / 100 * 100) > 0) & 0x01) + MoveNormal * 150 / 100         ; MoveNormal * 150 / 100
PossabilityMove_25      EQU 3;(((MoveNormal * 175) - (MoveNormal * 175 / 100 * 100) > 0) & 0x01) + MoveNormal * 175 / 100         ; MoveNormal * 175 / 100
Move:                   FAnimation PossabilityMove_100, PossabilityMove_75, PossabilityMove_50, PossabilityMove_25

                        endmodule
