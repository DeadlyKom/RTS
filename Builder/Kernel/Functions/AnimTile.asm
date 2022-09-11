
                ifndef _BUILDER_KERNEL_MODULE_ANIM_TILE_
                define _BUILDER_KERNEL_MODULE_ANIM_TILE_
; -----------------------------------------
; обновление тайлов
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
AnimTile:       ; инициализация
                SET_PAGE_TILEMAP                                                ; включить страницу тайловой карты
                JP Game.Tilemap.AnimTile

                display "\t - Anim Tile : \t\t", /A, AnimTile, " = busy [ ", /D, $ - AnimTile, " bytes  ]"

                endif ; ~ _BUILDER_KERNEL_MODULE_ANIM_TILE_