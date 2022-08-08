
                                ifndef _CONST_GAME_PLAY_FLAGS_
                                define _CONST_GAME_PLAY_FLAGS_

                                ; активный false
PATHFINDING_QUERY_FLAG          EQU 0x80                                        ; запрос начать поиск пути
PATHFINDING_FLAG                EQU 0x40                                        ; разрешён поиск пути
PATHFINDING_REQUEST_PLAYER_FLAG EQU 0x20                                        ; флаг запроса игроком поиска пути
PATHFINDING_REQUEST_AI_FLAG     EQU 0x10                                        ; флаг запроса ИИ поиска пути
ACTIVATE_PAUSE_MENU_GAME_FLAG   EQU 0x08                                        ; флаг активации пауза игры
SHOW_PAUSE_MENU_GAME_FLAG       EQU 0x04                                        ; отображается меню паузы игры



DURATION_TILE_ANIM  EQU 0x10                                                    ; период одновления тайловой анимаций (1/50)

                                endif ; ~_CONST_GAME_PLAY_FLAGS_
