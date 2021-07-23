
                    ifndef _CORE_MODULE_UTILS_TILEMAP_
                    define _CORE_MODULE_UTILS_TILEMAP_

                    module Tilemap
; ; -----------------------------------------
; ; расчёт смещения позиции тайла в тайловой карте
; ; In:
; ;   DE - позиция тайла (D - y, E - x)
; ; Out:
; ;   HL - смещение позиции тайла
; ; Corrupt:
; ;   HL, AF
; ; Note:
; ;   requires included memory page
; ; -----------------------------------------
; GetOffsetTilemap:   LD L, D
;                     LD A, (TilemapTableHighAddressRef)
;                     LD H, A
;                     LD A, (HL)
;                     INC H
;                     LD H, (HL)
;                     ADD A, E
;                     LD L, A
;                     RET

; -----------------------------------------
; расчёт адреса тайла в тайловой карте
; In:
;   DE - позиция тайла (D - y, E - x)
; Out:
;   HL - адрес расположения тайла
; Corrupt:
;   HL, BC, AF
; Note:
;   requires included memory page
; -----------------------------------------
GetAddressTilemap:  ;CALL GetOffsetTilemap

                    ; LD BC, TilemapPtr
                    ; ADD HL, BC
                    LD L, D
                    LD A, (TilemapTableHighAddressRef)
                    LD H, A
                    LD A, (HL)
                    INC H
                    LD H, (HL)
                    ADD A, E
                    LD L, A

                    RET

                    endmodule

                    endif ; ~ _CORE_MODULE_UTILS_TILEMAP_