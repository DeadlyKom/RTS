
                                ifndef _GAME_PLAY_FLAGS_INCLUDE_
                                define _GAME_PLAY_FLAGS_INCLUDE_
PATHFINDING_QUERY_FLAG          EQU 0x80            ; запрос начать поиск пути
PATHFINDING_FLAG                EQU 0x40            ; разрешён поиск пути
PATHFINDING_REQUEST_PLAYER_FLAG EQU 0x20            ; флаг запроса игроком поиска пути
PATHFINDING_REQUEST_AI_FLAG     EQU 0x10            ; флаг запроса ИИ поиска пути

                                endif ; ~_GAME_PLAY_FLAGS_INCLUDE_