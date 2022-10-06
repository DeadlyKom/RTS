
                ifndef _BUILDER_GAME_UNIT_CODE_PACK_
                define _BUILDER_GAME_UNIT_CODE_PACK_

                MMU 3, Page.Game.Unit                                           ; 3 bank, Page.Game.Tilemap (0) page
                ORG Adr.Module.Game.UnitCode
                module Game

                display "\'Game Unit Code\' :\t\t\t\t\t-------------------- [ ", /D, SizeUnitCode, " bytes / ", /D, SizeInSectorsUnitCode, " sector(s) ]  [", /D, Page.Game.Unit, "]\t-------------------------------------------------"

BeginUnitCode:   EQU $
                include "Core/Module/Unit/Include.inc"
SizeUnitCode:    EQU $ - BeginUnitCode
SizeInSectorsUnitCode: EQU (SizeUnitCode >> 8) + ((SizeUnitCode % TRDOS.SECTOR_SIZE > 0) & 0x01)

                savetrd TRD_FILENAME, GameUnitCodeNameTRD, BeginUnitCode, SizeUnitCode

                endmodule

                endif ; ~ _BUILDER_GAME_UNIT_CODE_PACK_

