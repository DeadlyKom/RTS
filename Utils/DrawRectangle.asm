
                ifndef _UTILS_DRAW_RECTANGLE_
                define _UTILS_DRAW_RECTANGLE_

; -----------------------------------------
; draw rectangle
; In:
; Out:
; Corrupt:
;   HL, DE, BC, HL', DE', BC'
; -----------------------------------------
DrawRectangle:  ; HL  - (H - y, L - x) start point    (S)
                ; DE  - (D - y, E - x) end point      (E)

                LD A, #03
                LD (FrameUnitsFlagRef), A

                LD HL, (CursorPositionRef)
                LD (.End), HL

                LD HL, (.Start)
                LD D, H
                LD A, (.End)
                LD E, A
                PUSH DE
                CALL DrawLine
                POP DE
                LD HL, (.End)
                PUSH HL
                CALL DrawLine
                POP HL
                LD D, H
                LD A, (.Start)
                LD E, A
                PUSH DE
                CALL DrawLine
                POP DE
                LD HL, (.Start)
                JP DrawLine         

.Start          DW #0613
.End            DW #75A3

                endif ; ~_UTILS_DRAW_RECTANGLE_