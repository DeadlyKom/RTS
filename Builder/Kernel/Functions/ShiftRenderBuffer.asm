
                ifndef _BUILDER_KERNEL_MODULE_SHIFT_RENDER_BUFFER_
                define _BUILDER_KERNEL_MODULE_SHIFT_RENDER_BUFFER_
; -----------------------------------------
; обновление тайлов
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ShiftRenderBuf: ; сохранеие текущей страницы
                LD A, (MemoryPageRef)
                LD (.RestoreMemPage), A

                ; инициализация
                SET_PAGE_TILEMAP                                                ; включить страницу тайловой карты
                CALL Game.Tilemap.ShiftRenderBuf

                ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

                display "\t - Shift Render Buf : \t", /A, ShiftRenderBuf, " = busy [ ", /D, $ - ShiftRenderBuf, " bytes  ]"

                endif ; ~ _BUILDER_KERNEL_MODULE_SHIFT_RENDER_BUFFER_