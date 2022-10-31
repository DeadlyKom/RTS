
                    ifndef _CORE_MODULE_UTILS_TILEMAP_GET_ADDRESS_
                    define _CORE_MODULE_UTILS_TILEMAP_GET_ADDRESS_

; -----------------------------------------
; расчёт адреса тайла в тайловой карте
; In:
;   DE - позиция тайла (D - y, E - x)
; Out:
;   HL - адрес расположения тайла
; Corrupt:
;   HL, AF
; Note:
;   требуется установить страницу карты
; -----------------------------------------
GetAddressTilemap:  LD L, D
                    LD H, HIGH TilemapTableAddress
                    LD A, (HL)
                    INC H
                    LD H, (HL)
                    ADD A, E
                    LD L, A

                    RET
; -----------------------------------------
; расчёт адреса тайла в тайловой карте
; In:
;   DE - позиция тайла (D - y, E - x)
; Out:
;   HL - адрес расположения тайла
; Corrupt:
;   HL, AF
; Note:
;   требуется установить страницу карты
; -----------------------------------------
AddressTilemap:     macro
                    LD L, D
                    LD H, HIGH TilemapTableAddress
                    LD A, (HL)
                    INC H
                    LD H, (HL)
                    ADD A, E
                    LD L, A
                    endm

                    endif ; ~ _CORE_MODULE_UTILS_TILEMAP_GET_ADDRESS_