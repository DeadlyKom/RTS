
                ifndef _CORE_DISPLAY_TILEMAP_FOW_
                define _CORE_DISPLAY_TILEMAP_FOW_
; -----------------------------------------
; display fog of war
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC', AF'
; Note:
;   requires included memory page 7
; -----------------------------------------
FOW:            ; show debug border
                ifdef SHOW_DEBUG_BORDER_FOW
                LD A, RENDER_FOW_COLOR
                OUT (#FE), A
                endif
                
                RET

                endif ; ~_CORE_DISPLAY_TILEMAP_FOW_
