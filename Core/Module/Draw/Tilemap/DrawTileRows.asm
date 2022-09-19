
                ifndef _CORE_MODULE_DRAW_TILEMAP_DRAW_ROWS_
                define _CORE_MODULE_DRAW_TILEMAP_DRAW_ROWS_

                module Tilemap
; -----------------------------------------
; отрисовка всех тайлов
; In:
; Out:
; Corrupt:
; Note:
;   устойчивый к прерываниям
; -----------------------------------------
DrawTileRows:   ; инициализация
                LD HL, -2
                ADD HL, SP
                LD (DrawRow.ContainerSP), HL
                RestoreBC
                LD HL, RenderBuffer

                ; расчёт экрана вывода
                EXX
                HiddenScreenAdr D                                               ; получение адреса скрытого экрана
                LD E, #00
                EXX

                ; -----------------------------------------
                ; отрисовка первой 1/3 части экрана
                ; -----------------------------------------
                CALL DrawRow

                rept 3
                EXX
                LD A, E
                ADD A, #20
                LD E, A
                EXX
                CALL DrawRow
                endr

                ; -----------------------------------------
                ; отрисовка второй 1/3 части экрана
                ; -----------------------------------------

                EXX
                LD A, D
                ADD A, #08
                LD D, A
                LD E, #00
                EXX

                CALL DrawRow

                rept 3
                EXX
                LD A, E
                ADD A, #20
                LD E, A
                EXX
                CALL DrawRow
                endr

                ; -----------------------------------------
                ; отрисовка третьей 1/3 части экрана
                ; -----------------------------------------

                EXX
                LD A, D
                ADD A, #08
                LD D, A
                LD E, #00
                EXX

                CALL DrawRow

                rept 3
                EXX
                LD A, E
                ADD A, #20
                LD E, A
                EXX
                CALL DrawRow
                endr

                RET

                display " - Draw Tile Rows: \t\t\t", /A, DrawTileRows, " = busy [ ", /D, $ - DrawTileRows, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_TILEMAP_DRAW_ROWS_
