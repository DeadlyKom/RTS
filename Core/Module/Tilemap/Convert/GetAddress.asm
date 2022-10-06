
                ifndef _CORE_MODULE_TILEMAP_GET_ADDRESS_
                define _CORE_MODULE_TILEMAP_GET_ADDRESS_
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
GetAdrTilemap:  LD H, HIGH Adr.Tilemap.AdrTable
                LD L, D
                LD A, (HL)
                ADD A, E
                SET 7, L
                LD H, (HL)
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
AdrTilemap:     macro
                LD H, HIGH Adr.Tilemap.AdrTable
                LD L, D
                LD A, (HL)
                ADD A, E
                SET 7, L
                LD H, (HL)
                LD L, A
                endm

                display " - Get Address Tilemap : \t\t\t\t", /A, GetAdrTilemap, " = busy [ ", /D, $ - GetAdrTilemap, " bytes  ]"

                endif ; ~ _CORE_MODULE_UTILS_TILEMAP_GET_ADDRESS_
