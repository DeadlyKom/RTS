
                ifndef _MODULE_GAME_ENTRY_POINT_
                define _MODULE_GAME_ENTRY_POINT_
; -----------------------------------------
; точка входа запуск игры
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
EntryPoint:     CALL Initialize
                JP GameLoop

                endif ; ~_MODULE_GAME_ENTRY_POINT_
