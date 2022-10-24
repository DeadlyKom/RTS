
                ifndef _BUILDER_GAME_PACK_
                define _BUILDER_GAME_PACK_

                MMU 1, Page.Game.Main                                           ; 1 bank, Page.Game.Main (5) page
                ORG Adr.Module.Game.Main
                module Game

                display "\'Game Main\' :\t\t\t\t\t\t-------------------- [ ", /D, SizeMain, " bytes / ", /D, SizeInSectorsF, " sector(s) ]  [", /D, Page.Game.Main, "]\t-------------------------------------------------"

BeginMain:      EQU $
                include "Core/Module/Game/Include.inc"
                include "Core/Module/Tables/Graphics/Cursor/CursorInfo.inc"     ; пока это тут табличка
                include "Core/Module/Tables/Graphics/Infantry/MoveInfo.inc"     ; пока это тут табличка
SizeMain:       EQU $ - BeginMain
SizeInSectorsF: EQU (SizeMain >> 8) + ((SizeMain % TRDOS.SECTOR_SIZE > 0) & 0x01)

                savetrd TRD_FILENAME, GameMainNameTRD, BeginMain, SizeMain

                endmodule

                endif ; ~ _BUILDER_GAME_PACK_

