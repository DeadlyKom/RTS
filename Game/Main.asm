    
                ifndef _GAME_MAIN_
                define _GAME_MAIN_

                DEVICE ZXSPECTRUM128

                include "Include.inc"

                ORG EntryPointer           
Main:           CALL Draw

                JR $

                include "Core.asm"
MainLength:     EQU $-EntryPointer

                include "Builder.asm"

                endif ; ~_GAME_MAIN_
