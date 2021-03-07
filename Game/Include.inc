
                    ifndef _GAME_INCLUDE_
                    define _GAME_INCLUDE_
                    
                    define TRD_FILENAME "RTS.trd"       ; имя образа TRD
EntryPointer        EQU #5C00                           ; главная точка входа
StackTop            EQU #5BFE                           ; расположение стека

                    include "Main.asm"
                    include "Core.asm"

                    endif ; ~_GAME_INCLUDE_
