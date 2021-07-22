
                ifndef _CORE_MODULE_UTILS_SURFACE_PROPERTY_
                define _CORE_MODULE_UTILS_SURFACE_PROPERTY_

                module Surface
; -----------------------------------------
; получить свойство тайла
; In:
;   HL - адрес тайла
; Out:
;   A - свойство тайла
;
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   |  D | -- | D1 | D0 | C3 | C2 | C1 | C0 |
;   +----+----+----+----+----+----+----+----+
;
;   D        - destructible
;   D [0..1] - deceleration ratio
;   C [0..3] - collision flags
;
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
GetProperty:    LD A, (HL)                                  ; A - номер тайла
                AND %01111111
                LD L, A
                LD A, (HighSurfacePropertyRef)
                LD H, A
                LD A, (HL)                                  ; A - характеристика тайла
                
                RET

; -----------------------------------------
; получить проходимость тайла
; In:
;   IX - pointer to FUnitLocation (2)
; Out:
;   A - значение проходимости (0 - 100%, 1 - 75%, 2 - 50%, 3 - 25%)
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------
GetPassability: EXX

                ; расчёт адреса тайла в тайловой карте
                LD DE, (IX + FUnitLocation.TilePosition)
                CALL Utils.Tilemap.GetAdrTilemap

                CALL GetProperty                            ; получим свойство тайла

                RRA
                RRA
                RRA
                RRA
                AND %00000011

                EXX

                RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_SURFACE_PROPERTY_