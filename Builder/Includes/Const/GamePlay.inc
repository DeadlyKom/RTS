
                ifndef _CONST_GAMEPLAY_
                define _CONST_GAMEPLAY_
DURATION_TILE_ANIM      EQU 0x09                                                ; период обновления тайловой анимаций (1/50)
DURATION_FLY_ANIM       EQU 0x03                                                ; период обновления анимаций полёта (1/50)
DURATION_IDLE_CURSOR    EQU 0xFA                                                ; продолжительность простоя курсора (1/50)
DURATION_TILEMAP_SCROLL EQU 0x02                                                ; продолжительность простоя при скроле тайловой карты (1/50)

                                ; активный false
; PATHFINDING_QUERY_FLAG          EQU 0x80                                        ; запрос начать поиск пути
; PATHFINDING_FLAG                EQU 0x40                                        ; разрешён поиск пути
; PATHFINDING_REQUEST_PLAYER_FLAG EQU 0x20                                        ; флаг запроса игроком поиска пути
; PATHFINDING_REQUEST_AI_FLAG     EQU 0x10                                        ; флаг запроса ИИ поиска пути
; ACTIVATE_PAUSE_MENU_GAME_FLAG   EQU 0x08                                        ; флаг активации пауза игры
; SHOW_PAUSE_MENU_GAME_FLAG       EQU 0x04                                        ; отображается меню паузы игры

                endif ; ~_CONST_GAMEPLAY_
