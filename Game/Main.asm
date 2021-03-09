    
                ifndef _GAME_MAIN_
                define _GAME_MAIN_

                DEVICE ZXSPECTRUM128

                include "Include.inc"

                ORG EntryPointer           
Main:           CALL GameInitialize
                XOR A
                DEC A
                LD (MousePositionFlag), A

                CALL Draw
.MainLoop       HALT
; .Loop           LD A, VK_ENTER
;                 CALL CheckKeyState
;                 JR NZ, .Loop

                LD A, (MousePositionFlag)
                OR A
                JR Z, .MainLoop
                XOR A
                LD (MousePositionFlag), A
                CALL DrawCursor

                JR .MainLoop

GameInitialize: CALL InitMouse
                CALL InitInterrupt
                RET

                include "../Input/Include.inc"
                include "Core.asm"
                include "../Core/Include.inc"
                include "../Utils/Include.inc"
MainLength:     EQU $-EntryPointer

                include "Builder.asm"

                endif ; ~_GAME_MAIN_
