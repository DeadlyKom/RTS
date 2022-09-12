
                ifndef _BUILDER_KERNEL_MODULE_ANIM_TILE_
                define _BUILDER_KERNEL_MODULE_ANIM_TILE_
; -----------------------------------------
; обновление тайлов
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
AnimTile:       ; сохранеие текущей страницы
                LD A, (MemoryPageRef)
                LD (.RestoreMemPage), A

                ; инициализация
                SET_PAGE_TILEMAP                                                ; включить страницу тайловой карты
                CALL Game.Tilemap.AnimTile

                ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage
; ; -----------------------------------------
; ; выборка тайлов для анимации
; ; In:
; ; Out:
; ; Corrupt:
; ; Note:
; ; -----------------------------------------
; Sampling:       ; сохранеие текущей страницы
;                 LD A, (MemoryPageRef)
;                 LD (.RestoreMemPage), A

;                 ; инициализация
;                 SET_PAGE_TILEMAP                                                ; включить страницу тайловой карты
;                 CALL Game.Tilemap.Sampling

;                 ; востановление страницы
; .RestoreMemPage EQU $+1
;                 LD A, #00
;                 JP SetPage

                display "\t - Anim Tile : \t\t", /A, AnimTile, " = busy [ ", /D, $ - AnimTile, " bytes  ]"

                endif ; ~ _BUILDER_KERNEL_MODULE_ANIM_TILE_