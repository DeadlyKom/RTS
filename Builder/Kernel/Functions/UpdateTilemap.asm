
                ifndef _BUILDER_KERNEL_MODULE_UPDATE_TILEMAP_
                define _BUILDER_KERNEL_MODULE_UPDATE_TILEMAP_
; -----------------------------------------
; обновление карты, буферы тайловой карты и рендера
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
UpdateTilemap:  ; инициализация
                SET_PAGE_TILEMAP                                                ; включить страницу тайловой карты
                JP Game.Tilemap.UpdateTilemap

                display "\t - Update TilemapBuf : \t\t\t\t", /A, UpdateTilemap, " = busy [ ", /D, $ - UpdateTilemap, " bytes  ]"

                endif ; ~ _BUILDER_KERNEL_MODULE_UPDATE_TILEMAP_
