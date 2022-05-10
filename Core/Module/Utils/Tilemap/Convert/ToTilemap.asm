
                ifndef _CORE_MODULE_UTILS_TILEMAP_MOUSE_CONVERT_
                define _CORE_MODULE_UTILS_TILEMAP_MOUSE_CONVERT_

                module Mouse
; -----------------------------------------
; convert mouse position on screen to tilemap location
; In:
; Out:
;   DE - tilemap location (D - y, E - x)
; Corrupt:
;   HL, DE, AF
; Note:
;   requires included memory page
; -----------------------------------------
ToTilemap:      ; initialize
                LD DE, (CursorPositionRef)
                LD HL, TilemapOffsetRef

                ; convert mouse position on screen to tilemap location
                LD A, E
                RRA
                RRA
                RRA
                RRA
                AND %00001111
                ADD A, (HL)
                LD E, A

                INC HL

                LD A, D
                RRA
                RRA
                RRA
                RRA
                AND %00001111
                ADD A, (HL)
                LD D, A

                RET

                endmodule

                endif ; ~ _CORE_MODULE_UTILS_TILEMAP_MOUSE_CONVERT_