
                ifndef _CORE_GAME_LOOP_
                define _CORE_GAME_LOOP_
GameLoop:       ;
                XOR A
                LD (CoreStateRef), A
.MainLoop       ;
                LD A, (CoreStateRef)
                OR A
                JR NZ, .SomeWork
                ;
                CALL Tilemap.Display
                ;
                LD A, #FF
                LD (CoreStateRef), A
.SomeWork
                JR .MainLoop

                endif ; ~_CORE_GAME_LOOP_
