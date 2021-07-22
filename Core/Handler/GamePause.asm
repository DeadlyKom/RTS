
                ifndef _CORE_HANDLER_GAME_PAUSE_
                define _CORE_HANDLER_GAME_PAUSE_
ShowGamePause:  
                ; JR $

                GetCurrentScreen
                LD A, MemoryPage_ShadowScreen
                JR Z, $+4
                LD A, MemoryPage_MainScreen

                SeMemoryPage_A GAME_PAUSE_MENU_ID
                CALL FadeoutScreen
                CALL DrawGamePause
                SwapScreens
                JR InputGamePause

FadeoutScreen:  LD HL, #C000
                LD DE, #AA55
                LD BC, #0018

.Loop           LD A, D
                LD D, E
                LD E, A
                
.LoopRow        LD A, (HL)
                AND E
                LD (HL), A
                INC HL
                DJNZ .LoopRow

                DEC C
                JR NZ, .Loop

                RET
DrawGamePause:  RET
InputGamePause: ;JR $

                LD A, VK_3
                CALL Input.CheckKeyState
                JR NZ, InputGamePause

                ; CALL Tilemap.Prepare
                CALL Tilemap.ForceScreen
                ; ResetFrameFlag SWAP_SCREENS_FLAG
                ; SwapScreens
                ResetAIFlag GAME_PAUSE_FLAG
                RET

                endif ; ~_CORE_HANDLER_GAME_PAUSE_
