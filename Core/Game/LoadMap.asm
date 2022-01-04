
                ifndef _CORE_GAME_LOAD_MAP_
                define _CORE_GAME_LOAD_MAP_

LoadMap:        ; загрузка информации о карте
                SET_PAGE_FILE_SYS
                LD A, #00                                                       ; 0 слот карты
                CALL FileSystem.Load.MapInfo

                ; инициализация карты
                CALL Initialize.MapInfo

                ; загрузка карты
                CALL FileSystem.Load.MapData

                RET

                endif ; ~_CORE_GAME_INITIALIZE_
