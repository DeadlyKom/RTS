
                ifndef _CORE_MODULE_UTILS_RECONNAISSANCE_
                define _CORE_MODULE_UTILS_RECONNAISSANCE_

                module Tilemap
Reconnaissance: ;JR $

                DEC IXH                                     ; FUnitTargets      (3)
                DEC IXH                                     ; FUnitLocation     (2)

                LD E, (IX + FUnitLocation.TilePosition.X)
                LD D, (IX + FUnitLocation.TilePosition.Y)

                ; -----

                ; X + 0, Y + 0
                CALL GetAdrTilemap
                RES 7, (HL)

                ; X - 1, Y + 0
                DEC E
                CALL GetAdrTilemap
                RES 7, (HL)

                ; X - 2, Y + 0
                DEC E
                CALL GetAdrTilemap
                RES 7, (HL)

                ; X + 1, Y + 0
                INC E
                INC E
                INC E
                CALL GetAdrTilemap
                RES 7, (HL)

                ; X + 2, Y + 0
                INC E
                CALL GetAdrTilemap
                RES 7, (HL)

                ; -----

                ; X + 1, Y - 1
                DEC E
                DEC D
                CALL GetAdrTilemap
                RES 7, (HL)

                ; X + 0, Y - 1
                DEC E
                CALL GetAdrTilemap
                RES 7, (HL)

                ; X - 1, Y - 1
                DEC E
                CALL GetAdrTilemap
                RES 7, (HL)

                ; -----

                ; X + 0, Y - 1
                INC E
                DEC D
                CALL GetAdrTilemap
                RES 7, (HL)

                ; -----

                ; X + 0, Y + 1
                INC D
                INC D
                INC D
                CALL GetAdrTilemap
                RES 7, (HL)

                ; X - 1, Y + 1
                DEC E
                CALL GetAdrTilemap
                RES 7, (HL)

                ; X + 1, Y + 1
                INC E
                INC E
                CALL GetAdrTilemap
                RES 7, (HL)

                ; -----

                ; X + 0, Y - 2
                DEC E
                INC D
                CALL GetAdrTilemap
                RES 7, (HL)

                INC IXH                                     ; FUnitTargets      (3)
                INC IXH                                     ; FUnitAnimation    (4)

                RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_RECONNAISSANCE_