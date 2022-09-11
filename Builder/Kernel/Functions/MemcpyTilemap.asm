
                ifndef _BUILDER_KERNEL_MODULE_MEMORY_COPY_TILEMAP_
                define _BUILDER_KERNEL_MODULE_MEMORY_COPY_TILEMAP_
; -----------------------------------------
; копирование видимой части тайловой карты в буфер
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MemcpyTilemap:  ; инициализация
                SET_PAGE_TILEMAP                                                ; включить страницу тайловой карты
                JP Game.Tilemap.Memcpy.Buffer

                display "\t - Memcpy TilemapBuf : \t", /A, MemcpyTilemap, " = busy [ ", /D, $ - MemcpyTilemap, " bytes  ]"

                endif ; ~ _BUILDER_KERNEL_MODULE_MEMORY_COPY_TILEMAP_