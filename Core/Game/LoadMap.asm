
                ifndef _CORE_GAME_LOAD_MAP_
                define _CORE_GAME_LOAD_MAP_

LoadMap:        ; загрузка информации о карте
                SET_PAGE_FILE_SYS
                CALL FileSystem.Load.MapInfo

                ; инициализация карты
                CALL Initialize.Map

                RET

                endif ; ~_CORE_GAME_INITIALIZE_
