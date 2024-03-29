
                ifndef _CORE_MODULE_UTILS_TILEMAP_SURFACE_PROPERTY_
                define _CORE_MODULE_UTILS_TILEMAP_SURFACE_PROPERTY_

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
;   HL, AF
; Note:
;   requires included memory page
; -----------------------------------------
GetProperty:    LD A, (HL)                                                      ; A - номер тайла
                AND %01111111
                LD L, A
                LD H, HIGH SurfacePropertyPtr
                LD A, (HL)                                                      ; A - характеристика тайла
                
                RET
; -----------------------------------------
; получить коллизию тайла
; In:
;   IX - указывает на структуру FUnit
; Out:
;   A - значение коллизии
; Corrupt:
;   HL, AF
; Note:
; -----------------------------------------
GetCollision:   ; расчёт адреса тайла в тайловой карте
                LD DE, (IX + FUnit.Position)
                CALL Utils.Tilemap.GetAddressTilemap

                CALL GetProperty                                                ; получим свойство тайла
                AND %00001111

                RET
; -----------------------------------------
; получить проходимость тайла
; In:
;   IX - указывает на структуру FUnit
; Out:
;   A - значение проходимости (0 - 100%, 1 - 75%, 2 - 50%, 3 - 25%)
; Corrupt:
; Note:
; -----------------------------------------
GetPassability: EXX

                ; расчёт адреса тайла в тайловой карте
                LD DE, (IX + FUnit.Position)

                SET_PAGE_TILEMAP                                                ; включить страницу тайловой карты
                CALL Utils.Tilemap.GetAddressTilemap

                CALL GetProperty                                                ; получим свойство тайла

                RRA
                RRA
                RRA
                RRA
                AND %00000011

                ; включить страницу массива юнитов
                EX AF, AF'
                SET_PAGE_UNITS_ARRAY                                            ; включить страницу массива юнитов
                EX AF, AF'

                EXX

                RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_TILEMAP_SURFACE_PROPERTY_