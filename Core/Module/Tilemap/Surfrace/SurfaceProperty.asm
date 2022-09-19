
                ifndef _CORE_MODULE_TILEMAP_SURFACE_PROPERTY_
                define _CORE_MODULE_TILEMAP_SURFACE_PROPERTY_

                module Surface
; -----------------------------------------
; получить свойство тайла из таблицы по ID тайла (FSurfaceBase)
; In:
;   HL - адрес тайла
; Out:
;   A  - свойство тайла
;
;      7    6    5    4    3    2    1    0
;   +----+----+----+----+----+----+----+----+
;   | !A | D  | D1 | D0 | C3 | C2 | C1 | C0 |
;   +----+----+----+----+----+----+----+----+
;
;   A       [7]     - 0 - анимируемый тайл, 1 - тайл не анимируется (инвертный)
;   D       [6]     - разрушаемый
;   D1, D0  [0..1]  - коэффициент замедления
;   C3 - C0 [0..3]  - флаги коллизии
;
;   HL - адрес свойства тайла
;
; Corrupt:
;   HL, AF
; Note:
; -----------------------------------------
GetProperty:    LD A, (HL)                                                      ; A - номер тайла
                AND TILE_ID_MASK
                LD L, A
                LD H, HIGH Adr.Tilemap.Surface
                LD A, (HL)                                                      ; A - свойство тайла
                
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
; GetCollision:   ; расчёт адреса тайла в тайловой карте
;                 LD DE, (IX + FUnit.Position)
;                 CALL Utils.Tilemap.GetAddressTilemap

;                 CALL GetProperty                                                ; получим свойство тайла
;                 AND %00001111

;                 RET
; -----------------------------------------
; получить проходимость тайла
; In:
;   IX - указывает на структуру FUnit
; Out:
;   A - значение проходимости (0 - 100%, 1 - 75%, 2 - 50%, 3 - 25%)
; Corrupt:
; Note:
; -----------------------------------------
; GetPassability: EXX

;                 ; расчёт адреса тайла в тайловой карте
;                 LD DE, (IX + FUnit.Position)

;                 SET_PAGE_TILEMAP                                                ; включить страницу тайловой карты
;                 CALL Utils.Tilemap.GetAddressTilemap

;                 CALL GetProperty                                                ; получим свойство тайла

;                 RRA
;                 RRA
;                 RRA
;                 RRA
;                 AND %00000011

;                 ; включить страницу массива юнитов
;                 EX AF, AF'
;                 SET_PAGE_UNITS_ARRAY                                            ; включить страницу массива юнитов
;                 EX AF, AF'

;                 EXX

;                 RET

                display " - Surface Property : \t\t", /A, GetProperty, " = busy [ ", /D, $ - GetProperty, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_TILEMAP_SURFACE_PROPERTY_
