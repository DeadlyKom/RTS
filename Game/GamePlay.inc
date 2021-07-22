
                                ifndef _GAME_PLAY_FLAGS_INCLUDE_
                                define _GAME_PLAY_FLAGS_INCLUDE_
; активный false
PATHFINDING_QUERY_FLAG          EQU 0x80            ; запрос начать поиск пути
PATHFINDING_FLAG                EQU 0x40            ; разрешён поиск пути
PATHFINDING_REQUEST_PLAYER_FLAG EQU 0x20            ; флаг запроса игроком поиска пути
PATHFINDING_REQUEST_AI_FLAG     EQU 0x10            ; флаг запроса ИИ поиска пути
ACTIVATE_PAUSE_MENU_GAME_FLAG   EQU 0x08            ; флаг активации пауза игры
SHOW_PAUSE_MENU_GAME_FLAG       EQU 0x04            ; отображается меню паузы игры

                                endif ; ~_GAME_PLAY_FLAGS_INCLUDE_