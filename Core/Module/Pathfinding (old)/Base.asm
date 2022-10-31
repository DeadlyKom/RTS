
                ifndef _CORE_MODULE_PATHFINDING_BASE_
                define _CORE_MODULE_PATHFINDING_BASE_
Begin:          ; добавим новые юниты в очередь поиска пути
                
                ; проверим что очередь не пустая
                CALL Pathfinding.Queue.IsEmpty
                JR C, .Allow                                                    ; если очередь пуста, продолжим работу

                ;
                CheckGameplayFlag PATHFINDING_REQUEST_PLAYER_FLAG
                JR NZ, .Allow                                                   ; если запрос не производился, продолжим работу
                CALL AStar.SearchPath

                CALL Pathfinding.Queue.IsEmpty
                JR C, .Allow                                                    ; если очередь пуста, продолжим работу

                ; запуск следующего поиска
                ResetGameplayFlag (PATHFINDING_QUERY_FLAG | PATHFINDING_REQUEST_PLAYER_FLAG)
                SetGameplayFlag (PATHFINDING_FLAG)
                RET

.Allow          ; разрешить поиск
                SetGameplayFlag (PATHFINDING_FLAG | PATHFINDING_REQUEST_PLAYER_FLAG) 

                RET

                endif ; ~ _CORE_MODULE_PATHFINDING_BASE_