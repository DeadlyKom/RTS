    
            ifndef _GAME_MAIN_
            define _GAME_MAIN_

            include "Include.inc"

            module Main

            ORG EntryPointer
Main:       

            JR $
MainLength: EQU $-EntryPointer

            endmodule

            endif ; ~_GAME_MAIN_
