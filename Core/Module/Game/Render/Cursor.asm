
                ifndef _MODULE_GAME_RENDER_CURSOR_
                define _MODULE_GAME_RENDER_CURSOR_
; -----------------------------------------
; отображение игрового курсора
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawCursor:     ;
                LD HL, Table.Table_S_R
                LD (GameVar.PrepareTable), HL

                ;
                LD HL, Table.Table_LD_OX
                LD (GameVar.PrepareTable), HL

                ; установка флага порчи фона под курсором
                SET_RENDER_FLAG RESTORE_CURSOR_BIT

                RET
; -----------------------------------------
; восстановление фона под игровым курсором
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
RestoreCursor:  ;
                LD HL, Table.Table_S_R
                LD (GameVar.PrepareTable), HL

                ;
                LD HL, Table.Table_LD_OX
                LD (GameVar.PrepareTable), HL

                ; сброс флага востановления фона под курсором
                RES_RENDER_FLAG RESTORE_CURSOR_BIT

                RET

                endif ; ~_MODULE_GAME_RENDER_CURSOR_
