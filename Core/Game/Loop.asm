
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
                ; toggle to memory page with tile sprites
                SeMemoryPage MemoryPage_TilSprites

                ;
                ; LD A, #02
                ; OUT (#FE), A
                ;
                CALL Tilemap.Display
                CALL Tilemap.FOW

                ; LD A, #01
                ; OUT (#FE), A
                ;
                LD A, #FF
                LD (CoreStateRef), A
.SomeWork
                JR .MainLoop

                endif ; ~_CORE_GAME_LOOP_
