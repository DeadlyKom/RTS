
                ifndef _MODULE_GAME_ENTRY_POINT_
                define _MODULE_GAME_ENTRY_POINT_
; -----------------------------------------
; точка входа запуск игры
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
EntryPoint:     HALT
                CALL Initialize.Core                                            ; инициализация ядра
                CALL Initialize.Level                                           ; инициализация загруженного уровня
                CALL Initialize.Input                                           ; инициализация управления

                JP GameLoop

                endif ; ~_MODULE_GAME_ENTRY_POINT_
