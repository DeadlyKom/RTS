
                ifndef _CORE_MODULE_AI_UTILS_SURFACE_PROPERTY_
                define _CORE_MODULE_AI_UTILS_SURFACE_PROPERTY_

                module Surface
; -----------------------------------------
; In:
;   IX - pointer to FUnitLocation (2)
; Out:
; Corrupt:
; Note:
;   requires included memory page
; -----------------------------------------

GetPassability: ;
                ; JR $
                EXX

                ; расчёт адреса тайла в тайловой карте
                LD A, (TilemapTableHighAddressRef)
                LD H, A
                LD L, (IX + FUnitLocation.TilePosition.Y)
                LD A, (HL)
                INC H
                LD H, (HL)
                ADD A, (IX + FUnitLocation.TilePosition.X)
                LD L, A
                JR NC, $+3
                INC H

                LD A, (HL)                                  ; A - номер тайла
                AND %01111111
                LD L, A
                LD A, (HighSurfacePropertyRef)
                LD H, A

                LD A, (HL)                                  ; A - характеристика тайла
                RRA
                RRA
                RRA
                RRA
                AND %00000011
                EXX

                RET

                endmodule

                endif ; ~ _CORE_MODULE_AI_UTILS_SURFACE_PROPERTY_