
                    ifndef _CORE_MODULE_UTILS_TILEMAP_
                    define _CORE_MODULE_UTILS_TILEMAP_

                    module Tilemap
; -----------------------------------------
; расчёт адреса тайла в тайловой карте
; In:
;   DE - позиция тайла (D - y, E - x)
; Out:
;   HL - адрес расположения тайла
; Corrupt:
;   HL, AF
; Note:
;   requires included memory page
; -----------------------------------------
GetAddressTilemap:  LD L, D
                    LD H, HIGH TilemapTableAddress
                    LD A, (HL)
                    INC H
                    LD H, (HL)
                    ADD A, E
                    LD L, A

                    RET

                    endmodule

                    endif ; ~ _CORE_MODULE_UTILS_TILEMAP_