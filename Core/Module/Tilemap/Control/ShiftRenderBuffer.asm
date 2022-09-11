
                ifndef _CORE_MODULE_TILEMAP_SHIFT_RENDER_BUFFER_
                define _CORE_MODULE_TILEMAP_SHIFT_RENDER_BUFFER_
; -----------------------------------------
; сдвиг очереди отображения в буфере отображения
; In:
; Out:
; Corrupt:
; Note:
;   структура данных рендер буфера
;
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | V  | A2 | A1 | A0 | .. | UP | Q1 | Q0 |
;   +----+----+----+----+----+----+----+----+
;
;   V     - [7]     - флаг необхимости обновления тайла
;   A2-A0 - [6..4]  - номер спрайта для анимации тайла
;   UP      [2]     - флаг, сверху находится что либо (для отражения) ?
;   Q1,Q0   [1,0]   - флаг, очереди обновления экрана.
;
;   при смене экрана двигать Q1 в Q0 в право, с обнулением левого  (0 >> Q1 >> Q0 >> x)
;   бит V всегда сигнализирует о необходимости рендера тайла       (V = Q1 | Q0)
;   если тайл обновляется, он должен обновится в 2х экранах
;   выстовляя бит Q1 в еденицу.
; -----------------------------------------
ShiftRenderBuf: ;
                LD HL, RenderBuffer
                LD B, RenderBufSize

.Loop           LD C, (HL)
                LD A, C
                RRCA
                XOR C
                AND %10000011
                XOR C
                LD (HL), A
                INC L
                DJNZ .Loop

                RET

                display " - Shift Render Buffer: \t", /A, ShiftRenderBuf, " = busy [ ", /D, $ - ShiftRenderBuf, " bytes  ]"

                endif ; ~ _CORE_MODULE_TILEMAP_SHIFT_RENDER_BUFFER_
